#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/mnt/data/Xilinx/SDK/2015.4/bin:/mnt/data/Xilinx/Vivado/2015.4/ids_lite/ISE/bin/lin64:/mnt/data/Xilinx/Vivado/2015.4/bin
else
  PATH=/mnt/data/Xilinx/SDK/2015.4/bin:/mnt/data/Xilinx/Vivado/2015.4/ids_lite/ISE/bin/lin64:/mnt/data/Xilinx/Vivado/2015.4/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/mnt/data/Xilinx/Vivado/2015.4/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/mnt/data/Xilinx/Vivado/2015.4/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/gian/pulp/nuraghe/fpga/ips/xilinx_l2_mem_8192x64_dp/xilinx_l2_mem_8192x64_dp.runs/xilinx_l2_mem_8192x64_dp_synth_1'
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

EAStep vivado -log xilinx_l2_mem_8192x64_dp.vds -m64 -mode batch -messageDb vivado.pb -notrace -source xilinx_l2_mem_8192x64_dp.tcl