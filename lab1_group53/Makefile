
compile:
	mkdir -p buildDir
	rm -f buildDir/*.cpp
	cp *.cpp ./buildDir/.
	bsc -u -sim -bdir buildDir -info-dir buildDir -simdir buildDir -vdir buildDir -aggressive-conditions -p +:../common-lib TestBench.bsv

mul: compile
	bsc -sim -e mkTbMultiplexer -bdir buildDir -info-dir buildDir -simdir buildDir -o simMul buildDir/*.ba buildDir/*.cpp

rl: compile
	bsc -sim -e mkTbRightLogical -bdir buildDir -info-dir buildDir -simdir buildDir -o simRl buildDir/*.ba buildDir/*.cpp

ra: compile
	bsc -sim -e mkTbRightArith -bdir buildDir -info-dir buildDir -simdir buildDir -o simRa buildDir/*.ba buildDir/*.cpp

all: ra rl mul

clean:
	rm -rf buildDir sim*

.PHONY: clean all ra rl mul compile
.DEFAULT_GOAL := all
