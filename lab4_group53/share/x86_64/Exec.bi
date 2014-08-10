signature Exec where {
import ¶FIFOF_®¶;
		
import ¶FIFOF®¶;
	       
import ¶FIFO®¶;
	      
import ¶List®¶;
	      
import ¶PrimArray®¶;
		   
import ¶Probe®¶;
	       
import ¶Vector®¶;
		
import ¶FShow®¶;
	       
import Types;
	    
import MemTypes;
	       
import ProcTypes;
		
interface (Exec.Interface_alu :: *) = {
    Exec.alu :: Types.Data -> Types.Data -> ProcTypes.AluFunc -> Types.Data {-# arg_names = [a,
											     b,
											     func] #-}
};
 
instance Exec ¶Prelude®¶.¶PrimMakeUndefined®¶ Exec.Interface_alu;
								
instance Exec ¶Prelude®¶.¶PrimDeepSeqCond®¶ Exec.Interface_alu;
							      
instance Exec ¶Prelude®¶.¶PrimMakeUninitialized®¶ Exec.Interface_alu;
								    
Exec.module_alu :: ¶Prelude®¶.¶Module®¶ Exec.Interface_alu;
							  
interface (Exec.Interface_aluBr :: *) = {
    Exec.aluBr :: Types.Data ->
		  Types.Data -> ProcTypes.BrFunc -> ¶Prelude®¶.¶Bool®¶ {-# arg_names = [a, b, brFunc] #-}
};
 
instance Exec ¶Prelude®¶.¶PrimMakeUndefined®¶ Exec.Interface_aluBr;
								  
instance Exec ¶Prelude®¶.¶PrimDeepSeqCond®¶ Exec.Interface_aluBr;
								
instance Exec ¶Prelude®¶.¶PrimMakeUninitialized®¶ Exec.Interface_aluBr;
								      
Exec.module_aluBr :: ¶Prelude®¶.¶Module®¶ Exec.Interface_aluBr;
							      
interface (Exec.Interface_brAddrCalc :: *) = {
    Exec.brAddrCalc :: Types.Addr ->
		       Types.Data ->
		       ProcTypes.IType -> Types.Data -> ¶Prelude®¶.¶Bool®¶ -> Types.Addr {-# arg_names = [pc,
													  val,
													  iType,
													  imm,
													  taken] #-}
};
 
instance Exec ¶Prelude®¶.¶PrimMakeUndefined®¶ Exec.Interface_brAddrCalc;
								       
instance Exec ¶Prelude®¶.¶PrimDeepSeqCond®¶ Exec.Interface_brAddrCalc;
								     
instance Exec ¶Prelude®¶.¶PrimMakeUninitialized®¶ Exec.Interface_brAddrCalc;
									   
Exec.module_brAddrCalc :: ¶Prelude®¶.¶Module®¶ Exec.Interface_brAddrCalc;
									
interface (Exec.Interface_exec :: *) = {
    Exec.exec :: ProcTypes.DecodedInst ->
		 Types.Data ->
		 Types.Data -> Types.Addr -> Types.Addr -> Types.Data -> ProcTypes.ExecInst {-# arg_names = [dInst,
													     rVal1,
													     rVal2,
													     pc,
													     ppc,
													     copVal] #-}
};
 
instance Exec ¶Prelude®¶.¶PrimMakeUndefined®¶ Exec.Interface_exec;
								 
instance Exec ¶Prelude®¶.¶PrimDeepSeqCond®¶ Exec.Interface_exec;
							       
instance Exec ¶Prelude®¶.¶PrimMakeUninitialized®¶ Exec.Interface_exec;
								     
Exec.module_exec :: ¶Prelude®¶.¶Module®¶ Exec.Interface_exec;
							    
Exec.alu :: Types.Data -> Types.Data -> ProcTypes.AluFunc -> Types.Data;
								       
Exec.aluBr :: Types.Data -> Types.Data -> ProcTypes.BrFunc -> ¶Prelude®¶.¶Bool®¶;
										
Exec.brAddrCalc :: Types.Addr ->
		   Types.Data -> ProcTypes.IType -> Types.Data -> ¶Prelude®¶.¶Bool®¶ -> Types.Addr;
												  
Exec.exec :: ProcTypes.DecodedInst ->
	     Types.Data -> Types.Data -> Types.Addr -> Types.Addr -> Types.Data -> ProcTypes.ExecInst
}
