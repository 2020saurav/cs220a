import MultiplierTypes::*;

module mkMultiplyN (MultiplyN#(n))
   provisos (Add#(1, m, n));
   Reg#(Bit#(n)) a <- mkRegU();
   Reg#(Bit#(n)) b <- mkRegU();
   Reg#(Bit#(n)) prod <-mkRegU();
   Reg#(Bit#(n)) tp <- mkRegU();
   let nv = fromInteger(valueOf(n));
   Reg#(Bit#(TAdd#(TLog#(n),1))) i <- mkReg(nv);
   
   function Bit#(2) fa(Bit#(1) ba, Bit#(1) bb, Bit#(1) c_in);
      Bit#(1) s = (ba ^ bb)^ c_in;
      Bit#(1) c_out = (ba & bb) | (c_in & (ba ^ bb));
      return {c_out,s};
   endfunction
   
   function Bit#(TAdd#(n,1)) addN(Bit#(n) x, Bit#(n) y, Bit#(1) c0);
      Bit#(n) s; Bit#(TAdd#(n,1)) c=0; c[0] = c0;
      let valn = valueOf(n);
      for(Integer i=0; i<valn; i=i+1)
	 begin
	    let cs = fa(x[i],y[i],c[i]);
	    c[i+1] = cs[1]; s[i] = cs[0];
	 end
      return {c[valn],s};
   endfunction
   
   rule mulStep if (i != nv);
      Bit#(n) m = (a[0]==0)? 0 : b;
      Bit#(TAdd#(n,1)) sum = addN(m,tp,0);
      prod <= {sum[0], (prod >> 1)[(nv-2):0]};
      tp <= truncateLSB(sum);
      a <= a >> 1;
      i <= i+1;
   endrule

   method Action start(Bit#(n) aIn, Bit#(n) bIn) if (i == nv);
      a <= aIn; b <= bIn; i <= 0; tp <= 0; prod <= 0;
   endmethod

   method Bit#(TAdd#(n,n)) result() if (i == nv);
      return {tp,prod};
   endmethod 
endmodule
