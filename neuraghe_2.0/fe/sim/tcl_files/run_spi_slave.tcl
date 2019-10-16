#!/bin/bash 
# \
exec vsim -64 -do "$0"

set TB            tb
set VSIM_FLAGS    "-gLOAD_L2=\"SPI\" -gINTERNAL_EOC=\"FALSE\" -gEXEC_TEST=\"SPISLAVE\""
# -pli ./work/jtag_vpi.so"

source ./tcl_files/vsim.tcl