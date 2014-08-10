signature Ehr where {
import ¶List®¶;
	      
import ¶PrimArray®¶;
		   
import ¶RWire®¶;
	       
import ¶Vector®¶;
		
type (Ehr.Ehr :: # -> * -> *) n t = ¶Vector®¶.¶Vector®¶ n (¶Prelude®¶.¶Reg®¶ t);
									       
Ehr.mkEhr :: (¶Prelude®¶.¶Bits®¶ t tSz, ¶Prelude®¶.¶IsModule®¶ _m__ _c__) => t -> _m__ (Ehr.Ehr n t)
}
