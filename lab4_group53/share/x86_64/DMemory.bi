signature DMemory where {
import ¶List®¶;
	      
import ¶PrimArray®¶;
		   
import ¶RegFile®¶;
		 
import ¶Vector®¶;
		
import Types;
	    
import MemTypes;
	       
interface (DMemory.DMemory :: *) = {
    DMemory.req :: MemTypes.MemReq ->
		   ¶Prelude®¶.¶ActionValue®¶ MemTypes.MemResp {-# arg_names = [r] #-}
};
 
instance DMemory ¶Prelude®¶.¶PrimMakeUndefined®¶ DMemory.DMemory;
								
instance DMemory ¶Prelude®¶.¶PrimDeepSeqCond®¶ DMemory.DMemory;
							      
instance DMemory ¶Prelude®¶.¶PrimMakeUninitialized®¶ DMemory.DMemory;
								    
DMemory.mkDMemory :: (¶Prelude®¶.¶IsModule®¶ _m__ _c__) => _m__ DMemory.DMemory
}
