signature Multiplexer where {
Multiplexer.and1 :: ¶Prelude®¶.¶Bit®¶ 1 -> ¶Prelude®¶.¶Bit®¶ 1 -> ¶Prelude®¶.¶Bit®¶ 1;
										     
Multiplexer.or1 :: ¶Prelude®¶.¶Bit®¶ 1 -> ¶Prelude®¶.¶Bit®¶ 1 -> ¶Prelude®¶.¶Bit®¶ 1;
										    
Multiplexer.not1 :: ¶Prelude®¶.¶Bit®¶ 1 -> ¶Prelude®¶.¶Bit®¶ 1;
							      
Multiplexer.multiplexer1 :: ¶Prelude®¶.¶Bit®¶ 1 ->
			    ¶Prelude®¶.¶Bit®¶ 1 -> ¶Prelude®¶.¶Bit®¶ 1 -> ¶Prelude®¶.¶Bit®¶ 1;
											     
Multiplexer.multiplexer32 :: ¶Prelude®¶.¶Bit®¶ 1 ->
			     ¶Prelude®¶.¶Bit®¶ 32 -> ¶Prelude®¶.¶Bit®¶ 32 -> ¶Prelude®¶.¶Bit®¶ 32;
												 
type (Multiplexer.N :: #) = 32;
			      
Multiplexer.multiplexerN :: ¶Prelude®¶.¶Bit®¶ 1 ->
			    ¶Prelude®¶.¶Bit®¶ Multiplexer.N ->
			    ¶Prelude®¶.¶Bit®¶ Multiplexer.N -> ¶Prelude®¶.¶Bit®¶ Multiplexer.N;
											      
Multiplexer.multiplexer_n :: ¶Prelude®¶.¶Bit®¶ 1 ->
			     ¶Prelude®¶.¶Bit®¶ n -> ¶Prelude®¶.¶Bit®¶ n -> ¶Prelude®¶.¶Bit®¶ n
}
