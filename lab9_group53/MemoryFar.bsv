/*

Copyright (C) 2012 Muralidaran Vijayaraghavan <vmurali@csail.mit.edu>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/


import Types::*;
import MemTypes::*;
import RegFile::*;
import Fifo::*;

interface Memory;
  method Action iReq(MemReq r);
  method ActionValue#(MemResp) iResp;
  method Action dReq(MemReq r);
  method ActionValue#(MemResp) dResp;
endinterface

(* synthesize *)
module mkMemory(Memory);
  RegFile#(Bit#(20), Data) mem <- mkRegFileWCFLoad("memory.vmh", 0, maxBound);

  Fifo#(2, MemReq) iMemReqQ <- mkCFFifo;
  Fifo#(2, MemResp) iMemRespQ <- mkCFFifo;

  Fifo#(2, MemReq) dMemReqQ <- mkCFFifo;
  Fifo#(2, MemResp) dMemRespQ <- mkCFFifo;

	Reg#(Bit#(8)) iMemDelay <- mkReg(0);
	Reg#(Bit#(8)) dMemDelay <- mkReg(0);

  rule getDResp ( dMemDelay >= 4);
    let req = dMemReqQ.first;
    let idx = truncate(req.addr >> 2);
    let data = mem.sub(idx);
    if(req.op == St)
		begin
      mem.upd(idx, req.data);
		end
    else
      dMemRespQ.enq(data);
    dMemReqQ.deq;
		dMemDelay <= 0;
  endrule

  rule getIResp;
    let addr = iMemReqQ.first.addr;
    iMemRespQ.enq(mem.sub(truncate(addr >> 2)));
    iMemReqQ.deq;
  endrule

	rule incdMemDelay ( dMemDelay > 0 && dMemDelay < 4 );
		dMemDelay <= dMemDelay + 1;
	endrule
	rule inciMemDelay ( iMemDelay > 0 && iMemDelay < 4 );
			iMemDelay <= iMemDelay + 1;
	endrule

  method Action dReq(MemReq r) if ( dMemDelay == 0 );
		dMemDelay <= 1;
		dMemReqQ.enq(r);
	endmethod

  method ActionValue#(MemResp) dResp;
    dMemRespQ.deq;
    return dMemRespQ.first;
  endmethod

  method Action iReq(MemReq r) if ( iMemDelay == 0 );
		iMemDelay <= 1;
		iMemReqQ.enq(r);
	endmethod

  method ActionValue#(MemResp) iResp if ( iMemDelay >= 4 );
    iMemRespQ.deq;
		iMemDelay <= 0;
    return iMemRespQ.first;
  endmethod
endmodule
