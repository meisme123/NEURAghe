// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
// Date        : Wed Mar 27 12:45:56 2019
// Host        : eolab running 64-bit SUSE Linux Enterprise Server 12
// Command     : write_verilog -force -mode synth_stub
//               /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_1024x128_128/xilinx_tcdm_bank_1024x128_128.srcs/sources_1/ip/xilinx_tcdm_bank_1024x128_128/xilinx_tcdm_bank_1024x128_128_stub.v
// Design      : xilinx_tcdm_bank_1024x128_128
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z045ffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_5,Vivado 2016.4" *)
module xilinx_tcdm_bank_1024x128_128(clka, rsta, ena, wea, addra, dina, douta, clkb, enb, web, 
  addrb, dinb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,rsta,ena,wea[7:0],addra[10:0],dina[63:0],douta[63:0],clkb,enb,web[15:0],addrb[9:0],dinb[127:0],doutb[127:0]" */;
  input clka;
  input rsta;
  input ena;
  input [7:0]wea;
  input [10:0]addra;
  input [63:0]dina;
  output [63:0]douta;
  input clkb;
  input enb;
  input [15:0]web;
  input [9:0]addrb;
  input [127:0]dinb;
  output [127:0]doutb;
endmodule
