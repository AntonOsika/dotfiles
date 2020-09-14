#!/bin/bash

# Used like:
# ./gprof.sh program_name cpp_name

g++-8 -fopenmp -O3 -o $1 $2.cpp
CPUPROFILE=$1.prof DYLD_INSERT_LIBRARIES=/usr/local/Cellar/gperftools/2.7/lib/libprofiler.dylib ./$1
pprof --pdf $1 $1.prof > $1.pdf
echo "Profiling results: $1.pdf"

