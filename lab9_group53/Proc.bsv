/*

Copyright (C) 2012 Muralidaran Vijayaraghavan <vmurali@csail.mit.edu>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/


import Types::*;
import ProcTypes::*;
import MemTypes::*;
import RFile::*;
import MemoryFar::*;
import Decode::*;
import Exec::*;
import Cop::*;
import Fifo::*;
import Scoreboard::*;
import AddrPred::*;
import DirPred::*;
import Connectable::*;
import LocalCache::*;

typedef struct {
  Addr pc;
  Addr ppc;
  Bool dEpoch;
  Bool eEpoch;
  Data inst;
} Fetch2Decode deriving (Bits, Eq);

typedef struct {
  Addr pc;
  Addr ppc;
  Bool epoch;
  DecodedInst dInst;
} Decode2RegRead deriving (Bits, Eq);

typedef struct {
  Addr pc;
  Addr ppc;
  Bool epoch;
  DecodedInst dInst;
  Data rVal1;
  Data rVal2;
  Data copVal;
} RegRead2Exec deriving (Bits, Eq);

typedef struct {
  Bool poisoned;
  IType iType;
  Maybe#(FullIndx) dst;
  Data data;
  Addr addr;
} Exec2Mem deriving (Bits, Eq);

typedef struct {
  Bool poisoned;
  Maybe#(FullIndx) dst;
  Data data;
} Mem2Wb deriving (Bits, Eq);

(* synthesize *)
module [Module] mkProc(Proc);
  Reg#(Addr) pc <- mkRegU;
  RFile      rf <- mkRFile;
  Memory    mem <- mkMemory;
  Cop       cop <- mkCop;
  AddrPred pcPred <- mkBtb;
  DirPred  dirPred <- mkCounterPred2Bit;
  
  Fifo#(2, Fetch2Decode)   f2d <- mkCFFifo;
  Fifo#(2, Decode2RegRead) d2rf <- mkCFFifo;
  Fifo#(2, RegRead2Exec)   rf2ex <- mkCFFifo;
  Fifo#(2, Exec2Mem)      ex2m <- mkCFFifo;
  Fifo#(2, Mem2Wb)        m2wb <- mkCFFifo;

  Scoreboard#(16)           sb <- mkCFScoreboard;
  Fifo#(1, Redirect)     ex2fRedirect <- mkBypassFifo;
  
	Fifo#(1, Tuple2#(Bool, Addr)) dirPredRedirect <- mkBypassFifo;
  
	Reg#(Bool)           feEpoch <- mkReg(False);
  Reg#(Bool)           fdEpoch <- mkReg(False);
  Reg#(Bool)           deEpoch <- mkReg(False);
  Reg#(Bool)            dEpoch <- mkReg(False);
  Reg#(Bool)            eEpoch <- mkReg(False);
  
	// Cache states
  Cache iCache <- mkCache;
  Cache dCache <- mkCache;
  
	Fifo#(1, Tuple4#(Addr, Addr, Bool, Bool)) f12f2 <- mkBypassFifo;
  Fifo#(1, Exec2Mem) m12m2 <- mkBypassFifo;
  
	function ActionValue#(Tuple2#(Bool, Addr)) handleFetchRedirect(Fifo#(1, Redirect) ex2fRedrct, Fifo#(1, Tuple2#(Bool, Addr)) dirPredRedrct);
  actionvalue
    Bool redirected;
    Addr updatedPc;
    if(ex2fRedrct.notEmpty)
    begin
      pcPred.update(ex2fRedrct.first);
      ex2fRedrct.deq;
    end
    // If the direction predictor has a redirect, deq it
    if(dirPredRedrct.notEmpty)
      dirPredRedrct.deq;
    if(ex2fRedrct.notEmpty && ex2fRedrct.first.mispredict)
    begin
      redirected = True;
      updatedPc = ex2fRedrct.first.nextPc;
      feEpoch <= !feEpoch;
    end
    // Check if the direction preditor redirect has the same execute epoch. Change the pc only if that is true.
    else if(dirPredRedrct.notEmpty && tpl_1(dirPredRedrct.first) == feEpoch)
    begin
      redirected = True;
      updatedPc = tpl_2(dirPredRedrct.first);
      fdEpoch <= !fdEpoch;
    end
    else
    begin
      redirected = False;
      updatedPc = pcPred.predPc(pc);
    end
    return tuple2(redirected, updatedPc);
  endactionvalue
  endfunction
  function ActionValue#(Maybe#(Addr)) handleDecodeRedirect(Fifo#(1, Tuple2#(Bool, Addr)) dirPredRedrct, DecodedInst dInst, Addr pcVal, Addr ppc, Bool fdEpochVal, Bool feEpochVal);
  actionvalue
    Maybe#(Addr) ret;

    let dEpochLocal = dEpoch;

    // Copy both the incoming epochs if the incoming execute epoch is different from the local copy
    if(feEpoch != deEpoch)
    begin
      deEpoch <= feEpochVal;
      dEpochLocal = fdEpochVal;
    end
    // After potential change to the local epochs, check if the incoming decode epoch is the same as the local decode epoch. Proceed only if true
    if(fdEpochVal == dEpochLocal)
    begin
      let nextAddr = dInst.iType == Jr? ppc : brAddrCalc(pcVal, ?, dInst.iType, validValue(dInst.imm), dirPred.predDir(pcVal));
      ret = Valid (nextAddr);
      if(nextAddr != ppc)
      begin
        dirPredRedrct.enq(tuple2(feEpochVal, nextAddr));
        dEpochLocal = !dEpochLocal;
      end
    end
    else
      ret = Invalid;
    // Put back the changes to the local decode epoch into the register
    dEpoch <= dEpochLocal;
    return ret;
  endactionvalue
  endfunction

  rule doFetch1(cop.started);
    match {.redirected, .updatedPc} <- handleFetchRedirect(ex2fRedirect, dirPredRedirect);
    pc <= updatedPc;
    if(!redirected)
    begin
      iCache.req(MemReq{op: Ld, addr: pc, data: ?});
      f12f2.enq(tuple4(pc, updatedPc, fdEpoch, feEpoch));
    end
  endrule
  
	rule doFetch2(cop.started);
    let inst <- iCache.resp;
    match {.pc, .ppc, .fdEpoch, .feEpoch} = f12f2.first;
    f12f2.deq;
    f2d.enq(Fetch2Decode{pc: pc, ppc: ppc, eEpoch: feEpoch, dEpoch: fdEpoch, inst: inst});

    $display("Fetch: pc: %h dEpoch: %d eEpoch: %d inst: (%h) expanded: ", pc, fdEpoch, feEpoch, inst, showInst(inst));
  endrule

  rule doDecode;
    let pc = f2d.first.pc;
    let ppc = f2d.first.ppc;
    let fdEpoch = f2d.first.dEpoch;
    let feEpoch = f2d.first.eEpoch;
    let inst = f2d.first.inst;

    let dInst = decode(inst);
    let nextAddr <- handleDecodeRedirect(dirPredRedirect, dInst, pc, ppc, fdEpoch, feEpoch);
    if(isValid(nextAddr))
    begin
      d2rf.enq(Decode2RegRead{pc: pc, ppc: validValue(nextAddr), epoch: feEpoch, dInst: dInst});
      $display("Decode: pc: %h dEpoch: %d eEpoch: %d", pc, fdEpoch, feEpoch);
    end
    f2d.deq;
  endrule

  rule doRegRead;
    let pc = d2rf.first.pc;
    let ppc = d2rf.first.ppc;
    let epoch = d2rf.first.epoch;
    let dInst = d2rf.first.dInst;

    let raw = sb.search1(dInst.src1) || sb.search2(dInst.src2);

    if(!raw)
    begin
      Data rVal1 = rf.rd1(validRegValue(dInst.src1));
      Data rVal2 = rf.rd2(validRegValue(dInst.src2));
      Data copVal = cop.rd(validRegValue(dInst.src1));

      rf2ex.enq(RegRead2Exec{pc: pc, ppc: ppc, dInst: dInst, epoch: epoch, rVal1: rVal1, rVal2: rVal2, copVal: copVal});
      sb.insert(dInst.dst);
      d2rf.deq;

      $display("RegRead: pc: %h", pc);
    end
  endrule

  rule doExec;
    let dInst  = rf2ex.first.dInst;
    let pc     = rf2ex.first.pc;
    let ppc    = rf2ex.first.ppc;
    let epoch  = rf2ex.first.epoch;
    let rVal1  = rf2ex.first.rVal1;
    let rVal2  = rf2ex.first.rVal2;
    let copVal = rf2ex.first.copVal;

    // We use a poisoned bit to denote whether an instruction is killed or not. If the epochs match, the instruction is not killed, and hence the poisoned bit is not set. Otherwise poisoned bit is set
    let poisoned = epoch != eEpoch;
    let eInst = exec(dInst, rVal1, rVal2, pc, ppc, copVal);

    if(!poisoned)
    begin
      if(eInst.iType == Unsupported)
      begin
        $fwrite(stderr, "Executing unsupported instruction at pc: %x. Exiting\n", pc);
        $finish;
      end

      if(eInst.iType == J || eInst.iType == Jr || eInst.iType == Br)
			begin
        let redirect = Redirect{pc: pc, nextPc: eInst.addr, brType: eInst.iType, taken: eInst.brTaken, mispredict: eInst.mispredict};
        ex2fRedirect.enq(redirect);
			end
      if(eInst.mispredict)
        eEpoch <= !eEpoch;

      $display("Execute: pc: %h epoch: %d", pc, epoch);
    end
    ex2m.enq(Exec2Mem{poisoned: poisoned, iType: eInst.iType, dst: eInst.dst, data: eInst.data, addr: eInst.addr});
    rf2ex.deq;
  endrule
  
	// Memory rule is split similar to the fetch rule
  rule doMem1;
    let poisoned = ex2m.first.poisoned;
    let iType = ex2m.first.iType;
    let dst = ex2m.first.dst;
    let data = ex2m.first.data;
    let addr = ex2m.first.addr;

    // Do any update to memory (and bypsas network) only when the instruction is not poisoned
    if(!poisoned)
    begin
      if(iType == Ld)
        dCache.req(MemReq{op: Ld, addr: addr, data: ?});
      else if(iType == St)
      begin
        dCache.req(MemReq{op: St, addr: addr, data: data});
      end
    end

    m12m2.enq(ex2m.first);
    ex2m.deq;
  endrule

  rule doMem2;
    let poisoned = m12m2.first.poisoned;
    let iType = m12m2.first.iType;
    let dst = m12m2.first.dst;
    let data = m12m2.first.data;
    let addr = m12m2.first.addr;

    if(!poisoned)
    begin
      if(iType == Ld)
      begin
        data <- dCache.resp;
      end
    end

    m2wb.enq(Mem2Wb{poisoned: poisoned, dst: dst, data: data});
    m12m2.deq;
  endrule

  rule doWb;
    let poisoned = m2wb.first.poisoned;
    let dst = m2wb.first.dst;
    let data = m2wb.first.data;

    if(!poisoned)
    begin
      if(isValid(dst) && validValue(dst).regType == Normal)
        rf.wr(validRegValue(dst), data);
      cop.wr(dst, data);
    end

    sb.remove;
    m2wb.deq;
  endrule
  
	mkConnection(mem.iReq, iCache.memReq);
  mkConnection(mem.iResp, iCache.memResp);
  mkConnection(mem.dReq, dCache.memReq);
  mkConnection(mem.dResp, dCache.memResp);

  method ActionValue#(Tuple2#(RIndx, Data)) cpuToHost;
    let ret <- cop.cpuToHost;
    return ret;
  endmethod

  method Action hostToCpu(Bit#(32) startpc) if (!cop.started);
    cop.start;
    pc <= startpc;
  endmethod
endmodule
