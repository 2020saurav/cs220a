import Multiplexer::*;

interface BarrelShifterRight;
  method ActionValue#(Bit#(32)) rightShift(Bit#(32) val, Bit#(5) shiftAmt, Bit#(1) shiftValue);
endinterface

module mkBarrelShifterRight(BarrelShifterRight);
  method ActionValue#(Bit#(32)) rightShift(Bit#(32) val, Bit#(5) shiftAmt, Bit#(1) shiftValue);
    for(Integer i=4;i>=0;i=i-1)
    begin
      Bit#(32) temp=0;
      for(Integer j=31;j>31-(2**i);j=j-1)
      begin
        temp[j]=shiftValue;
      end

      for(Integer j=31-(2**i);j>=0;j=j-1)
      begin
        temp[j]=val[j+(2**i)];
      end

      val=multiplexer_n(shiftAmt[i],val,temp);
    end
    return val;
  endmethod
endmodule

interface BarrelShifterRightLogical;
  method ActionValue#(Bit#(32)) rightShift(Bit#(32) val, Bit#(5) shiftAmt);
endinterface

module mkBarrelShifterRightLogical(BarrelShifterRightLogical);
  let bsr <- mkBarrelShifterRight;
  method ActionValue#(Bit#(32)) rightShift(Bit#(32) val, Bit#(5) shiftAmt);
    let x <- bsr.rightShift(val,shiftAmt,0);
    return x;
  endmethod
endmodule

typedef BarrelShifterRightLogical BarrelShifterRightArithmetic;

module mkBarrelShifterRightArithmetic(BarrelShifterRightArithmetic);
  let bsr <- mkBarrelShifterRight;
   method ActionValue#(Bit#(32)) rightShift(Bit#(32) val, Bit#(5) shiftAmt);
      let x <- bsr.rightShift(val,shiftAmt,val[31]);
      return x;
  endmethod
endmodule

