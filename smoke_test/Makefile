LABNAME = Smoke Test to check Bluespec installation
SHORTNAME = FibOne
SMOKENAME = FibOne

BSC=bsc


## Default simulator is iverilog
VSIM = -vsim iverilog

ifdef vcsi
    VSIM = -vsim vcsi
endif

ifdef vcs
    VSIM = -vsim vcs
endif

ifdef ncverilog
    VSIM = -vsim ncverilog
endif

ifdef ncsim
    VSIM = -vsim ncsim
endif

ifdef modelsim
    VSIM = -vsim modelsim
endif

ifdef cver
     VSIM = -vsim cver
endif

.PHONY: help
help:
	@echo "Bluespec $(LABNAME)"
	@echo "Useful targets:"
	@echo "  smoke_test     --  runs a basic test of the Bluespec installation"
	@echo "   to specific alternate simulator."
	@echo "   default is iverilog, use vcs=1, vcsi=1, ncverilog=1, ncsim=1, cver=1 modelsim=1"
	@echo "  smoke_test_bluesim --  runs a basic test for Bluespec's Bluesim simulator installation"
	@echo "  debug_license  -- run FlexLM diagnostic utility"
	@echo " " 
	@echo "  mk$(SHORTNAME)_v     --  build $(SHORTNAME) Verilog simulator"
	@echo "     specify verilog simulator as above"
	@echo "  mk$(SHORTNAME).v     --  build $(SHORTNAME) Verilog "
	@echo " " 
	@echo "  clean          --  remove intermediate files"
	@echo "  help           --  display this message"


# compile to Verilog
mk%.v: %.bsv
	$(BSC) -u -verilog -cross-info $<

# link with Verilog simulator 
mk%_v: mk%.v
	$(BSC) -o $@ -e mk$* %^

.PRECIOUS: mk%.v

ifndef RUNTEST
.PHONY: clean
clean:
	@rm -f *.bi *.bo *.ba mk*.c mk*.h mk*.o mk*.v *_c *_v *.vcd *~ *.fsdb *.log
	@rm -f smoke_test smoke_test_bluesim
	@rm -rf csrc INCA_libs simv.daidir vfastLog/  nWaveLog/ work_mkFibOne/
endif

## A target to check the installation of bsc
.PHONY:	smoke_test 
smoke_test: clean
	@echo ""
	@echo "Checking Verilog generation"
	@sleep 2
	$(BSC) -verilog -keep-fires -cross-info -no-inline-reg $(SMOKENAME).bsv
	@sleep 2
	@echo "Checking Verilog simulation"
	@sleep 2
	$(BSC) $(VSIM) -e mk$(SMOKENAME) -o mk$(SMOKENAME)_v mk$(SMOKENAME).v
	@sleep 2
	./mk$(SMOKENAME)_v  > smoke_test.out 
	@echo ""
	@echo "Comparing result of Bluespec Simulation" 
	@echo "Some simulator specific difference expected"	
	@sleep 2
	-diff mk$(SMOKENAME).out.expected smoke_test.out 
	@echo ""
	@echo "Bluespec installation looks OK"


smoke_test_bluesim: clean
	@echo "Checking bsc compiles"
	@sleep 2
	$(BSC) -sim $(SMOKENAME).bsv
	@echo ""
	@echo "Checking compile for Bluespec simulator"	
	@sleep 2
	$(BSC) -sim -o $@ -e mk$(SMOKENAME) mk$(SMOKENAME).ba
	./$@ > smoke_test.bluesim.out 
	@echo ""
	@echo "Comparing result of Bluespec Simulation" 
	@sleep 2
	diff mk$(SMOKENAME).out.expected smoke_test.bluesim.out 
	@echo ""
	@echo "Bluespec's Bluesim looks OK"


.PHONY:  debug_license
debug_license:
	@echo "lmdiag can be found in the Bluespec distribution, used util/flexlm/<platform>/"
	lmdiag BCOMP
