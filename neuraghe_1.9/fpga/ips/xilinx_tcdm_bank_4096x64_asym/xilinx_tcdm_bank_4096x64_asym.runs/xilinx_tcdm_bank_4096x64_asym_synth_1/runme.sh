#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/eda/Xilinx/SDK/2016.2/bin:/eda/Xilinx/Vivado/2016.2/ids_lite/ISE/bin/lin64:/eda/Xilinx/Vivado/2016.2/bin
else
  PATH=/eda/Xilinx/SDK/2016.2/bin:/eda/Xilinx/Vivado/2016.2/ids_lite/ISE/bin/lin64:/eda/Xilinx/Vivado/2016.2/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/eda/Xilinx/Vivado/2016.2/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/eda/Xilinx/Vivado/2016.2/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/gderiu/neuraghe_wei2ddr_fast/fpga/ips/xilinx_tcdm_bank_4096x64_asym/xilinx_tcdm_bank_4096x64_asym.runs/xilinx_tcdm_bank_4096x64_asym_synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log xilinx_tcdm_bank_4096x64_asym.vds -m64 -mode batch -messageDb vivado.pb -notrace -source xilinx_tcdm_bank_4096x64_asym.tcl