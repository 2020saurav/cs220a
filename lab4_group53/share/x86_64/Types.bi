signature Types where {
import ¶List®¶;
	      
import ¶PrimArray®¶;
		   
import ¶Vector®¶;
		
type (Types.AddrSz :: #) = 32;
			     
type (Types.Addr :: *) = ¶Prelude®¶.¶Bit®¶ Types.AddrSz;
						       
type (Types.DataSz :: #) = 32;
			     
type (Types.Data :: *) = ¶Prelude®¶.¶Bit®¶ Types.DataSz
}
