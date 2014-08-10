typedef 16 DataSz;
typedef Bit#(DataSz) Data;
typedef TAdd#(DataSz, DataSz) ResSz;
typedef Bit#(ResSz) Res;
typedef TAdd#(ResSz, 1) AccumSz;
typedef Bit#(AccumSz) Accum;

interface MultiplyN#(numeric type n);
   method Action start (Bit#(n) a, Bit#(n) b);
   method Bit#(TAdd#(n,n)) result();
endinterface
