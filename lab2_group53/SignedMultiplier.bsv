import MultiplierTypes::*;

module mkSignedMultiplyN (MultiplyN#(n))
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
	

 function Bit#(n) comp2 (Bit#(n) x);   // returns 2's complement of x    
		Bit#(n) c = 0;
		for ( Integer i = 0 ; i < valueOf(n) ; i =i +1 )
			
			c[i] = (x[i]==0) ? 1 : 0 ; 
					 
		return c+1;
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

rule mulStep if (i!=nv);
			Bit#(n) acomp = comp2(a);
			Bit#(n) bcomp= comp2(b);
			Bit#(1) signa=a[(nv-1)];
			Bit#(1) signb=b[(nv-1)];

			let aval = (signa==0)?a:acomp;
			let bval = (signb==0)?b:bcomp;	
		
			Bit#(n) m = (bval[i]==0)?0:aval;
			Bit#(TAdd#(n,1)) sum = addN(m, tp, 0);
			prod <= {sum[0], prod[(nv-1):1]};
			tp <= truncateLSB(sum);
			
			i<=i+1;
	endrule

 
   method Action start(Bit#(n) aIn, Bit#(n) bIn) if (i==nv);
	a<=aIn; b<=bIn; i<=0; prod<=0; tp<=0;      
   endmethod
  
  method Bit#(TAdd#(n,n)) result() if (i == nv);
			Bit#(1) signa=a[(nv-1)];
			Bit#(1) signb =b[(nv-1)];
			let finalans = (signa==signb)?{tp,prod}:-{tp,prod};
      return finalans;
   endmethod    
endmodule

