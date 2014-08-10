import BoothMultiplier::*;
import SignedMultiplier::*;
import Multiplier::*;
import Rand::*;
import MultiplierTypes::*;
import Fifo::*;

module mkTestBenchSigned#(MultiplyN#(DataSz) mult, Bool isSigned)();
   Reg#(Data) enqCount <- mkReg(0);
   Reg#(Data) deqCount <- mkReg(0);
   Rand#(DataSz) randomVal1 <- mkRand('hdeadbeef);
   Rand#(DataSz) randomVal2 <- mkRand('hcafebabe);

   Fifo#(4, Tuple2#(Data, Data)) f <- mkCFFifo;

   Data testCases = 12;
   function Bool isNeg(Bit#(n) val);     
      return isSigned && (val[valueof(n)-1] == 0);
   endfunction
   
   rule enq(enqCount < testCases);
      let val1 <- randomVal1.get;
      let val2 <- randomVal2.get;
      mult.start(val1, val2);
      f.enq(tuple2(val1, val2));
      enqCount <= enqCount + 1;
   endrule

   rule deq(deqCount < testCases);
      match {.val1, .val2} = f.first;
      f.deq;
      let res = mult.result();
      Res v1 = isSigned ? unpack(signExtend(val1)) : unpack(zeroExtend(val1));
      Res v2 = isSigned ? unpack(signExtend(val2)) : unpack(zeroExtend(val2));
      let actual = pack(v1*v2);
      if (actual != res)
	 begin
	    let s1 = isNeg(val1);
	    let s2 = isNeg(val2);
	    let s3 = isNeg(res);
	    let s4 = isNeg(actual);
	    let str1 = s1 ? " " : "-";
	    let str2 = s2 ? " " : "-";
	    let str3 = s3 ? " " : "-";
	    let str4 = s4 ? " " : "-";
	    let k1 = s1 ? val1   : -val1;
	    let k2 = s2 ? val2   : -val2;
	    let k3 = s3 ? res    : -res;
	    let k4 = s4 ? actual : -actual;
	    $display("%s%0d * %s%0d = %s%0d, but you returned %s%0d",
	       str1, k1, str2, k2, str4, k4, str3, k3);
	    $finish;
	 end
      $display("%d * %d = %d", val1, val2, res);
      deqCount <= deqCount + 1;
   endrule
   
   rule fin(deqCount == testCases);
      $display("PASSED");
      $finish;
   endrule
endmodule

(* synthesize *)
module mkDefaultTb();
   MultiplyN#(DataSz) mult <- mkMultiplyN();
   mkTestBenchSigned(mult, False)(); // unsigned
endmodule

(* synthesize *)
module mkSignedTb();
   MultiplyN#(DataSz) mult <- mkSignedMultiplyN();
   mkTestBenchSigned(mult, True)(); // signed
endmodule

(* synthesize *)
module mkBoothTb();
   MultiplyN#(DataSz) mult <- mkBoothMultiplyN();
   mkTestBenchSigned(mult, True)();  // signed
endmodule

