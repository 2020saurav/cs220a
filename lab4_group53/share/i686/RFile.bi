signature RFile where {
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
	       
import Types;
	    
import MemTypes;
	       
import ProcTypes;
		
interface (RFile.RFile :: *) = {
    RFile.wr :: ProcTypes.RIndx -> Types.Data -> ¶Prelude®¶.¶Action®¶ {-# arg_names = [rindx,
										       ¡data¡] #-};
    RFile.rd1 :: ProcTypes.RIndx -> Types.Data {-# arg_names = [rindx] #-};
    RFile.rd2 :: ProcTypes.RIndx -> Types.Data {-# arg_names = [rindx] #-}
};
 
instance RFile ¶Prelude®¶.¶PrimMakeUndefined®¶ RFile.RFile;
							  
instance RFile ¶Prelude®¶.¶PrimDeepSeqCond®¶ RFile.RFile;
							
instance RFile ¶Prelude®¶.¶PrimMakeUninitialized®¶ RFile.RFile;
							      
RFile.mkRFile :: (¶Prelude®¶.¶IsModule®¶ _m__ _c__) => _m__ RFile.RFile
}
