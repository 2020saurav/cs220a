function Bit#(1) and1(Bit#(1) a, Bit#(1) b);
  return a & b;
endfunction

function Bit#(1) or1(Bit#(1) a, Bit#(1) b);
  return a | b;
endfunction

function Bit#(1) not1(Bit#(1) a);
  return ~ a;
endfunction

function Bit#(1) multiplexer1(Bit#(1) sel, Bit#(1) a, Bit#(1) b);
  return (or1(and1(a,not1(sel)),and1(b,sel)));
endfunction

function Bit#(32) multiplexer32(Bit#(1) sel, Bit#(32) a, Bit#(32) b);
 //Bit#(32) aggregate;
  //for(Integer i = 0; i < 32; i = i + 1)
    //aggregate[i] = multiplexer1(sel, a[i], b[i]);
  //return aggregate;
  // Q4 : reimplement multiplexer32 to use multiplexer_n
  return multiplexer_n(sel,a,b);
endfunction

typedef 32 N;
function Bit#(N) multiplexerN(Bit#(1) sel, Bit#(N) a, Bit#(N) b);
  Bit#(N) aggregate;
	for(Integer i = 0; i < valueOf(N); i = i + 1)
	  aggregate[i] = multiplexer1(sel, a[i], b[i]);
  return aggregate;
  //return multiplexer_n(sel,a,b);// this too is correct
endfunction

//typedef 32 N; // Not needed
function Bit#(n) multiplexer_n(Bit#(1) sel, Bit#(n) a, Bit#(n) b);
Bit#(n) aggregate;
	for(Integer i = 0; i < valueOf(n); i = i + 1)
	  aggregate[i] = multiplexer1(sel, a[i], b[i]);
return aggregate;

endfunction
