#!/bin/tcsh
source /home/cad/synopsys/synopsys.tcsh
dc_shell-xg-t -topo -64 -output_log_file synt.log -f scripts/go_synth.tcl 
