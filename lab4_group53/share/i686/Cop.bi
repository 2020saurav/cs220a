signature Cop where {
import ¶ConfigReg®¶;
		   
import ¶FIFOF_®¶;
		
import ¶FIFOF®¶;
	       
import ¶FIFO®¶;
	      
import ¶List®¶;
	      
import ¶PrimArray®¶;
		   
import ¶Probe®¶;
	       
import ¶RWire®¶;
	       
import ¶Vector®¶;
		
import Ehr;
	  
import ¶FShow®¶;
	       
import Fifo;
	   
import Types;
	    
import MemTypes;
	       
import ProcTypes;
		
interface (Cop.Cop :: *) = {
    Cop.start :: ¶Prelude®¶.¶Action®¶ {-# arg_names = [] #-};
    Cop.started :: ¶Prelude®¶.¶Bool®¶ {-# arg_names = [] #-};
    Cop.rd :: ProcTypes.RIndx -> Types.Data {-# arg_names = [idx] #-};
    Cop.wr :: ¶Prelude®¶.¶Maybe®¶ ProcTypes.FullIndx ->
	      Types.Data -> ¶Prelude®¶.¶Action®¶ {-# arg_names = [idx, val] #-};
    Cop.cpuToHost :: ¶Prelude®¶.¶ActionValue®¶
		     (¶Prelude®¶.¶Tuple2®¶ ProcTypes.RIndx Types.Data) {-# arg_names = [] #-}
};
 
instance Cop ¶Prelude®¶.¶PrimMakeUndefined®¶ Cop.Cop;
						    
instance Cop ¶Prelude®¶.¶PrimDeepSeqCond®¶ Cop.Cop;
						  
instance Cop ¶Prelude®¶.¶PrimMakeUninitialized®¶ Cop.Cop;
							
Cop.mkCop :: (¶Prelude®¶.¶IsModule®¶ _m__ _c__) => _m__ Cop.Cop
}
