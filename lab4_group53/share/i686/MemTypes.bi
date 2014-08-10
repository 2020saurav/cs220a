signature MemTypes where {
import ¶List®¶;
	      
import ¶PrimArray®¶;
		   
import ¶Vector®¶;
		
import Types;
	    
type (MemTypes.Line :: *) = Types.Data;
				      
type (MemTypes.MemResp :: *) = MemTypes.Line;
					    
data (MemTypes.MemOp :: *) = MemTypes.Ld () | MemTypes.St ();
							    
instance MemTypes ¶Prelude®¶.¶PrimMakeUndefined®¶ MemTypes.MemOp;
								
instance MemTypes ¶Prelude®¶.¶PrimDeepSeqCond®¶ MemTypes.MemOp;
							      
instance MemTypes ¶Prelude®¶.¶PrimMakeUninitialized®¶ MemTypes.MemOp;
								    
instance MemTypes ¶Prelude®¶.¶Eq®¶ MemTypes.MemOp;
						 
instance MemTypes ¶Prelude®¶.¶Bits®¶ MemTypes.MemOp 1;
						     
struct (MemTypes.MemReq :: *) = {
    MemTypes.op :: MemTypes.MemOp;
    MemTypes.addr :: Types.Addr;
    MemTypes.¡data¡ :: Types.Data
};
 
instance MemTypes ¶Prelude®¶.¶PrimMakeUndefined®¶ MemTypes.MemReq;
								 
instance MemTypes ¶Prelude®¶.¶PrimDeepSeqCond®¶ MemTypes.MemReq;
							       
instance MemTypes ¶Prelude®¶.¶PrimMakeUninitialized®¶ MemTypes.MemReq;
								     
instance MemTypes ¶Prelude®¶.¶Eq®¶ MemTypes.MemReq;
						  
instance MemTypes ¶Prelude®¶.¶Bits®¶ MemTypes.MemReq 65;
						       
type (MemTypes.NumTokens :: #) = 16;
				   
type (MemTypes.Token :: *) = ¶Prelude®¶.¶Bit®¶ (¶Prelude®¶.¶TLog®¶ MemTypes.NumTokens);
										      
type (MemTypes.LoadBufferSz :: #) = 16;
				      
type (MemTypes.LoadBufferIndex :: *) = ¶Prelude®¶.¶Bit®¶ (¶Prelude®¶.¶TLog®¶ MemTypes.LoadBufferSz)
}
