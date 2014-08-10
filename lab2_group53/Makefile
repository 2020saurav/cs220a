compile:
	mkdir -p buildDir
	rm -f buildDir/*.cpp
	cp ./lib/*.cpp ./buildDir/.
	bsc -u -sim -bdir buildDir -info-dir buildDir -simdir buildDir -vdir buildDir -aggressive-conditions -p +:lib TestBench.bsv

def: compile
	bsc -sim -e mkDefaultTb -bdir buildDir -info-dir buildDir -simdir buildDir -o simDef buildDir/*.ba buildDir/*.cpp

sign: compile
	bsc -sim -e mkSignedTb -bdir buildDir -info-dir buildDir -simdir buildDir -o simSign buildDir/*.ba buildDir/*.cpp

booth: compile
	bsc -sim -e mkBoothTb -bdir buildDir -info-dir buildDir -simdir buildDir -o simBooth buildDir/*.ba buildDir/*.cpp

all: def sign booth

clean:
	rm -rf buildDir sim*

.PHONY: clean all def sign booth
.DEFAULT_GOAL := all
