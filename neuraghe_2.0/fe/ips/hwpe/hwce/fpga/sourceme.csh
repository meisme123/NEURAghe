#!/bin/csh

# either "zedboard" or "zc706"
setenv BOARD "zc706"

if ($BOARD == "zedboard") then
  setenv XILINX_PART  xc7z020clg484-1
  setenv XILINX_BOARD em.avnet.com:zynq:zed:c
else
  setenv XILINX_PART  xc7z045ffg900-2
  setenv XILINX_BOARD xilinx.com:zynq:zc706:b
endif

setenv PATH "${PATH}:/opt/cad/xilinx/14.5/ISE_DS/EDK/bin/lin64/"

