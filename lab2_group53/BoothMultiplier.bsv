import MultiplierTypes::*;

module mkBoothMultiplyN (MultiplyN#(n))
   provisos (Add#(1, m, n) , Add#(n, a__, 33) , Add#(b__, TAdd#(n, 1), 33));
   
   Reg#(Accum) a <- mkRegU();
   Reg#(Accum) s <- mkRegU();
   Reg#(Accum) p <- mkRegU();
   let nv = fromInteger(valueOf(n));
   Reg#(Bit#(TAdd#(TLog#(n),1))) i <- mkReg(nv);
   Reg#(Bit#(2)) lsb2 <- mkRegU();
   
   rule booth if(i<nv);
   		let lsb2 = p[1:0];
   		Accum ptemp = p;
   		if(lsb2 == 1) ptemp = p + a;
   		if(lsb2 == 2) ptemp = p + s;
   		p <= {ptemp[2*nv],ptemp[2*nv:1]};
   		i <= i+1;
   	endrule
			
   // You need to implement guards and bodies for methods
   
   method Action start(Bit#(n) aIn, Bit#(n) bIn) if (i==nv);
      a<={aIn,0}; s<={-aIn,0}; p<={0,bIn,1'b0}; i<=0; //lsb2={bIn[0],0};
   endmethod

   method Bit#(TAdd#(n,n)) result() if(i==nv);
      return p[2*nv:1]; // garbage - you need to implement this
   endmethod 
endmodule
