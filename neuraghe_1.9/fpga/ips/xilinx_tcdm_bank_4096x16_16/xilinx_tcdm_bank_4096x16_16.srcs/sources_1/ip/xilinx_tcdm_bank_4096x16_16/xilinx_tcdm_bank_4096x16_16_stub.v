// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
// Date        : Tue Dec 18 13:45:36 2018
// Host        : eolab running 64-bit SUSE Linux Enterprise Server 12
// Command     : write_verilog -force -mode synth_stub
//               /home/gderiu/marco/neuraghe_zc706_8_16_runtime_dma2d_lenhack/fpga/ips/xilinx_tcdm_bank_4096x16_16/xilinx_tcdm_bank_4096x16_16.srcs/sources_1/ip/xilinx_tcdm_bank_4096x16_16/xilinx_tcdm_bank_4096x16_16_stub.v
// Design      : xilinx_tcdm_bank_4096x16_16
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z045ffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_5,Vivado 2016.4" *)
module xilinx_tcdm_bank_4096x16_16(clka, rsta, ena, wea, addra, dina, douta, clkb, enb, web, 
  addrb, dinb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,rsta,ena,wea[1:0],addra[11:0],dina[15:0],douta[15:0],clkb,enb,web[1:0],addrb[11:0],dinb[15:0],doutb[15:0]" */;
  input clka;
  input rsta;
  input ena;
  input [1:0]wea;
  input [11:0]addra;
  input [15:0]dina;
  output [15:0]douta;
  input clkb;
  input enb;
  input [1:0]web;
  input [11:0]addrb;
  input [15:0]dinb;
  output [15:0]doutb;
endmodule
