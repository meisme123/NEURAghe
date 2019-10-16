# create project
create_project soc . -force -part $::env(XILINX_PART)
set_property board_part $::env(XILINX_BOARD) [current_project]
set_property include_dirs { \
	../../fe/rtl/includes \
	../../fe/ips/apb_peripherals/apb_i2c \
} [current_fileset]
set core "OR10N"
if { $core == "OR10N" } {
  set_property include_dirs { \
    ../../fe/ips/or10n/include \
    ../../fe/ips/cluster_interconnect/rtl/peripheral_interco \
    ../../fe/rtl/includes \
    ../../fe/ips/mchan/include \
    ../../fe/ips/cluster_peripherals/include \
    ../../fe/ips/cluster_peripherals/event_unit/include \
    ../../fe/ips/icache/icache_scm_sp/globals \
    ../../fe/ips/hwpe/hwce/rtl \
    ../../fe/ips/hwpe/hwpe-sm/rtl \
    ../../fe/ips/hwpe/hwpe-sm/rtl/axi \
  } [current_fileset]
}

source tcl/src_files.tcl

# set up meaningful errors
#source ../common/messages.tcl


# add xbar_tcdm
add_files -norecurse -scan_for_includes $SRC_XBAR_TCDM

# add xbar_per
add_files -norecurse -scan_for_includes $SRC_XBAR_PER

# add axi2mem
add_files -norecurse -scan_for_includes $SRC_AXI2MEM

# add axi2per
add_files -norecurse -scan_for_includes $SRC_AXI2PER

# add per2axi
add_files -norecurse -scan_for_includes $SRC_PER2AXI

# add wb2axi
add_files -norecurse -scan_for_includes $SRC_WB2AXI

# add axi_slice
add_files -norecurse -scan_for_includes $SRC_AXI_SLICE

# add axi_slice_dc
add_files -norecurse -scan_for_includes $SRC_AXI_SLICE_DC

# add axi_node
add_files -norecurse -scan_for_includes $SRC_AXI_NODE

# add cluster peripherals
add_files -norecurse -scan_for_includes $SRC_ICACHE_CTRL_UNIT
add_files -norecurse -scan_for_includes $SRC_CLUSTER_CONTROL_UNIT
add_files -norecurse -scan_for_includes $SRC_EVENT_UNIT
add_files -norecurse -scan_for_includes $SRC_MMU_CONFIG_UNIT
add_files -norecurse -scan_for_includes $SRC_TCDM_PIPE_UNIT
add_files -norecurse -scan_for_includes $SRC_TIMER_UNIT
add_files -norecurse -scan_for_includes $SRC_PERFCOUNTERS

# add generic register file
add_files -norecurse -scan_for_includes $SRC_REGFILE

# add or10n
if { $core == "OR10N" } {
  add_files -norecurse -scan_for_includes $SRC_OR10N
}

# add ri5cy
if { $core == "RI5CY" } {
  add_files -norecurse -scan_for_includes $SRC_RI5CY
}

# add memory cuts
#set SRAM_SIZE 4096x32
set SRAM_SIZE 8192x32


read_ip $FPGA_IPS/xilinx_tcdm_bank_4096x64_asym/ip/xilinx_tcdm_bank_4096x64_asym.xci
read_ip $FPGA_IPS/xilinx_tcdm_bank_2048x64_asym/ip/xilinx_tcdm_bank_2048x64_asym.xci
read_ip $FPGA_IPS/xilinx_tcdm_bank_$SRAM_SIZE/ip/xilinx_tcdm_bank_$SRAM_SIZE.xci

read_ip $FPGA_IPS/xilinx_tcdm_bank_2048x64/ip/xilinx_tcdm_bank_2048x64.xci

read_ip $FPGA_IPS/xilinx_tcdm_bank_512x64_16_Sdp/ip/xilinx_tcdm_bank_512x64_16.xci
read_ip $FPGA_IPS/xilinx_tcdm_bank_256x16_16_Sdp/ip/xilinx_tcdm_bank_256x16_16.xci

read_ip $FPGA_IPS/xilinx_tcdm_bank_2048x16_16_Sdp/ip/xilinx_tcdm_bank_2048x16_16_Sdp.xci
read_ip $FPGA_IPS/xilinx_tcdm_bank_1024x16_16_Sdp/ip/xilinx_tcdm_bank_1024x16_16_Sdp.xci
read_ip $FPGA_IPS/xilinx_tcdm_bank_4096x64_64/ip/xilinx_tcdm_bank_4096x64_64.xci
read_ip $FPGA_IPS/xilinx_tcdm_bank_2048x64_64/ip/xilinx_tcdm_bank_2048x64_64.xci
read_ip $FPGA_IPS/xilinx_tcdm_bank_2048x64_128/ip/xilinx_tcdm_bank_2048x64_128.xci

read_ip $FPGA_IPS/xilinx_icache_bank_data_16x128/ip/xilinx_icache_bank_data_16x128.xci 
read_ip $FPGA_IPS/xilinx_icache_bank_tag_16x8/ip/xilinx_icache_bank_tag_16x8.xci

#synth_ip [get_ips xilinx_tcdm_bank_$SRAM_SIZE]
#synth_ip [get_ips xilinx_tcdm_bank_256x32]

#synth_ip [get_ips xilinx_icache_bank_data_16x128]
#synth_ip [get_ips xilinx_icache_bank_tag_16x8]

# add minichan
add_files -norecurse $SRC_MCHAN

# add common cells
add_files -norecurse $SRC_COMMONCELLS

# add hwce
add_files -norecurse $SRC_HWCE

# add ulpcluster
add_files -norecurse $SRC_ULPCLUSTER



# add axi_slice
add_files -norecurse -scan_for_includes $SRC_AXI_SLICE

# add axi_slice_dc
add_files -norecurse -scan_for_includes $SRC_AXI_SLICE_DC

# add axi_node
add_files -norecurse -scan_for_includes $SRC_AXI_NODE

# add memory cuts
#read_ip $FPGA_IPS/xilinx_l2_mem_8192x64_dp2/ip/xilinx_l2_mem_8192x64_dp2.xci
read_ip $FPGA_IPS/xilinx_l2_mem_4096x64_dp2/ip/xilinx_l2_mem_4096x64_dp2.xci
read_ip $FPGA_IPS/xilinx_rom_bank_1024x64/ip/xilinx_rom_bank_1024x64.xci
#synth_ip [get_ips xilinx_l2_mem_32768x64]
#synth_ip [get_ips xilinx_rom_bank_1024x64]

# add adbg axionly (?)
add_files -norecurse $SRC_ADV_DEBUG_IF

add_files -norecurse $SRC_MEM_CUTS

# add interfaces
add_files -norecurse $SRC_INTERFACES

# add level_shifter
add_files -norecurse $SRC_LEVEL_SHIFTER

# add clock_inverter
add_files -norecurse $SRC_CLK_INVERTER

# add clock_mux2
add_files -norecurse $SRC_CLK_MUX2

# add axi_cvp_if
add_files -norecurse $SRC_AXI_CVP_IF

# add axi_id_remap
add_files -norecurse $SRC_AXI_ID_REMAP

# add axi_mem_if
add_files -norecurse $SRC_AXI_MEM_IF

# add axi_mem_if_DP
add_files -norecurse $SRC_AXI_MEM_IF_DP

# add axi_spi_master
add_files -norecurse $SRC_AXI_SPI_MASTER

# add axi_spi_slave
add_files -norecurse $SRC_AXI_SPI_SLAVE

# add axi_gpreg
add_files -norecurse $SRC_AXI_GPREG

# add axi2apb
add_files -norecurse $SRC_AXI2APB

# add apb soc peripherals
add_files -norecurse $SRC_APB_AUDIO
add_files -norecurse $SRC_APB_CLKDIV
add_files -norecurse $SRC_APB_FLL_IF
add_files -norecurse $SRC_APB_CVP_IF
add_files -norecurse $SRC_APB_GPIO
add_files -norecurse $SRC_APB_I2C
add_files -norecurse $SRC_APB_SPI_MASTER
add_files -norecurse $SRC_APB_UART
add_files -norecurse $SRC_APB_SOC_CTRL

# add jtag
add_files -norecurse $SRC_JTAG

# add (dummy) cvp
add_files -norecurse $SRC_DUMMY_CVP

# add rstgen
add_files -norecurse $SRC_RSTGEN

#add power module
add_files -norecurse $POWER_MODULE

# add ulpcluster
#if { $FAULT_INJECT == 1 } {
#  add_files -norecurse $FPGA_ULPCLUSTER/ulpcluster_faulty.edf
#  add_files -norecurse $FPGA_ULPCLUSTER/ulpcluster_faulty_stub.v
#  add_files -norecurse $FPGA_ULPCLUSTER/ulpcluster_faulty_wrap.sv
#} else {
 
#add_files -norecurse $FPGA_ULPCLUSTER/ulpcluster.edf
#add_files -norecurse $FPGA_ULPCLUSTER/ulpcluster_stub.v
#}
#add_files -norecurse $FPGA_RTL/ulpcluster_wrap.sv

# add ulpsoc
add_files -norecurse $SRC_ULPSOC

# add fault gen interface
#if { $FAULT_INJECT == 1 } {
#  add_files -norecurse $SRC_FAULT_GEN
#}

# set ulpsoc as top
set_property top ulpsoc [current_fileset]

# needed only if used in batch mode
#update_compile_order -fileset sources_1
#update_compile_order -fileset sim_1

# run synthesis
#if { $FAULT_INJECT == 1 } {
#  catch {
#    synth_design -rtl -name rtl_1 -verilog_define PULP_FAULTY_CLUSTER=1
#  }
#  update_compile_order -fileset sources_1
#  set_msg_config -id {Synth 8-350} -new_severity {CRITICAL WARNING}
#  synth_design -rtl -name rtl_1 -verilog_define PULP_FAULTY_CLUSTER=1
#} else {
#  catch {
#    synth_design -rtl -name rtl_1
#  }
#  update_compile_order -fileset sources_1
#  set_msg_config -id {Synth 8-350} -new_severity {CRITICAL WARNING}
#  synth_design -rtl -name rtl_1
#}

# constraints
# create_clock -period 4.000 -name clk_soc_i -waveform {0.000 2.000} [get_nets {clk_soc_i}]
#create_clock -period 4.000 -name clk_cluster_fast_i -waveform {0.000 2.000} [get_nets {clk_cluster_fast_i}]

set synth_name "synth_2"

create_run -flow {Vivado Synthesis 2016} -strategy "Flow_AreaOptimized_high" $synth_name
#rebuilt
#set_property STEPS.SYNTH_DESIGN.ARGS.DIRECTIVE                 AreaOptimized_high [get_runs $synth_name] 
#set_property STEPS.SYNTH_DESIGN.ARGS.SHREG_MIN_SIZE                  1 [get_runs $synth_name] 
#set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY         rebuilt [get_runs $synth_name] 
#set_property STEPS.SYNTH_DESIGN.ARGS.KEEP_EQUIVALENT_REGISTERS true    [get_runs $synth_name]
#set_property STEPS.SYNTH_DESIGN.ARGS.RESOURCE_SHARING          off     [get_runs $synth_name]
#set_property STEPS.SYNTH_DESIGN.ARGS.NO_LC                     true    [get_runs $synth_name]
#set_property STEPS.SYNTH_DESIGN.ARGS.FANOUT_LIMIT              40     [get_runs $synth_name]
#set_property STEPS.SYNTH_DESIGN.ARGS.FSM_EXTRACTION            one_hot [get_runs $synth_name]
launch_runs $synth_name
wait_on_run $synth_name

# save EDIF netlist
open_run $synth_name
write_edif -force ulpsoc.edf
write_verilog -mode synth_stub -force ulpsoc_stub.v
