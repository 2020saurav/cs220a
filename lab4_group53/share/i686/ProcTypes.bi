signature ProcTypes where {
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
	       
interface (ProcTypes.Proc :: *) = {
    ProcTypes.cpuToHost :: ¶Prelude®¶.¶ActionValue®¶
			   (¶Prelude®¶.¶Tuple2®¶ ProcTypes.RIndx Types.Data) {-# arg_names = [] #-};
    ProcTypes.hostToCpu :: Types.Addr -> ¶Prelude®¶.¶Action®¶ {-# arg_names = [startpc] #-}
};
 
instance ProcTypes ¶Prelude®¶.¶PrimMakeUndefined®¶ ProcTypes.Proc;
								 
instance ProcTypes ¶Prelude®¶.¶PrimDeepSeqCond®¶ ProcTypes.Proc;
							       
instance ProcTypes ¶Prelude®¶.¶PrimMakeUninitialized®¶ ProcTypes.Proc;
								     
type (ProcTypes.RIndx :: *) = ¶Prelude®¶.¶Bit®¶ 5;
						 
data (ProcTypes.IType :: *) =
    ProcTypes.Unsupported () |
    ProcTypes.Alu () |
    ProcTypes.Ld () |
    ProcTypes.St () |
    ProcTypes.J () |
    ProcTypes.Jr () |
    ProcTypes.Br () |
    ProcTypes.Mfc0 () |
    ProcTypes.Mtc0 ();
		     
instance ProcTypes ¶Prelude®¶.¶PrimMakeUndefined®¶ ProcTypes.IType;
								  
instance ProcTypes ¶Prelude®¶.¶PrimDeepSeqCond®¶ ProcTypes.IType;
								
instance ProcTypes ¶Prelude®¶.¶PrimMakeUninitialized®¶ ProcTypes.IType;
								      
instance ProcTypes ¶Prelude®¶.¶Bits®¶ ProcTypes.IType 4;
						       
instance ProcTypes ¶Prelude®¶.¶Eq®¶ ProcTypes.IType;
						   
data (ProcTypes.BrFunc :: *) =
    ProcTypes.Eq () |
    ProcTypes.Neq () |
    ProcTypes.Le () |
    ProcTypes.Lt () |
    ProcTypes.Ge () |
    ProcTypes.Gt () |
    ProcTypes.AT () |
    ProcTypes.NT ();
		   
instance ProcTypes ¶Prelude®¶.¶PrimMakeUndefined®¶ ProcTypes.BrFunc;
								   
instance ProcTypes ¶Prelude®¶.¶PrimDeepSeqCond®¶ ProcTypes.BrFunc;
								 
instance ProcTypes ¶Prelude®¶.¶PrimMakeUninitialized®¶ ProcTypes.BrFunc;
								       
instance ProcTypes ¶Prelude®¶.¶Bits®¶ ProcTypes.BrFunc 3;
							
instance ProcTypes ¶Prelude®¶.¶Eq®¶ ProcTypes.BrFunc;
						    
data (ProcTypes.AluFunc :: *) =
    ProcTypes.Add () |
    ProcTypes.Sub () |
    ProcTypes.And () |
    ProcTypes.Or () |
    ProcTypes.Xor () |
    ProcTypes.Nor () |
    ProcTypes.Slt () |
    ProcTypes.Sltu () |
    ProcTypes.LShift () |
    ProcTypes.RShift () |
    ProcTypes.Sra ();
		    
instance ProcTypes ¶Prelude®¶.¶PrimMakeUndefined®¶ ProcTypes.AluFunc;
								    
instance ProcTypes ¶Prelude®¶.¶PrimDeepSeqCond®¶ ProcTypes.AluFunc;
								  
instance ProcTypes ¶Prelude®¶.¶PrimMakeUninitialized®¶ ProcTypes.AluFunc;
									
instance ProcTypes ¶Prelude®¶.¶Bits®¶ ProcTypes.AluFunc 4;
							 
instance ProcTypes ¶Prelude®¶.¶Eq®¶ ProcTypes.AluFunc;
						     
data (ProcTypes.RegType :: *) = ProcTypes.Normal () | ProcTypes.CopReg ();
									 
instance ProcTypes ¶Prelude®¶.¶PrimMakeUndefined®¶ ProcTypes.RegType;
								    
instance ProcTypes ¶Prelude®¶.¶PrimDeepSeqCond®¶ ProcTypes.RegType;
								  
instance ProcTypes ¶Prelude®¶.¶PrimMakeUninitialized®¶ ProcTypes.RegType;
									
instance ProcTypes ¶Prelude®¶.¶Bits®¶ ProcTypes.RegType 1;
							 
instance ProcTypes ¶Prelude®¶.¶Eq®¶ ProcTypes.RegType;
						     
struct (ProcTypes.Redirect :: *) = {
    ProcTypes.pc :: Types.Addr;
    ProcTypes.nextPc :: Types.Addr;
    ProcTypes.brType :: ProcTypes.IType;
    ProcTypes.taken :: ¶Prelude®¶.¶Bool®¶;
    ProcTypes.mispredict :: ¶Prelude®¶.¶Bool®¶
};
 
instance ProcTypes ¶Prelude®¶.¶PrimMakeUndefined®¶ ProcTypes.Redirect;
								     
instance ProcTypes ¶Prelude®¶.¶PrimDeepSeqCond®¶ ProcTypes.Redirect;
								   
instance ProcTypes ¶Prelude®¶.¶PrimMakeUninitialized®¶ ProcTypes.Redirect;
									 
instance ProcTypes ¶Prelude®¶.¶Bits®¶ ProcTypes.Redirect 70;
							   
instance ProcTypes ¶Prelude®¶.¶Eq®¶ ProcTypes.Redirect;
						      
struct (ProcTypes.FullIndx :: *) = {
    ProcTypes.regType :: ProcTypes.RegType;
    ProcTypes.idx :: ProcTypes.RIndx
};
 
instance ProcTypes ¶Prelude®¶.¶PrimMakeUndefined®¶ ProcTypes.FullIndx;
								     
instance ProcTypes ¶Prelude®¶.¶PrimDeepSeqCond®¶ ProcTypes.FullIndx;
								   
instance ProcTypes ¶Prelude®¶.¶PrimMakeUninitialized®¶ ProcTypes.FullIndx;
									 
instance ProcTypes ¶Prelude®¶.¶Bits®¶ ProcTypes.FullIndx 6;
							  
instance ProcTypes ¶Prelude®¶.¶Eq®¶ ProcTypes.FullIndx;
						      
ProcTypes.validReg :: ProcTypes.RIndx -> ¶Prelude®¶.¶Maybe®¶ ProcTypes.FullIndx;
									       
ProcTypes.validCop :: ProcTypes.RIndx -> ¶Prelude®¶.¶Maybe®¶ ProcTypes.FullIndx;
									       
ProcTypes.validRegValue :: ¶Prelude®¶.¶Maybe®¶ ProcTypes.FullIndx -> ProcTypes.RIndx;
										    
struct (ProcTypes.DecodedInst :: *) = {
    ProcTypes.iType :: ProcTypes.IType;
    ProcTypes.aluFunc :: ProcTypes.AluFunc;
    ProcTypes.brFunc :: ProcTypes.BrFunc;
    ProcTypes.dst :: ¶Prelude®¶.¶Maybe®¶ ProcTypes.FullIndx;
    ProcTypes.src1 :: ¶Prelude®¶.¶Maybe®¶ ProcTypes.FullIndx;
    ProcTypes.src2 :: ¶Prelude®¶.¶Maybe®¶ ProcTypes.FullIndx;
    ProcTypes.imm :: ¶Prelude®¶.¶Maybe®¶ Types.Data
};
 
instance ProcTypes ¶Prelude®¶.¶PrimMakeUndefined®¶ ProcTypes.DecodedInst;
									
instance ProcTypes ¶Prelude®¶.¶PrimDeepSeqCond®¶ ProcTypes.DecodedInst;
								      
instance ProcTypes ¶Prelude®¶.¶PrimMakeUninitialized®¶ ProcTypes.DecodedInst;
									    
instance ProcTypes ¶Prelude®¶.¶Bits®¶ ProcTypes.DecodedInst 65;
							      
instance ProcTypes ¶Prelude®¶.¶Eq®¶ ProcTypes.DecodedInst;
							 
struct (ProcTypes.ExecInst :: *) = {
    ProcTypes.iType :: ProcTypes.IType;
    ProcTypes.dst :: ¶Prelude®¶.¶Maybe®¶ ProcTypes.FullIndx;
    ProcTypes.¡data¡ :: Types.Data;
    ProcTypes.addr :: Types.Addr;
    ProcTypes.mispredict :: ¶Prelude®¶.¶Bool®¶;
    ProcTypes.brTaken :: ¶Prelude®¶.¶Bool®¶
};
 
instance ProcTypes ¶Prelude®¶.¶PrimMakeUndefined®¶ ProcTypes.ExecInst;
								     
instance ProcTypes ¶Prelude®¶.¶PrimDeepSeqCond®¶ ProcTypes.ExecInst;
								   
instance ProcTypes ¶Prelude®¶.¶PrimMakeUninitialized®¶ ProcTypes.ExecInst;
									 
instance ProcTypes ¶Prelude®¶.¶Bits®¶ ProcTypes.ExecInst 77;
							   
instance ProcTypes ¶Prelude®¶.¶Eq®¶ ProcTypes.ExecInst;
						      
ProcTypes.opFUNC :: ¶Prelude®¶.¶Bit®¶ 6;
				       
ProcTypes.opRT :: ¶Prelude®¶.¶Bit®¶ 6;
				     
ProcTypes.opRS :: ¶Prelude®¶.¶Bit®¶ 6;
				     
ProcTypes.opLB :: ¶Prelude®¶.¶Bit®¶ 6;
				     
ProcTypes.opLH :: ¶Prelude®¶.¶Bit®¶ 6;
				     
ProcTypes.opLW :: ¶Prelude®¶.¶Bit®¶ 6;
				     
ProcTypes.opLBU :: ¶Prelude®¶.¶Bit®¶ 6;
				      
ProcTypes.opLHU :: ¶Prelude®¶.¶Bit®¶ 6;
				      
ProcTypes.opSB :: ¶Prelude®¶.¶Bit®¶ 6;
				     
ProcTypes.opSH :: ¶Prelude®¶.¶Bit®¶ 6;
				     
ProcTypes.opSW :: ¶Prelude®¶.¶Bit®¶ 6;
				     
ProcTypes.opADDIU :: ¶Prelude®¶.¶Bit®¶ 6;
					
ProcTypes.opSLTI :: ¶Prelude®¶.¶Bit®¶ 6;
				       
ProcTypes.opSLTIU :: ¶Prelude®¶.¶Bit®¶ 6;
					
ProcTypes.opANDI :: ¶Prelude®¶.¶Bit®¶ 6;
				       
ProcTypes.opORI :: ¶Prelude®¶.¶Bit®¶ 6;
				      
ProcTypes.opXORI :: ¶Prelude®¶.¶Bit®¶ 6;
				       
ProcTypes.opLUI :: ¶Prelude®¶.¶Bit®¶ 6;
				      
ProcTypes.opJ :: ¶Prelude®¶.¶Bit®¶ 6;
				    
ProcTypes.opJAL :: ¶Prelude®¶.¶Bit®¶ 6;
				      
ProcTypes.fcJR :: ¶Prelude®¶.¶Bit®¶ 6;
				     
ProcTypes.fcJALR :: ¶Prelude®¶.¶Bit®¶ 6;
				       
ProcTypes.opBEQ :: ¶Prelude®¶.¶Bit®¶ 6;
				      
ProcTypes.opBNE :: ¶Prelude®¶.¶Bit®¶ 6;
				      
ProcTypes.opBLEZ :: ¶Prelude®¶.¶Bit®¶ 6;
				       
ProcTypes.opBGTZ :: ¶Prelude®¶.¶Bit®¶ 6;
				       
ProcTypes.rtBLTZ :: ¶Prelude®¶.¶Bit®¶ 5;
				       
ProcTypes.rtBGEZ :: ¶Prelude®¶.¶Bit®¶ 5;
				       
ProcTypes.rsMFC0 :: ¶Prelude®¶.¶Bit®¶ 5;
				       
ProcTypes.rsMTC0 :: ¶Prelude®¶.¶Bit®¶ 5;
				       
ProcTypes.rsERET :: ¶Prelude®¶.¶Bit®¶ 5;
				       
ProcTypes.fcSLL :: ¶Prelude®¶.¶Bit®¶ 6;
				      
ProcTypes.fcSRL :: ¶Prelude®¶.¶Bit®¶ 6;
				      
ProcTypes.fcSRA :: ¶Prelude®¶.¶Bit®¶ 6;
				      
ProcTypes.fcSLLV :: ¶Prelude®¶.¶Bit®¶ 6;
				       
ProcTypes.fcSRLV :: ¶Prelude®¶.¶Bit®¶ 6;
				       
ProcTypes.fcSRAV :: ¶Prelude®¶.¶Bit®¶ 6;
				       
ProcTypes.fcADDU :: ¶Prelude®¶.¶Bit®¶ 6;
				       
ProcTypes.fcSUBU :: ¶Prelude®¶.¶Bit®¶ 6;
				       
ProcTypes.fcAND :: ¶Prelude®¶.¶Bit®¶ 6;
				      
ProcTypes.fcOR :: ¶Prelude®¶.¶Bit®¶ 6;
				     
ProcTypes.fcXOR :: ¶Prelude®¶.¶Bit®¶ 6;
				      
ProcTypes.fcNOR :: ¶Prelude®¶.¶Bit®¶ 6;
				      
ProcTypes.fcSLT :: ¶Prelude®¶.¶Bit®¶ 6;
				      
ProcTypes.fcSLTU :: ¶Prelude®¶.¶Bit®¶ 6;
				       
ProcTypes.fcMULT :: ¶Prelude®¶.¶Bit®¶ 6;
				       
ProcTypes.dataHazard :: ¶Prelude®¶.¶Maybe®¶ ProcTypes.RIndx ->
			¶Prelude®¶.¶Maybe®¶ ProcTypes.RIndx ->
			¶Prelude®¶.¶Maybe®¶ ProcTypes.RIndx -> ¶Prelude®¶.¶Bool®¶;
										 
ProcTypes.showInst :: Types.Data -> ¶Prelude®¶.¶Fmt®¶
}
