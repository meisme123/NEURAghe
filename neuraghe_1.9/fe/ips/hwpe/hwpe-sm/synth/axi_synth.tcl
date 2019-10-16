# reset_design

exec mkdir -p reports
exec mkdir -p netlist

exec mkdir -p hwpe_axi_lib
exec mkdir -p axi_accel_lib

exec rm -rf hwpe_axi_lib/*
exec rm -rf axi_accel_lib/*

set search_path "$search_path /opt/techlibs/cmos028/C32_SC_12_CORE_LL_C28@1.1@20111209.1/libs"
set target_library C32_SC_12_CORE_LL_ss28_1.00V_0C.db
set link_library   C32_SC_12_CORE_LL_ss28_1.00V_0C.db
set symbol_library C32_SC_12_CORE_LL.sdb

set N_CORES 4

define_design_lib hwpe_axi_lib  -path hwpe_axi_lib
define_design_lib axi_accel_lib -path axi_accel_lib

# The clock input signal name.
set CLK  "clk"
# The reset input signal name.
set RST  "rst_n"
# The target clock period in library units.
set CLK_PERIOD 2.0; 
# The clock uncertainty in library units.
set CLK_UNCERTAINTY  0.4; 

set PROJ_DIR "../rtl/"
set ACC_DIR  "../testbench/"

analyze -library hwpe_axi_lib  -format sverilog "$PROJ_DIR/axi/hwpe_axi_fifo.sv"
analyze -library hwpe_axi_lib  -format sverilog "$PROJ_DIR/axi/hwpe_axi_fifo_earlystall.sv"
analyze -library hwpe_axi_lib  -format sverilog "$PROJ_DIR/axi/hwpe_axi_addressgen.sv"
analyze -library hwpe_axi_lib  -format sverilog "$PROJ_DIR/axi/hwpe_axi_sink.sv"
analyze -library hwpe_axi_lib  -format sverilog "$PROJ_DIR/axi/hwpe_axi_source.sv"
analyze -library hwpe_axi_lib  -format sverilog "$PROJ_DIR/axi/hwpe_axi_wrapper.sv"
analyze -library hwpe_axi_lib  -format sverilog "$PROJ_DIR/hwpe_sm_decoder.sv"
analyze -library hwpe_axi_lib  -format sverilog "$PROJ_DIR/hwpe_sm_encoder.sv"
analyze -library hwpe_axi_lib  -format sverilog "$PROJ_DIR/hwpe_sm_regfile.sv"
analyze -library hwpe_axi_lib  -format sverilog "$PROJ_DIR/hwpe_sm_slave.sv"
analyze -library hwpe_axi_lib  -format sverilog "$PROJ_DIR/hwpe_sm_wrapper.sv"
analyze -library axi_accel_lib -format sverilog "$ACC_DIR/axi_hw_accel.sv"
analyze -library hwpe_axi_lib  -format sverilog "$PROJ_DIR/axi/hwpe_axi_top.sv"  

# elaborate hwpe_sm_address         -library hwpe_sm_lib
# elaborate hwpe_sm_slave_mc        -library hwpe_sm_lib
# elaborate hwpe_sm_fifo            -library hwpe_sm_lib
# elaborate hwpe_sm_sequencer       -library hwpe_sm_lib
# elaborate hwpe_sm_sequencer_pipe  -library hwpe_sm_lib
# elaborate hwpe_sm_controller_pack -library hwpe_sm_lib
# elaborate hwpe_sm_wrapper         -library hwpe_sm_lib
elaborate hwpe_axi_top -library hwpe_axi_lib
# -parameters "W=16, N_INPUTS=4, N_LINES=4"

# clocks
create_clock $CLK -period $CLK_PERIOD
set_clock_uncertainty $CLK_UNCERTAINTY [all_clocks]
set_dont_touch_network [all_clocks]
# resets
remove_driving_cell $RST
set_drive 0 $RST
set_dont_touch_network $RST

# check in ST network
#set TOL 0.5
#set_input_delay  -clock clk [expr $CLOCK / 2 - $TOL / 2] [get_ports * -filter "@port_direction == in  && (@name =~ tcdm* || @name =~ catc* || @name =~ cfg*)"]
#set_output_delay -clock clk [expr $CLOCK / 2 - $TOL / 2] [get_ports * -filter "@port_direction == out && (@name =~ tcdm* || @name =~ catc* || @name =~ cfg*)"]
#set_output_delay -clock clk [expr $CLOCK - $TOL] [get_ports tcdm_req_o]
#set_input_delay  -clock clk [expr $CLOCK - $TOL] [get_ports tcdm_gnt_i]
#set_output_delay -clock clk [expr $CLOCK / 2 - $TOL / 2] [get_ports event]
#set_multicycle_path 5 -from [get_ports rst_n]

# Delay from interconnects is supposed to be higher than the one from the CatC module
set DELAY_CLUSTER [expr $CLK_PERIOD/2 - 0.3]
#set DELAY_CATC    [expr $CLOCK/2 - 0.4]
set DELAY_REQWAIT [expr $CLK_PERIOD - 0.8]

set_input_delay  -clock clk [expr $DELAY_CLUSTER] [get_ports * -filter "@port_direction == in  && (@name =~ tcdm* || @name =~ cfg*)"]
set_output_delay -clock clk [expr $DELAY_CLUSTER] [get_ports * -filter "@port_direction == out && (@name =~ tcdm* || @name =~ cfg*)"]
set_output_delay -clock clk [expr $DELAY_CLUSTER] [get_ports evt_o]
set_input_delay  -clock clk [expr $DELAY_REQWAIT] [get_ports tcdm_gnt_i]
set_output_delay -clock clk [expr $DELAY_CLUSTER] [get_ports tcdm_req_o]

#set_input_delay  -clock $CLK 0.2 [get_ports "*_i"]
#set_output_delay -clock $CLK 0.2 [get_ports "*_o"]

check_design > reports/check_design.log

set_host_options -max_cores $N_CORES
compile_ultra -no_autoungroup

check_design > reports/check_design.log
report_area -nosplit -hierarchy > reports/area.log
report_timing > reports/timing.log
report_power > reports/power.log

write_file -format verilog -hierarchy -output netlist/hwpe_axi_top.v
write_file -format ddc     -hierarchy -output netlist/hwpe_axi_top.ddc
