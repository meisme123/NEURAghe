vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm
vlib activehdl/axi_infrastructure_v1_1_0
vlib activehdl/xil_common_vip_v1_0_0
vlib activehdl/smartconnect_v1_0
vlib activehdl/axi_protocol_checker_v1_1_13
vlib activehdl/axi_vip_v1_0_1
vlib activehdl/lib_cdc_v1_0_2
vlib activehdl/proc_sys_reset_v5_0_11
vlib activehdl/generic_baseblocks_v2_1_0
vlib activehdl/fifo_generator_v13_1_4
vlib activehdl/axi_data_fifo_v2_1_11
vlib activehdl/axi_register_slice_v2_1_12
vlib activehdl/axi_protocol_converter_v2_1_12
vlib activehdl/axi_clock_converter_v2_1_11
vlib activehdl/blk_mem_gen_v8_3_6
vlib activehdl/axi_dwidth_converter_v2_1_12
vlib activehdl/axi_crossbar_v2_1_13

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm
vmap axi_infrastructure_v1_1_0 activehdl/axi_infrastructure_v1_1_0
vmap xil_common_vip_v1_0_0 activehdl/xil_common_vip_v1_0_0
vmap smartconnect_v1_0 activehdl/smartconnect_v1_0
vmap axi_protocol_checker_v1_1_13 activehdl/axi_protocol_checker_v1_1_13
vmap axi_vip_v1_0_1 activehdl/axi_vip_v1_0_1
vmap lib_cdc_v1_0_2 activehdl/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_11 activehdl/proc_sys_reset_v5_0_11
vmap generic_baseblocks_v2_1_0 activehdl/generic_baseblocks_v2_1_0
vmap fifo_generator_v13_1_4 activehdl/fifo_generator_v13_1_4
vmap axi_data_fifo_v2_1_11 activehdl/axi_data_fifo_v2_1_11
vmap axi_register_slice_v2_1_12 activehdl/axi_register_slice_v2_1_12
vmap axi_protocol_converter_v2_1_12 activehdl/axi_protocol_converter_v2_1_12
vmap axi_clock_converter_v2_1_11 activehdl/axi_clock_converter_v2_1_11
vmap blk_mem_gen_v8_3_6 activehdl/blk_mem_gen_v8_3_6
vmap axi_dwidth_converter_v2_1_12 activehdl/axi_dwidth_converter_v2_1_12
vmap axi_crossbar_v2_1_13 activehdl/axi_crossbar_v2_1_13

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"/eda/Xilinx/Vivado/2017.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/eda/Xilinx/Vivado/2017.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/eda/Xilinx/Vivado/2017.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work xil_common_vip_v1_0_0  -sv2k12 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl/xil_common_vip_v1_0_vl_rfs.sv" \

vlog -work smartconnect_v1_0  -sv2k12 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/sc_util_v1_0_vl_rfs.sv" \

vlog -work axi_protocol_checker_v1_1_13  -sv2k12 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/8017/hdl/axi_protocol_checker_v1_1_vl_rfs.sv" \

vlog -work axi_vip_v1_0_1  -sv2k12 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl/axi_vip_v1_0_vl_rfs.sv" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../bd/base_zynq_design/ip/base_zynq_design_processing_system7_0_0/sim/base_zynq_design_processing_system7_0_0.v" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/52cb/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_11 -93 \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/5db7/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/base_zynq_design/ip/base_zynq_design_rst_processing_system7_0_50M_0/sim/base_zynq_design_rst_processing_system7_0_50M_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/56b5/hdl/soc_AXI_ctrl_v1_0_S00_AXI.v" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/56b5/hdl/soc_AXI_ctrl_v1_0.v" \
"../../../bd/base_zynq_design/ip/base_zynq_design_soc_AXI_ctrl_v1_0_0_0/sim/base_zynq_design_soc_AXI_ctrl_v1_0_0_0.v" \

vlog -work generic_baseblocks_v2_1_0  -v2k5 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/f9c1/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_1_4  -v2k5 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/ebc2/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_1_4 -93 \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/ebc2/hdl/fifo_generator_v13_1_rfs.vhd" \

vlog -work fifo_generator_v13_1_4  -v2k5 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/ebc2/hdl/fifo_generator_v13_1_rfs.v" \

vlog -work axi_data_fifo_v2_1_11  -v2k5 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/5235/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_12  -v2k5 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/0e33/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work axi_protocol_converter_v2_1_12  -v2k5 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/138d/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../bd/base_zynq_design/ip/base_zynq_design_axi_protocol_converter_0_0/sim/base_zynq_design_axi_protocol_converter_0_0.v" \
"../../../bd/base_zynq_design/ip/base_zynq_design_axi_protocol_converter_1_0/sim/base_zynq_design_axi_protocol_converter_1_0.v" \

vlog -work axi_clock_converter_v2_1_11  -v2k5 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/c526/hdl/axi_clock_converter_v2_1_vl_rfs.v" \

vlog -work blk_mem_gen_v8_3_6  -v2k5 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/4158/simulation/blk_mem_gen_v8_3.v" \

vlog -work axi_dwidth_converter_v2_1_12  -v2k5 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/fef9/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../bd/base_zynq_design/ip/base_zynq_design_axi_dwidth_converter_0_0/sim/base_zynq_design_axi_dwidth_converter_0_0.v" \
"../../../bd/base_zynq_design/ip/base_zynq_design_clk_wiz_1_0/base_zynq_design_clk_wiz_1_0_clk_wiz.v" \
"../../../bd/base_zynq_design/ip/base_zynq_design_clk_wiz_1_0/base_zynq_design_clk_wiz_1_0.v" \

vlog -work axi_crossbar_v2_1_13  -v2k5 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/78eb/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../bd/base_zynq_design/ip/base_zynq_design_xbar_0/sim/base_zynq_design_xbar_0.v" \
"../../../bd/base_zynq_design/ip/base_zynq_design_axi_protocol_converter_0_1/sim/base_zynq_design_axi_protocol_converter_0_1.v" \
"../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/b2d6/ulpsoc_stub.v" \
"../../../bd/base_zynq_design/ip/base_zynq_design_nuraghe_soc_0_0/sim/base_zynq_design_nuraghe_soc_0_0.v" \
"../../../bd/base_zynq_design/ip/base_zynq_design_axi_protocol_converter_3_0/sim/base_zynq_design_axi_protocol_converter_3_0.v" \

vcom -work xil_defaultlib -93 \
"../../../bd/base_zynq_design/hdl/base_zynq_design.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/7e3a/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/2ad9/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/16a2/hdl/verilog" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/856d/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/d5eb/hdl" "+incdir+../../../../pulp_on_zynq.srcs/sources_1/bd/base_zynq_design/ipshared/65a4" \
"../../../bd/base_zynq_design/ip/base_zynq_design_auto_ds_0/sim/base_zynq_design_auto_ds_0.v" \
"../../../bd/base_zynq_design/ip/base_zynq_design_auto_pc_0/sim/base_zynq_design_auto_pc_0.v" \
"../../../bd/base_zynq_design/ip/base_zynq_design_auto_us_0/sim/base_zynq_design_auto_us_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

