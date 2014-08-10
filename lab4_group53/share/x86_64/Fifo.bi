signature Fifo where {
import ¶List®¶;
	      
import ¶PrimArray®¶;
		   
import ¶RWire®¶;
	       
import ¶Vector®¶;
		
import Ehr;
	  
interface (Fifo.Fifo :: # -> * -> *) n t = {
    Fifo.notFull :: ¶Prelude®¶.¶Bool®¶ {-# arg_names = [] #-};
    Fifo.enq :: t -> ¶Prelude®¶.¶Action®¶ {-# arg_names = [x] #-};
    Fifo.notEmpty :: ¶Prelude®¶.¶Bool®¶ {-# arg_names = [] #-};
    Fifo.deq :: ¶Prelude®¶.¶Action®¶ {-# arg_names = [] #-};
    Fifo.first :: t {-# arg_names = [] #-};
    Fifo.clear :: ¶Prelude®¶.¶Action®¶ {-# arg_names = [] #-}
};
 
instance Fifo (¶Prelude®¶.¶PrimMakeUndefined®¶ t) =>
	      ¶Prelude®¶.¶PrimMakeUndefined®¶ (Fifo.Fifo n t);
							     
instance Fifo (¶Prelude®¶.¶PrimDeepSeqCond®¶ t) => ¶Prelude®¶.¶PrimDeepSeqCond®¶ (Fifo.Fifo n t);
												
instance Fifo (¶Prelude®¶.¶PrimMakeUninitialized®¶ t) =>
	      ¶Prelude®¶.¶PrimMakeUninitialized®¶ (Fifo.Fifo n t);
								 
Fifo.mkCFFifo :: (¶Prelude®¶.¶Add®¶ sz 1 sz1,
		  Prelude.Log n1 sz,
		  ¶Prelude®¶.¶Add®¶ n 1 n1,
		  ¶Prelude®¶.¶Bits®¶ t tSz,
		  ¶Prelude®¶.¶IsModule®¶ _m__ _c__) =>
		 _m__ (Fifo.Fifo n t);
				     
Fifo.mkPipelineFifo :: (¶Prelude®¶.¶Add®¶ sz 1 sz1,
			Prelude.Log n1 sz,
			¶Prelude®¶.¶Add®¶ n 1 n1,
			¶Prelude®¶.¶Bits®¶ t tSz,
			¶Prelude®¶.¶IsModule®¶ _m__ _c__) =>
		       _m__ (Fifo.Fifo n t);
					   
Fifo.mkBypassFifo :: (¶Prelude®¶.¶Add®¶ sz 1 sz1,
		      Prelude.Log n1 sz,
		      ¶Prelude®¶.¶Add®¶ n 1 n1,
		      ¶Prelude®¶.¶Bits®¶ t tSz,
		      ¶Prelude®¶.¶IsModule®¶ _m__ _c__) =>
		     _m__ (Fifo.Fifo n t);
					 
interface (Fifo.SFifo :: # -> * -> * -> *) n t st = {
    Fifo.notFull :: ¶Prelude®¶.¶Bool®¶ {-# arg_names = [] #-};
    Fifo.enq :: t -> ¶Prelude®¶.¶Action®¶ {-# arg_names = [x] #-};
    Fifo.notEmpty :: ¶Prelude®¶.¶Bool®¶ {-# arg_names = [] #-};
    Fifo.deq :: ¶Prelude®¶.¶Action®¶ {-# arg_names = [] #-};
    Fifo.search :: st -> ¶Prelude®¶.¶Bool®¶ {-# arg_names = [s] #-};
    Fifo.first :: t {-# arg_names = [] #-};
    Fifo.clear :: ¶Prelude®¶.¶Action®¶ {-# arg_names = [] #-}
};
 
instance Fifo (¶Prelude®¶.¶PrimMakeUndefined®¶ t) =>
	      ¶Prelude®¶.¶PrimMakeUndefined®¶ (Fifo.SFifo n t st);
								 
instance Fifo (¶Prelude®¶.¶PrimDeepSeqCond®¶ t) =>
	      ¶Prelude®¶.¶PrimDeepSeqCond®¶ (Fifo.SFifo n t st);
							       
instance Fifo (¶Prelude®¶.¶PrimMakeUninitialized®¶ t) =>
	      ¶Prelude®¶.¶PrimMakeUninitialized®¶ (Fifo.SFifo n t st);
								     
Fifo.mkCFSFifo :: (¶Prelude®¶.¶Add®¶ sz 1 sz1,
		   Prelude.Log n1 sz,
		   ¶Prelude®¶.¶Add®¶ n 1 n1,
		   ¶Prelude®¶.¶Bits®¶ t tSz,
		   ¶Prelude®¶.¶IsModule®¶ _m__ _c__) =>
		  (t -> st -> ¶Prelude®¶.¶Bool®¶) -> _m__ (Fifo.SFifo n t st);
									     
Fifo.mkPipelineSFifo :: (¶Prelude®¶.¶Bits®¶ st stz,
			 ¶Prelude®¶.¶Add®¶ sz 1 sz1,
			 Prelude.Log n1 sz,
			 ¶Prelude®¶.¶Add®¶ n 1 n1,
			 ¶Prelude®¶.¶Bits®¶ t tSz,
			 ¶Prelude®¶.¶IsModule®¶ _m__ _c__) =>
			(t -> st -> ¶Prelude®¶.¶Bool®¶) -> _m__ (Fifo.SFifo n t st);
										   
interface (Fifo.SCountFifo :: # -> * -> * -> *) n t st = {
    Fifo.notFull :: ¶Prelude®¶.¶Bool®¶ {-# arg_names = [] #-};
    Fifo.enq :: t -> ¶Prelude®¶.¶Action®¶ {-# arg_names = [x] #-};
    Fifo.notEmpty :: ¶Prelude®¶.¶Bool®¶ {-# arg_names = [] #-};
    Fifo.deq :: ¶Prelude®¶.¶Action®¶ {-# arg_names = [] #-};
    Fifo.search :: st ->
		   ¶Prelude®¶.¶Bit®¶ (¶Prelude®¶.¶TLog®¶ (¶Prelude®¶.¶TAdd®¶ n 1)) {-# arg_names = [s] #-};
    Fifo.first :: t {-# arg_names = [] #-};
    Fifo.clear :: ¶Prelude®¶.¶Action®¶ {-# arg_names = [] #-}
};
 
instance Fifo (¶Prelude®¶.¶PrimMakeUndefined®¶ t) =>
	      ¶Prelude®¶.¶PrimMakeUndefined®¶ (Fifo.SCountFifo n t st);
								      
instance Fifo (¶Prelude®¶.¶PrimDeepSeqCond®¶ t) =>
	      ¶Prelude®¶.¶PrimDeepSeqCond®¶ (Fifo.SCountFifo n t st);
								    
instance Fifo (¶Prelude®¶.¶PrimMakeUninitialized®¶ t) =>
	      ¶Prelude®¶.¶PrimMakeUninitialized®¶ (Fifo.SCountFifo n t st);
									  
Fifo.mkCFSCountFifo :: (¶Prelude®¶.¶Add®¶ sz 1 sz1,
			Prelude.Log n1 sz,
			¶Prelude®¶.¶Add®¶ n 1 n1,
			¶Prelude®¶.¶Bits®¶ t tSz,
			¶Prelude®¶.¶IsModule®¶ _m__ _c__) =>
		       (t -> st -> ¶Prelude®¶.¶Bool®¶) -> _m__ (Fifo.SCountFifo n t st)
}
