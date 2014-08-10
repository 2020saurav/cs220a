/*

Copyright (C) 2012 Muralidaran Vijayaraghavan <vmurali@csail.mit.edu>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/


import Types::*;
import ProcTypes::*;
import RegFile::*;

interface DirPred;
  method Bool predDir(Addr pc);
  method Action update(Redirect rd);
endinterface

typedef 1024 CounterPredEntries;
typedef Bit#(TSub#(TSub#(AddrSz, TLog#(CounterPredEntries)), 2)) CounterPredTag;
typedef Bit#(TLog#(CounterPredEntries)) CounterPredIndex;


(* synthesize *)
module mkNoDirPred(DirPred);
  RegFile#(CounterPredIndex, Bit#(2)) counters <- mkRegFileFull;
  RegFile#(CounterPredIndex, Maybe#(CounterPredTag)) tags <- mkRegFileFull;

  Reg#(Bit#(TLog#(TAdd#(CounterPredEntries, 1)))) initialize <- mkReg(0);

  Bool inited = truncateLSB(initialize) == 1'b1;

  rule init(!inited);
    counters.upd(truncate(initialize), 0);
    initialize <= initialize + 1;
  endrule

  function CounterPredIndex getIdx(Addr pc) = truncate(pc >> 2);
  function CounterPredTag getTag(Addr pc) = truncateLSB(pc);

  method Bool predDir(Addr pc) if(inited);
    let idx = getIdx(pc);
    let tag = getTag(pc);
		
		return False;
  endmethod

  method Action update(Redirect rd) if(inited);
  endmethod
endmodule


(* synthesize *)
module mkCounterPred2Bit(DirPred);
  RegFile#(CounterPredIndex, Bit#(2)) counters <- mkRegFileFull;
  RegFile#(CounterPredIndex, Maybe#(CounterPredTag)) tags <- mkRegFileFull;

  Reg#(Bit#(TLog#(TAdd#(CounterPredEntries, 1)))) initialize <- mkReg(0);

  Bool inited = truncateLSB(initialize) == 1'b1;

  rule init(!inited);
    counters.upd(truncate(initialize), 0);
    initialize <= initialize + 1;
  endrule

  function CounterPredIndex getIdx(Addr pc) = truncate(pc >> 2);
  function CounterPredTag getTag(Addr pc) = truncateLSB(pc);

  method Bool predDir(Addr pc) if(inited);
    let idx = getIdx(pc);
    let tag = getTag(pc);
    if(counters.sub(idx) > 1)
    begin
      return True;
    end
    else
    begin
      return False;
    end
  endmethod


  method Action update(Redirect rd) if(inited);
  let idx = getIdx(rd.pc);
  let tag = getTag(rd.pc);
  if(rd.taken)
  begin
    
    if(counters.sub(idx) != 3)
    begin
      counters.upd(idx, counters.sub(idx) + 1);
    end
  end
  else
  begin
    if(counters.sub(idx) != 0)
    begin
      counters.upd(idx, counters.sub(idx) - 1);
    end
    
  end
  endmethod
endmodule

// The commented portion below shows implementationo of 1 bit and 2 bit counter for checking efficiency

/*module mkCounterPred2Bit(DirPred);
  RegFile#(CounterPredIndex, Bit#(1)) counters <- mkRegFileFull;
  RegFile#(CounterPredIndex, Maybe#(CounterPredTag)) tags <- mkRegFileFull;

  Reg#(Bit#(TLog#(TAdd#(CounterPredEntries, 1)))) initialize <- mkReg(0);

  Bool inited = truncateLSB(initialize) == 1'b1;

  rule init(!inited);
    counters.upd(truncate(initialize), 0);
    initialize <= initialize + 1;
  endrule

  function CounterPredIndex getIdx(Addr pc) = truncate(pc >> 2);
  function CounterPredTag getTag(Addr pc) = truncateLSB(pc);

  method Bool predDir(Addr pc) if(inited);
    let idx = getIdx(pc);
    let tag = getTag(pc);
    if(counters.sub(idx) > 0)
    begin
      return True;
    end
    else
    begin
      return False;
    end
  endmethod

  method Action update(Redirect rd) if(inited);
  let idx = getIdx(rd.pc);
  let tag = getTag(rd.pc);
  if(rd.taken)
  begin
    
    if(counters.sub(idx) != 1)
    begin
      counters.upd(idx, counters.sub(idx) + 1);
    end
  end
  else
  begin
    if(counters.sub(idx) != 0)
    begin
      counters.upd(idx, counters.sub(idx) - 1);
    end
    
  end
  endmethod
endmodule


module mkCounterPred2Bit(DirPred);
  RegFile#(CounterPredIndex, Bit#(3)) counters <- mkRegFileFull;
  RegFile#(CounterPredIndex, Maybe#(CounterPredTag)) tags <- mkRegFileFull;

  Reg#(Bit#(TLog#(TAdd#(CounterPredEntries, 1)))) initialize <- mkReg(0);

  Bool inited = truncateLSB(initialize) == 1'b1;

  rule init(!inited);
    counters.upd(truncate(initialize), 0);
    initialize <= initialize + 1;
  endrule

  function CounterPredIndex getIdx(Addr pc) = truncate(pc >> 2);
  function CounterPredTag getTag(Addr pc) = truncateLSB(pc);

  method Bool predDir(Addr pc) if(inited);
    let idx = getIdx(pc);
    let tag = getTag(pc);
    if(counters.sub(idx) > 3)
    begin
      return True;
    end
    else
    begin
      return False;
    end
  endmethod

  method Action update(Redirect rd) if(inited);
  let idx = getIdx(rd.pc);
  let tag = getTag(rd.pc);
  if(rd.taken)
  begin
    
    if(counters.sub(idx) != 7)
    begin
      counters.upd(idx, counters.sub(idx) + 1);
    end
  end
  else
  begin
    if(counters.sub(idx) != 0)
    begin
      counters.upd(idx, counters.sub(idx) - 1);
    end
    
  end
  endmethod
endmodule*/
