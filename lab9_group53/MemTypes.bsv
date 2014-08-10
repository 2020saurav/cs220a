import Types::*;

typedef Data Line;

typedef Line MemResp;

typedef enum{Ld, St} MemOp deriving(Eq,Bits);
typedef struct{
    MemOp op;
    Addr  addr;
    Data  data;
} MemReq deriving(Eq,Bits);

typedef 16 NumTokens;
typedef Bit#(TLog#(NumTokens)) Token;

typedef 16 LoadBufferSz;
typedef Bit#(TLog#(LoadBufferSz)) LoadBufferIndex;

