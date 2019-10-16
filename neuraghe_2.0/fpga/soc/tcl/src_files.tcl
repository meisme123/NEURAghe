if ![info exists PULP_HSA_SIM] {
    set RTL ../../fe/rtl
    set IPS ../../fe/ips
    set FPGA_IPS ../ips
    set FPGA_RTL ../rtl
    set FPGA_ULPCLUSTER ../ulpcluster
}


# interfaces
set SRC_INTERFACES " \
    $RTL/components/pulp_interfaces.sv \
"

# axi_slice
set SRC_AXI_SLICE " \
    $IPS/axi/axi_slice/axi_ar_buffer.sv \
    $IPS/axi/axi_slice/axi_aw_buffer.sv \
    $IPS/axi/axi_slice/axi_b_buffer.sv \
    $IPS/axi/axi_slice/axi_buffer.sv \
    $IPS/axi/axi_slice/axi_r_buffer.sv \
    $IPS/axi/axi_slice/axi_slice.sv \
    $IPS/axi/axi_slice/axi_w_buffer.sv \
"

# axi_slice_dc
set SRC_AXI_SLICE_DC " \
    $IPS/axi/axi_slice_dc/axi_slice_dc_master.sv \
    $IPS/axi/axi_slice_dc/axi_slice_dc_slave.sv \
    $IPS/axi/axi_slice_dc/dc_data_buffer.v \
    $IPS/axi/axi_slice_dc/dc_full_detector.v \
    $IPS/axi/axi_slice_dc/dc_synchronizer.v \
    $IPS/axi/axi_slice_dc/dc_token_ring_fifo_din.v \
    $IPS/axi/axi_slice_dc/dc_token_ring_fifo_dout.v \
    $IPS/axi/axi_slice_dc/dc_token_ring.v \
"

# axi_node
set SRC_AXI_NODE "\
   $IPS/axi/axi_node/axi_address_decoder_AR.sv \
   $IPS/axi/axi_node/axi_address_decoder_AW.sv \
   $IPS/axi/axi_node/axi_address_decoder_BR.sv \
   $IPS/axi/axi_node/axi_address_decoder_BW.sv \
   $IPS/axi/axi_node/axi_address_decoder_DW.sv \
   $IPS/axi/axi_node/axi_AR_allocator.sv \
   $IPS/axi/axi_node/axi_ArbitrationTree.sv \
   $IPS/axi/axi_node/axi_AW_allocator.sv \
   $IPS/axi/axi_node/axi_BR_allocator.sv \
   $IPS/axi/axi_node/axi_BW_allocator.sv \
   $IPS/axi/axi_node/axi_DW_allocator.sv \
   $IPS/axi/axi_node/axi_FanInPrimitive_Req.sv \
   $IPS/axi/axi_node/axi_multiplexer.sv \
   $IPS/axi/axi_node/axi_node.sv \
   $IPS/axi/axi_node/axi_node_wrap.sv \
   $IPS/axi/axi_node/axi_node_wrap_with_slices.sv \
   $IPS/axi/axi_node/apb_regs_top.sv \
   $IPS/axi/axi_node/axi_regs_top.sv \
   $IPS/axi/axi_node/axi_request_block.sv \
   $IPS/axi/axi_node/axi_response_block.sv \
   $IPS/axi/axi_node/axi_RR_Flag_Req.sv \
   $IPS/axi/axi_node/defines.v \
"

# axi_rab
set SRC_AXI_RAB " \
    $IPS/axi/axi_rab/axi4_arch_buffer.v \
    $IPS/axi/axi_rab/axi4_arch_sender.v \
    $IPS/axi/axi_rab/axi4_awch_buffer.v \
    $IPS/axi/axi_rab/axi4_awch_sender.v \
    $IPS/axi/axi_rab/axi4_dwch_buffer.v \
    $IPS/axi/axi_rab/axi4_dwch_sender.v \
    $IPS/axi/axi_rab/axi4_rrch_buffer.v \
    $IPS/axi/axi_rab/axi4_rrch_sender.v \
    $IPS/axi/axi_rab/axi4_rwch_buffer.v \
    $IPS/axi/axi_rab/axi4_rwch_sender.v \
    $IPS/axi/axi_rab/axi_buffer_rab.v \
    $IPS/axi/axi_rab/axi_rab_top.sv \
    $IPS/axi/axi_rab/axi_regs_top_rab.sv \
    $IPS/axi/axi_rab/fsm.sv \
    $IPS/axi/axi_rab/rab_core.sv \
    $IPS/axi/axi_rab/rab_slice.sv \
    $IPS/axi/axi_rab/slice_top.sv \
"

# axi_mailbox
set SRC_AXI_MAILBOX "$FPGA_RTL/xilinx_mailbox_wrap.sv"

# pulpclock_inverter
set SRC_LEVEL_SHIFTER " \
    $IPS/common_cells/pulp_level_shifter_out.sv \
    $IPS/common_cells/pulp_level_shifter_out_clamp.sv \
    $IPS/common_cells/pulp_level_shifter_in.sv \
    $IPS/common_cells/pulp_level_shifter_in_clamp.sv \
"

# pulpclock_inverter
set SRC_CLK_INVERTER " \
    $IPS/common_cells/pulp_clock_inverter.sv \
"

# clock_mux2
set SRC_CLK_MUX2 "\
    $IPS/common_cells/pulp_clock_mux2.sv \
"

# axi_cvp_if
set SRC_AXI_CVP_IF " \
    $IPS/axi/axi_cvp_if/axi_cvp_if.sv \
"

# axi_id_remap
set SRC_AXI_ID_REMAP " \
    $IPS/axi/axi_id_remap/ID_Gen_4.sv \
    $IPS/axi/axi_id_remap/ID_Gen_16.sv \
    $IPS/axi/axi_id_remap/ID_Gen_64.sv \
    $IPS/axi/axi_id_remap/axi_id_remap.sv \
"

# axi_mem_if
set SRC_AXI_MEM_IF " \
    $IPS/axi/axi_mem_if/axi_mem_if.sv \
"

# axi_mem_if_DP
set SRC_AXI_MEM_IF_DP " \
    $IPS/axi/axi_mem_if_DP/axi_mem_if_DP.sv \
    $IPS/axi/axi_mem_if_DP/axi_read_only_ctrl.sv \
    $IPS/axi/axi_mem_if_DP/axi_write_only_ctrl.sv \
"

# axi_spi_master
set SRC_AXI_SPI_MASTER " \
    $IPS/axi/axi_spi_master/axi_spi_master.sv \
    $IPS/axi/axi_spi_master/spi_master_axi_if.sv \
    $IPS/axi/axi_spi_master/spi_master_clkgen.sv \
    $IPS/axi/axi_spi_master/spi_master_controller.sv \
    $IPS/axi/axi_spi_master/spi_master_fifo.sv \
    $IPS/axi/axi_spi_master/spi_master_rx.sv \
    $IPS/axi/axi_spi_master/spi_master_tx.sv \
"

# axi_spi_slave
set SRC_AXI_SPI_SLAVE " \
    $IPS/axi/axi_spi_slave/axi_spi_slave.sv \
    $IPS/axi/axi_spi_slave/spi_slave_axi_plug.sv \
    $IPS/axi/axi_spi_slave/spi_slave_cmd_parser.sv \
    $IPS/axi/axi_spi_slave/spi_slave_controller.sv \
    $IPS/axi/axi_spi_slave/spi_slave_dc_fifo.sv \
    $IPS/axi/axi_spi_slave/spi_slave_regs.sv \
    $IPS/axi/axi_spi_slave/spi_slave_rx.sv \
    $IPS/axi/axi_spi_slave/spi_slave_syncro.sv \
    $IPS/axi/axi_spi_slave/spi_slave_tx.sv \
"

set SRC_ADV_DEBUG_IF "\
   $IPS/adv_dbg_if/rtl/adbg_axi_biu.sv \
   $IPS/adv_dbg_if/rtl/adbg_axi_defines.v \
   $IPS/adv_dbg_if/rtl/adbg_axi_module.sv \
   $IPS/adv_dbg_if/rtl/adbg_axionly_top.sv \
   $IPS/adv_dbg_if/rtl/adbg_crc32.v \
   $IPS/adv_dbg_if/rtl/adbg_defines.v \
   $IPS/adv_dbg_if/rtl/adbg_or1k_biu.sv \
   $IPS/adv_dbg_if/rtl/adbg_or1k_defines.v \
   $IPS/adv_dbg_if/rtl/adbg_or1k_module.sv \
   $IPS/adv_dbg_if/rtl/adbg_or1k_status_reg.sv \
   $IPS/adv_dbg_if/rtl/adbg_tap_defines.v \
   $IPS/adv_dbg_if/rtl/adbg_tap_top.v \
   $IPS/adv_dbg_if/rtl/adbg_top.sv \
   $IPS/adv_dbg_if/rtl/adv_dbg_if.sv \
   $IPS/adv_dbg_if/rtl/bytefifo.v \
   $IPS/adv_dbg_if/rtl/syncflop.v \
   $IPS/adv_dbg_if/rtl/syncreg.v \
"

# axi_gpreg
set SRC_AXI_GPREG " \
    $IPS/axi/axi_gpreg/uart.sv \
    $IPS/axi/axi_gpreg/uart_tx.sv \
    $IPS/axi/axi_gpreg/uart_fifo.sv \
    $IPS/axi/axi_gpreg/axi_gpreg.sv \
"

# jtag
set SRC_JTAG " \
    $IPS/jtag_pulp/src/bscell.sv \
    $IPS/jtag_pulp/src/jtag_axi_wrap.sv \
    $IPS/jtag_pulp/src/jtag_enable.sv \
    $IPS/jtag_pulp/src/jtag_enable_synch.sv \
    $IPS/jtag_pulp/src/jtagreg.sv \
    $IPS/jtag_pulp/src/jtag_rst_synch.sv \
    $IPS/jtag_pulp/src/jtag_sync.sv \
    $IPS/jtag_pulp/src/tap_top.v \
"

# axi2apb
set SRC_AXI2APB " \
    $IPS/axi/axi2apb/axi2apb_cmd.sv \
    $IPS/axi/axi2apb/axi2apb_ctrl.sv \
    $IPS/axi/axi2apb/axi2apb_mux.sv \
    $IPS/axi/axi2apb/axi2apb_rd.sv \
    $IPS/axi/axi2apb/axi2apb.sv \
    $IPS/axi/axi2apb/AXI_2_APB.sv \
    $IPS/axi/axi2apb/axi2apb_wr.sv \
    $IPS/axi/axi2apb/prgen_fifo.sv \
"

# apb fll if
set SRC_APB_FLL_IF " \
    $IPS/apb_internals/apb_fll_if/apb_fll_if.sv \
"

# apb audio
set SRC_APB_AUDIO " \
    $IPS/apb_peripherals/apb_audio/apb_audio.sv \
    $IPS/apb_peripherals/apb_audio/i2s_rx.sv \
    $IPS/apb_peripherals/apb_audio/io_clk_gen.sv \
    $IPS/apb_peripherals/apb_audio/io_event_counter.sv \
    $IPS/apb_peripherals/apb_audio/io_generic_fifo.sv \
    $IPS/apb_peripherals/apb_audio/io_shiftreg.sv \
"

# apb soc ctrl
set SRC_APB_SOC_CTRL " \
    $RTL/components/counter.sv \
    $RTL/components/apb_soc_ctrl.sv \
    $IPS/common_cells/edge_propagator_tx.sv \
"

# apb clkdiv
set SRC_APB_CLKDIV " \
    $IPS/apb_internals/apb_clkdiv/apb_clkdiv.sv \
"

# apb clock_ctrl
set SRC_APB_CLOCK_CTRL " \
    $IPS/apb_internals/apb_clock_ctrl/apb_clock_ctrl.sv \
"

# apb cvp_if
set SRC_APB_CVP_IF " \
    $IPS/apb_internals/apb_cvp_if/apb_cvp_if.sv \
"

# apb gpio
set SRC_APB_GPIO " \
    $IPS/apb_peripherals/apb_gpio/apb_gpio.sv \
"

# apb i2c
set SRC_APB_I2C " \
    $IPS/apb_peripherals/apb_i2c/apb_i2c.sv \
    $IPS/apb_peripherals/apb_i2c/i2c_master_bit_ctrl.sv \
    $IPS/apb_peripherals/apb_i2c/i2c_master_byte_ctrl.sv \
    $IPS/apb_peripherals/apb_i2c/i2c_master_defines.sv \
"

# apb spi master
set SRC_APB_SPI_MASTER " \
    $IPS/apb_peripherals/apb_spi_master/apb_spi_master.sv \
    $IPS/apb_peripherals/apb_spi_master/spi_master_apb_if.sv \
    $IPS/apb_peripherals/apb_spi_master/spi_master_clkgen.sv \
    $IPS/apb_peripherals/apb_spi_master/spi_master_controller.sv \
    $IPS/apb_peripherals/apb_spi_master/spi_master_fifo.sv \
    $IPS/apb_peripherals/apb_spi_master/spi_master_rx.sv \
    $IPS/apb_peripherals/apb_spi_master/spi_master_tx.sv \
"

# apb uart
set SRC_APB_UART " \
    $IPS/apb_peripherals/apb_uart/apb_uart.vhd \
    $IPS/apb_peripherals/apb_uart/slib_clock_div.vhd \
    $IPS/apb_peripherals/apb_uart/slib_counter.vhd \
    $IPS/apb_peripherals/apb_uart/slib_edge_detect.vhd \
    $IPS/apb_peripherals/apb_uart/slib_fifo.vhd \
    $IPS/apb_peripherals/apb_uart/slib_input_filter.vhd \
    $IPS/apb_peripherals/apb_uart/slib_input_sync.vhd \
    $IPS/apb_peripherals/apb_uart/slib_mv_filter.vhd \
    $IPS/apb_peripherals/apb_uart/uart_baudgen.vhd \
    $IPS/apb_peripherals/apb_uart/uart_interrupt.vhd \
    $IPS/apb_peripherals/apb_uart/uart_receiver.vhd \
    $IPS/apb_peripherals/apb_uart/uart_transmitter.vhd \
"

# add (dummy) cvp
set SRC_DUMMY_CVP $FPGA_RTL/cvp_dummy.sv

# add rstgen
set SRC_RSTGEN $IPS/common_cells/rstgen.sv

# add power module 
set POWER_MODULE " \
    $RTL/components/power_manager.sv \
    $IPS/common_cells/pulp_sync_wedge.sv \
"

# add ulpsoc
set SRC_ULPSOC " \
    $FPGA_RTL/cluster_clock_gating.sv \
    $IPS/common_cells/generic_fifo.sv \
    $RTL/ulpcluster/axi_slice_dc_master_wrap.sv \
    $RTL/ulpcluster/axi_slice_dc_slave_wrap.sv \
    $RTL/ulpcluster/axi_slice_wrap.sv \
    $RTL/ulpsoc/ulpcluster_ls_wrap.sv \
    $RTL/ulpsoc/ulpcluster_axi_master_LSIN_wrap.sv \
    $RTL/ulpsoc/ulpcluster_axi_slave_LSIN_wrap.sv \
    $RTL/ulpsoc/ulpsoc_axi_master_LSIN_wrap.sv \
    $RTL/ulpsoc/ulpsoc_axi_slave_LSIN_wrap.sv \
    $RTL/ulpsoc/axi_LS_wrap.sv \
    $RTL/ulpsoc/axi_id_remap_wrap.sv \
    $RTL/ulpsoc/axi_jtag_wrap.sv \
    $RTL/ulpsoc/axi_mem_if_wrap.sv \
    $RTL/ulpsoc/axi_mem_if_DP_wrap.sv \
    $RTL/ulpsoc/axi_spi_slave_wrap.sv \
    $RTL/ulpsoc/axi_dbg_wrap.sv \
    $RTL/ulpsoc/axi2apb_wrap.sv \
    $RTL/ulpsoc/l2_ram.sv \
    $RTL/ulpsoc/l2_ram_dp.sv \
    $RTL/ulpsoc/mem_interface_wrap.sv \
    $RTL/ulpsoc/level_shifter_wrap_soc.sv \
    $RTL/ulpsoc/level_shifter_wrap.sv \
    $RTL/ulpsoc/pulp_chip_LS_wrap.sv\
    $RTL/ulpsoc/boot_rom.sv \
    $RTL/ulpsoc/axi_rab_wrap.sv \
    $RTL/ulpsoc/soc_bus_wrap.sv \
    $RTL/ulpsoc/soc_peripherals.sv \
    $RTL/ulpsoc/jtag_tap_top.sv \
    $RTL/ulpsoc/ulpsoc.sv \
"

# xbar_tcdm
set SRC_XBAR_TCDM " \
   $IPS/cluster_interconnect/rtl/low_latency_interco/AddressDecoder_Req.sv \
   $IPS/cluster_interconnect/rtl/low_latency_interco/AddressDecoder_Resp.sv \
   $IPS/cluster_interconnect/rtl/low_latency_interco/ArbitrationTree.sv \
   $IPS/cluster_interconnect/rtl/low_latency_interco/FanInPrimitive_Req.sv \
   $IPS/cluster_interconnect/rtl/low_latency_interco/FanInPrimitive_Resp.sv \
   $IPS/cluster_interconnect/rtl/low_latency_interco/MUX2_REQ.sv \
   $IPS/cluster_interconnect/rtl/low_latency_interco/parameters.v \
   $IPS/cluster_interconnect/rtl/low_latency_interco/RequestBlock1CH.sv \
   $IPS/cluster_interconnect/rtl/low_latency_interco/RequestBlock2CH.sv \
   $IPS/cluster_interconnect/rtl/low_latency_interco/ResponseBlock.sv \
   $IPS/cluster_interconnect/rtl/low_latency_interco/ResponseTree.sv \
   $IPS/cluster_interconnect/rtl/low_latency_interco/RR_Flag_Req.sv \
   $IPS/cluster_interconnect/rtl/low_latency_interco/TestAndSet.sv \
   $IPS/cluster_interconnect/rtl/low_latency_interco/XBAR_TCDM.sv \
   $IPS/cluster_interconnect/rtl/low_latency_interco/TCDM_PIPE_REQ.sv \
   $IPS/cluster_interconnect/rtl/low_latency_interco/TCDM_PIPE_RESP.sv \
   $IPS/cluster_interconnect/rtl/low_latency_interco/grant_mask.sv \
   $IPS/cluster_interconnect/rtl/low_latency_interco/XBAR_TCDM_WRAPPER.sv \
"

# xbar_per
set SRC_XBAR_PER " \
   $IPS/cluster_interconnect/rtl/peripheral_interco/AddressDecoder_PE_Req.sv \
   $IPS/cluster_interconnect/rtl/peripheral_interco/AddressDecoder_Resp_PE.sv \
   $IPS/cluster_interconnect/rtl/peripheral_interco/ArbitrationTree_PE.sv \
   $IPS/cluster_interconnect/rtl/peripheral_interco/FanInPrimitive_PE_Resp.sv \
   $IPS/cluster_interconnect/rtl/peripheral_interco/FanInPrimitive_Req_PE.sv \
   $IPS/cluster_interconnect/rtl/peripheral_interco/MUX2_REQ_PE.sv \
   $IPS/cluster_interconnect/rtl/peripheral_interco/RequestBlock1CH_PE.sv \
   $IPS/cluster_interconnect/rtl/peripheral_interco/RequestBlock2CH_PE.sv \
   $IPS/cluster_interconnect/rtl/peripheral_interco/ResponseBlock_PE.sv \
   $IPS/cluster_interconnect/rtl/peripheral_interco/ResponseTree_PE.sv \
   $IPS/cluster_interconnect/rtl/peripheral_interco/RR_Flag_Req_PE.sv \
   $IPS/cluster_interconnect/rtl/peripheral_interco/XBAR_PE.sv \
"

# axi2mem
set SRC_AXI2MEM "\
   $IPS/axi/axi2mem/axi2mem_ar_buffer.sv \
   $IPS/axi/axi2mem/axi2mem_aw_buffer.sv \
   $IPS/axi/axi2mem/axi2mem_b_buffer.sv \
   $IPS/axi/axi2mem/axi2mem_buffer.sv \
   $IPS/axi/axi2mem/axi2mem_busy_unit.sv \
   $IPS/axi/axi2mem/axi2mem_parameters.sv \
   $IPS/axi/axi2mem/axi2mem_r_buffer.sv \
   $IPS/axi/axi2mem/axi2mem_rd_channel.sv \
   $IPS/axi/axi2mem/axi2mem.sv \
   $IPS/axi/axi2mem/axi2mem_tcdm_rd_if.sv \
   $IPS/axi/axi2mem/axi2mem_tcdm_synch.sv \
   $IPS/axi/axi2mem/axi2mem_tcdm_unit.sv \
   $IPS/axi/axi2mem/axi2mem_tcdm_wr_if.sv \
   $IPS/axi/axi2mem/axi2mem_trans_unit.sv \
   $IPS/axi/axi2mem/axi2mem_w_buffer.sv \
   $IPS/axi/axi2mem/axi2mem_wr_channel.sv \
"

# axi2per
set SRC_AXI2PER "\
   $IPS/axi/axi2per/axi2per_ar_buffer.sv \
   $IPS/axi/axi2per/axi2per_aw_buffer.sv \
   $IPS/axi/axi2per/axi2per_b_buffer.sv \
   $IPS/axi/axi2per/axi2per_buffer.sv \
   $IPS/axi/axi2per/axi2per_parameters.sv \
   $IPS/axi/axi2per/axi2per_r_buffer.sv \
   $IPS/axi/axi2per/axi2per_req_channel.sv \
   $IPS/axi/axi2per/axi2per_res_channel.sv \
   $IPS/axi/axi2per/axi2per.sv \
   $IPS/axi/axi2per/axi2per_w_buffer.sv \
"

# per2axi
set SRC_PER2AXI "\
   $IPS/axi/per2axi/per2axi_ar_buffer.sv \
   $IPS/axi/per2axi/per2axi_aw_buffer.sv \
   $IPS/axi/per2axi/per2axi_b_buffer.sv \
   $IPS/axi/per2axi/per2axi_buffer.sv \
   $IPS/axi/per2axi/per2axi_busy_unit.sv \
   $IPS/axi/per2axi/per2axi_parameters.sv \
   $IPS/axi/per2axi/per2axi_r_buffer.sv \
   $IPS/axi/per2axi/per2axi_req_channel.sv \
   $IPS/axi/per2axi/per2axi_res_channel.sv \
   $IPS/axi/per2axi/per2axi.sv \
   $IPS/axi/per2axi/per2axi_w_buffer.sv \
"

# wb2axi
set SRC_WB2AXI "\
   $IPS/axi/wb2axi/wb2axi_ar_buffer.sv \
   $IPS/axi/wb2axi/wb2axi_aw_buffer.sv \
   $IPS/axi/wb2axi/wb2axi_b_buffer.sv \
   $IPS/axi/wb2axi/wb2axi_buffer.sv \
   $IPS/axi/wb2axi/wb2axi_parameters.sv \
   $IPS/axi/wb2axi/wb2axi_r_buffer.sv \
   $IPS/axi/wb2axi/wb2axi_req_channel.sv \
   $IPS/axi/wb2axi/wb2axi_res_channel.sv \
   $IPS/axi/wb2axi/wb2axi.sv \
   $IPS/axi/wb2axi/wb2axi_w_buffer.sv \
"

# axi_slice
set SRC_AXI_SLICE "\
   $IPS/axi/axi_slice/axi_ar_buffer.sv \
   $IPS/axi/axi_slice/axi_aw_buffer.sv \
   $IPS/axi/axi_slice/axi_b_buffer.sv \
   $IPS/axi/axi_slice/axi_buffer.sv \
   $IPS/axi/axi_slice/axi_r_buffer.sv \
   $IPS/axi/axi_slice/axi_slice.sv \
   $IPS/axi/axi_slice/axi_w_buffer.sv \
"

set SRC_ADV_DEBUG_IF "\
   $IPS/adv_dbg_if/rtl/adbg_axi_biu.sv \
   $IPS/adv_dbg_if/rtl/adbg_axi_defines.v \
   $IPS/adv_dbg_if/rtl/adbg_axi_module.sv \
   $IPS/adv_dbg_if/rtl/adbg_crc32.v \
   $IPS/adv_dbg_if/rtl/adbg_defines.v \
   $IPS/adv_dbg_if/rtl/adbg_or1k_biu.sv \
   $IPS/adv_dbg_if/rtl/adbg_or1k_defines.v \
   $IPS/adv_dbg_if/rtl/adbg_or1k_module.sv \
   $IPS/adv_dbg_if/rtl/adbg_or1k_status_reg.sv \
   $IPS/adv_dbg_if/rtl/adbg_tap_defines.v \
   $IPS/adv_dbg_if/rtl/adbg_tap_top.v \
   $IPS/adv_dbg_if/rtl/adbg_top.sv \
   $IPS/adv_dbg_if/rtl/adv_dbg_if.sv \
   $IPS/adv_dbg_if/rtl/bytefifo.v \
   $IPS/adv_dbg_if/rtl/syncflop.v \
   $IPS/adv_dbg_if/rtl/syncreg.v \
"

# axi_slice_dc
set SRC_AXI_SLICE_DC "\
   $IPS/axi/axi_slice_dc/axi_slice_dc_master.sv \
   $IPS/axi/axi_slice_dc/axi_slice_dc_slave.sv \
   $IPS/axi/axi_slice_dc/dc_data_buffer.v \
   $IPS/axi/axi_slice_dc/dc_full_detector.v \
   $IPS/axi/axi_slice_dc/dc_synchronizer.v \
   $IPS/axi/axi_slice_dc/dc_token_ring_fifo_din.v \
   $IPS/axi/axi_slice_dc/dc_token_ring_fifo_dout.v \
   $IPS/axi/axi_slice_dc/dc_token_ring.v \
"

# axi_node
set SRC_AXI_NODE "\
   $IPS/axi/axi_node/axi_address_decoder_AR.sv \
   $IPS/axi/axi_node/axi_address_decoder_AW.sv \
   $IPS/axi/axi_node/axi_address_decoder_BR.sv \
   $IPS/axi/axi_node/axi_address_decoder_BW.sv \
   $IPS/axi/axi_node/axi_address_decoder_DW.sv \
   $IPS/axi/axi_node/axi_AR_allocator.sv \
   $IPS/axi/axi_node/axi_ArbitrationTree.sv \
   $IPS/axi/axi_node/axi_AW_allocator.sv \
   $IPS/axi/axi_node/axi_BR_allocator.sv \
   $IPS/axi/axi_node/axi_BW_allocator.sv \
   $IPS/axi/axi_node/axi_DW_allocator.sv \
   $IPS/axi/axi_node/axi_FanInPrimitive_Req.sv \
   $IPS/axi/axi_node/axi_multiplexer.sv \
   $IPS/axi/axi_node/axi_node.sv \
   $IPS/axi/axi_node/axi_node_wrap.sv \
   $IPS/axi/axi_node/axi_node_wrap_with_slices.sv \
   $IPS/axi/axi_node/apb_regs_top.sv \
   $IPS/axi/axi_node/axi_regs_top.sv \
   $IPS/axi/axi_node/axi_request_block.sv \
   $IPS/axi/axi_node/axi_response_block.sv \
   $IPS/axi/axi_node/axi_RR_Flag_Req.sv \
   $IPS/axi/axi_node/defines.v \
"

# icache control unit
set SRC_ICACHE_CTRL_UNIT " \
   $IPS/cluster_peripherals/icache_ctrl_unit/icache_ctrl_unit.sv \
"

# cluster control unit
set SRC_CLUSTER_CONTROL_UNIT " \
   $IPS/cluster_peripherals/cluster_control_unit/cluster_control_unit.sv \
"

# event unit
set SRC_EVENT_UNIT " \
   $IPS/cluster_peripherals/event_unit/HW_barrier.sv \
   $IPS/cluster_peripherals/event_unit/HW_barrier_logic.sv \
   $IPS/cluster_peripherals/event_unit/interrupt_mask.sv \
   $IPS/cluster_peripherals/event_unit/event_unit_arbiter.sv \
   $IPS/cluster_peripherals/event_unit/event_unit_input.sv \
   $IPS/cluster_peripherals/event_unit/event_unit_mux.sv \
   $IPS/cluster_peripherals/event_unit/event_unit_sm.sv \
   $IPS/cluster_peripherals/event_unit/event_unit.sv \
"

# performance counters
set SRC_PERFCOUNTERS " \
   $IPS/cluster_peripherals/perf_counters_unit/perf_counters_unit.sv \
"

# MMU config unit
set SRC_MMU_CONFIG_UNIT " \
   $IPS/cluster_peripherals/mmu_config_unit/mmu_config_unit.sv \
"

# TCDM pipe unit
set SRC_TCDM_PIPE_UNIT " \
   $IPS/cluster_peripherals/tcdm_pipe_unit/tcdm_pipe_unit.sv \
"

# timer unit
set SRC_TIMER_UNIT " \
   $IPS/cluster_peripherals/timer_unit/timer_unit.sv \
"

# generic register file
set SRC_REGFILE " \
   $FPGA_RTL/or10n_register_file.sv \
   $FPGA_RTL/riscv_register_file.sv \
   $FPGA_RTL/register_file_3r_2w.sv \
   $FPGA_RTL/register_file_1r_1w.sv \
   $FPGA_RTL/register_file_1r_1w_all.sv \
   $FPGA_RTL/register_file_2r_1w_asymm.sv \
"



# or10n
if { $core == "OR10N" } {
   set SRC_OR10N "\
      $IPS/or10n/alu.sv \
      $IPS/or10n/controller.sv \
      $IPS/or10n/debug_unit.sv \
      $IPS/or10n/ex_stage.sv \
      $IPS/or10n/exc_controller.sv \
      $IPS/or10n/hwloop_controller.sv \
      $IPS/or10n/hwloop_regs.sv \
      $IPS/or10n/id_stage.sv \
      $IPS/or10n/if_stage.sv \
      $IPS/or10n/instr_core_interface.sv \
      $IPS/or10n/load_store_unit.sv \
      $IPS/or10n/mult.sv \
      $IPS/or10n/or10n_core.sv \
      $IPS/or10n/sp_registers.sv \
      $IPS/or10n/wb_stage.sv \
   "
}

# ri5cy
if { $core == "RI5CY" } {
   set SRC_RI5CY "\
      $IPS/riscv/alu.sv \
      $IPS/riscv/compressed_decoder.sv \
      $IPS/riscv/controller.sv \
      $IPS/riscv/cs_registers.sv \
      $IPS/riscv/debug_unit.sv \
      $IPS/riscv/exc_controller.sv \
      $IPS/riscv/ex_stage.sv \
      $IPS/riscv/hwloop_controller.sv \
      $IPS/riscv/hwloop_regs.sv \
      $IPS/riscv/id_stage.sv \
      $IPS/riscv/if_stage.sv \
      $IPS/riscv/instr_core_interface.sv \
      $IPS/riscv/load_store_unit.sv \
      $IPS/riscv/mult.sv \
      $IPS/riscv/riscv_core.sv \
   "
}

# memory cuts
set SRC_MEM_CUTS "\
   $FPGA_IPS/xilinx_icache_bank_data_16x128/ip/xilinx_icache_bank_data_16x128_stub.v \
   $FPGA_IPS/xilinx_icache_bank_tag_16x8/ip/xilinx_icache_bank_tag_16x8_stub.v \
   $FPGA_IPS/xilinx_l2_mem_32768x64_dp/ip/xilinx_l2_mem_32768x64_dp_stub.v \
   $FPGA_IPS/xilinx_rom_bank_1024x64/ip/xilinx_rom_bank_1024x64_stub.v \
"

# mchan
set SRC_MCHAN "\
   $IPS/mchan/ctrl_unit/ctrl_if.sv \
   $IPS/mchan/ctrl_unit/ctrl_fsm.sv \
   $IPS/mchan/ctrl_unit/cmd_counter.sv \
   $IPS/mchan/ctrl_unit/ctrl_unit.sv \
   $IPS/mchan/ctrl_unit/synch_unit.sv \
   $IPS/mchan/ctrl_unit/trans_allocator.sv \
   $IPS/mchan/ctrl_unit/trans_arbiter_wrap.sv \
   $IPS/mchan/ctrl_unit/trans_queue.sv \
   $IPS/mchan/ctrl_unit/trans_unpack.sv \
   $IPS/mchan/ctrl_unit/twd_trans_queue.sv \
   $IPS/mchan/ctrl_unit/twd_trans_splitter.sv \
   $IPS/mchan/ext_unit/ext_ar_buffer.sv \
   $IPS/mchan/ext_unit/ext_aw_buffer.sv \
   $IPS/mchan/ext_unit/ext_b_buffer.sv \
   $IPS/mchan/ext_unit/ext_buffer.sv \
   $IPS/mchan/ext_unit/ext_opc_buf.sv \
   $IPS/mchan/ext_unit/ext_r_buffer.sv \
   $IPS/mchan/ext_unit/ext_rx_if.sv \
   $IPS/mchan/ext_unit/ext_tid_gen.sv \
   $IPS/mchan/ext_unit/ext_tx_if.sv \
   $IPS/mchan/ext_unit/ext_unit.sv \
   $IPS/mchan/ext_unit/ext_w_buffer.sv \
   $IPS/mchan/misc/mchan_arbiter.sv \
   $IPS/mchan/misc/mchan_arb_primitive.sv \
   $IPS/mchan/misc/mchan_rr_flag_req.sv \
   $IPS/mchan/tcdm_unit/tcdm_cmd_unpack.sv \
   $IPS/mchan/tcdm_unit/tcdm_rx_if.sv \
   $IPS/mchan/tcdm_unit/tcdm_synch.sv \
   $IPS/mchan/tcdm_unit/tcdm_tx_if.sv \
   $IPS/mchan/tcdm_unit/tcdm_unit.sv \
   $IPS/mchan/trans_unit/trans_unit.sv \
   $IPS/mchan/trans_unit/trans_buffers.sv \
   $IPS/mchan/trans_unit/trans_aligner.sv \
   $IPS/mchan/top/mchan.sv \
"

# common cells
set SRC_COMMONCELLS " \
   $IPS/common_cells/generic_fifo.sv \
   $IPS/common_cells/cluster_clock_buffer.sv \
   $FPGA_RTL/cluster_clock_gating.sv \
   $IPS/common_cells/cluster_clock_inverter.sv \
   $IPS/common_cells/cluster_clock_mux2.sv \
   $IPS/common_cells/cluster_clock_xor2.sv \
   $IPS/common_cells/cluster_level_shifter_in.sv \
   $IPS/common_cells/cluster_level_shifter_out.sv \
   $IPS/common_cells/rstgen.sv \
   $IPS/common_cells/edge_propagator_rx.sv \
   $IPS/common_cells/pulp_sync_wedge.sv \
"

# hwce
set SRC_HWCE " \
   $IPS/hwpe/hwce/rtl/hwce_engine_fsm.sv \
   $IPS/hwpe/hwce/rtl/hwce_engine.sv \
   $IPS/hwpe/hwce/rtl/hwce_sop.sv \
   $IPS/hwpe/hwce/rtl/hwce_sop_add.sv \
   $IPS/hwpe/hwce/rtl/one_dsp_MACC.sv \
   $IPS/hwpe/hwce/rtl/hwce_shift_adder.sv \
   $IPS/hwpe/hwce/rtl/hwce_wrapper_fsm.sv \
$IPS/hwpe/hwce/rtl/pooling_data_shift_register.sv \
$IPS/hwpe/hwce/rtl/pooling_layer.sv \
$IPS/hwpe/hwce/rtl/pipe_pooling.sv \
   $IPS/hwpe/hwce/rtl/hwce_wrapper_slave.sv \
   $IPS/hwpe/hwce/rtl/hwce_linebuffer.sv \
   $IPS/hwpe/hwce/rtl/hwce_top.sv \
   $IPS/hwpe/hwce/rtl/hwce_types.sv \
   $IPS/hwpe/hwce/rtl/hwce_wrapper.sv \
   $IPS/hwpe/hwce/rtl/hwce_weight_loader.sv \
   $IPS/hwpe/hwce/rtl/weights_mem_dp_wrap.sv \
   $IPS/hwpe/hwce/rtl/xbar_req_gen.sv \
   $IPS/hwpe/hwce/rtl/hwce_wmem_xbar.sv \
   $IPS/hwpe/hwpe-sm/rtl/hwpe_sm_address.sv \
   $IPS/hwpe/hwpe-sm/rtl/hwpe_sm_controller.sv \
   $IPS/hwpe/hwpe-sm/rtl/hwpe_sm_decoder.sv \
   $IPS/hwpe/hwpe-sm/rtl/hwpe_sm_encoder.sv \
   $IPS/hwpe/hwpe-sm/rtl/hwpe_sm_params.sv \
   $IPS/hwpe/hwpe-sm/rtl/hwpe_sm_regfile.sv \
   $IPS/hwpe/hwpe-sm/rtl/hwpe_sm_slave.sv \
   $IPS/hwpe/hwpe-sm/rtl/axi/hwpe_axi_addressgen.sv \
   $IPS/hwpe/hwpe-sm/rtl/axi/hwpe_axi_addressgen_sink.sv \
   $IPS/hwpe/hwpe-sm/rtl/axi/hwpe_axi_addressgen_sink_FS.sv \
   $IPS/hwpe/hwpe-sm/rtl/axi/hwpe_axi_addressgen_source.sv \
   $IPS/hwpe/hwpe-sm/rtl/axi/hwpe_axi_fifo_earlystall.sv \
   $IPS/hwpe/hwpe-sm/rtl/axi/hwpe_axi_fifo.sv \
   $IPS/hwpe/hwpe-sm/rtl/axi/hwpe_axi_fifo_2.sv \
   $IPS/hwpe/hwpe-sm/rtl/axi/hwpe_axi_params.sv \
   $IPS/hwpe/hwpe-sm/rtl/axi/hwpe_axi_sink.sv \
   $IPS/hwpe/hwpe-sm/rtl/axi/hwpe_axi_source.sv \
   $IPS/hwpe/hwpe-sm/rtl/axi/hwpe_axi_source_FS.sv \
"

# ulpcluster
set SRC_ULPCLUSTER "\
   $RTL/components/pulp_interfaces.sv \
   $RTL/ulpcluster/adv_debug_if_wrap.sv \
   $RTL/ulpcluster/axi2mem_wrap.sv \
   $RTL/ulpcluster/axi2per_wrap.sv \
   $RTL/ulpcluster/axi_slice_dc_master_wrap.sv \
   $RTL/ulpcluster/axi_slice_dc_slave_wrap.sv \
   $RTL/ulpcluster/axi_slice_wrap.sv \
   $RTL/ulpcluster/mmu_wrap.sv \
   $RTL/ulpcluster/mmu.sv \
   $RTL/ulpcluster/clkgate_bbmux_unit.sv \
   $RTL/ulpcluster/cluster_bus_wrap.sv \
   $RTL/ulpcluster/cluster_bus_wrap.sv \
   $RTL/ulpcluster/cluster_interconnect_wrap.sv \
   $RTL/ulpcluster/xbar_master_sel.sv \
   $RTL/ulpcluster/tcdm_xbar.sv \
   $RTL/ulpcluster/tcdm_hwce_xbar.sv \
   $RTL/ulpcluster/hwce_p2p_tcdm.sv \
   $RTL/ulpcluster/cluster_peripherals.sv \
   $RTL/ulpcluster/core_demux.sv \
   $RTL/ulpcluster/core_region.sv \
   $RTL/ulpcluster/core_data_memory.sv \
   $RTL/ulpcluster/periph_demux.sv \
   $RTL/ulpcluster/periph_FIFO.sv \
   $RTL/ulpcluster/periph_FIFO_wrap.sv \
   $RTL/ulpcluster/dmac_wrap.sv \
   $RTL/ulpcluster/dmac_per_wrap.sv \
   $RTL/ulpcluster/uC_to_prog.sv\
   $RTL/ulpcluster/uC_to_wei.sv\
   $RTL/ulpcluster/wei_to_uC.sv\
   $RTL/ulpcluster/mchan_prog.sv\
   $RTL/ulpcluster/mchan_per_prog.sv\
   $RTL/ulpcluster/hwce_wrap.sv \
   $RTL/ulpcluster/tcdm_g_slave.sv \
   $RTL/ulpcluster/tcdm_g_master.sv \
   $RTL/ulpcluster/hwce_periph_adapt.sv \
   $RTL/ulpcluster/instr_bus_wrap.sv \
   $RTL/ulpcluster/per2axi_wrap.sv \
   $RTL/ulpcluster/tcdm_dp_banks_wrap.sv \
   $RTL/ulpcluster/tcdm_dp_banks_asym.sv \
   $RTL/ulpcluster/axi_boot_addr_tran_wrap.sv \
   $RTL/ulpcluster/axi_boot_addr_tran_wrap.sv \
"

