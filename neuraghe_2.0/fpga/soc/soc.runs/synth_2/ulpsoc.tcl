# 
# Synthesis run script generated by Vivado
# 

create_project -in_memory -part xc7z045ffg900-2

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/soc/soc.cache/wt [current_project]
set_property parent.project_path /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/soc/soc.xpr [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part xilinx.com:zc706:part0:1.0 [current_project]
set_property ip_output_repo /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/soc/soc.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
set_property include_dirs {
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/or10n/include
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_interconnect/rtl/peripheral_interco
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/includes
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/include
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_peripherals/include
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_peripherals/event_unit/include
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/icache/icache_scm_sp/globals
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwce/rtl
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwpe-sm/rtl
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwpe-sm/rtl/axi
} [current_fileset]
add_files /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/ips/xilinx_rom_bank_1024x64/boot_code.coe
read_verilog {
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_interconnect/rtl/peripheral_interco/parameters.v
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_peripherals/event_unit/include/event_unit_defines.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/or10n/include/defines.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi2per/axi2per_parameters.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/includes/hwce_defines.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/includes/ulpsoc_defines.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/defines.v
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/include/mchan_defines.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwpe-sm/rtl/axi/hwpe_axi_params.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwce/rtl/hwce_types.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwpe-sm/rtl/hwpe_sm_params.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/per2axi/per2axi_parameters.sv
}
set_property file_type "Verilog Header" [get_files /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_interconnect/rtl/peripheral_interco/parameters.v]
set_property file_type "Verilog Header" [get_files /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_peripherals/event_unit/include/event_unit_defines.sv]
set_property file_type "Verilog Header" [get_files /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/or10n/include/defines.sv]
set_property file_type "Verilog Header" [get_files /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi2per/axi2per_parameters.sv]
set_property file_type "Verilog Header" [get_files /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/includes/hwce_defines.sv]
set_property file_type "Verilog Header" [get_files /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/includes/ulpsoc_defines.sv]
set_property file_type "Verilog Header" [get_files /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/defines.v]
set_property file_type "Verilog Header" [get_files /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/include/mchan_defines.sv]
set_property file_type "Verilog Header" [get_files /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwpe-sm/rtl/axi/hwpe_axi_params.sv]
set_property file_type "Verilog Header" [get_files /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwce/rtl/hwce_types.sv]
set_property file_type "Verilog Header" [get_files /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwpe-sm/rtl/hwpe_sm_params.sv]
set_property file_type "Verilog Header" [get_files /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/per2axi/per2axi_parameters.sv]
read_verilog -library xil_defaultlib -sv {
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_interconnect/rtl/peripheral_interco/AddressDecoder_PE_Req.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_interconnect/rtl/peripheral_interco/AddressDecoder_Resp_PE.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_interconnect/rtl/peripheral_interco/ArbitrationTree_PE.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_interconnect/rtl/peripheral_interco/FanInPrimitive_PE_Resp.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_interconnect/rtl/peripheral_interco/FanInPrimitive_Req_PE.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_peripherals/event_unit/HW_barrier.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_peripherals/event_unit/HW_barrier_logic.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_id_remap/ID_Gen_16.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_id_remap/ID_Gen_4.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_id_remap/ID_Gen_64.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_interconnect/rtl/peripheral_interco/MUX2_REQ_PE.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_interconnect/rtl/peripheral_interco/RR_Flag_Req_PE.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_interconnect/rtl/peripheral_interco/RequestBlock1CH_PE.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_interconnect/rtl/peripheral_interco/RequestBlock2CH_PE.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_interconnect/rtl/peripheral_interco/ResponseBlock_PE.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_interconnect/rtl/peripheral_interco/ResponseTree_PE.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_interconnect/rtl/peripheral_interco/XBAR_PE.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/or10n/alu.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi2per/axi2per.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi2per/axi2per_ar_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi2per/axi2per_aw_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi2per/axi2per_b_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi2per/axi2per_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi2per/axi2per_r_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi2per/axi2per_req_channel.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi2per/axi2per_res_channel.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi2per/axi2per_w_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/axi2per_wrap.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/axi_AR_allocator.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/axi_AW_allocator.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/axi_ArbitrationTree.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/axi_BR_allocator.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/axi_BW_allocator.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/axi_DW_allocator.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/axi_FanInPrimitive_Req.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/axi_RR_Flag_Req.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/axi_address_decoder_AR.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/axi_address_decoder_AW.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/axi_address_decoder_BR.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/axi_address_decoder_BW.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/axi_address_decoder_DW.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_slice/axi_ar_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_slice/axi_aw_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_slice/axi_b_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_id_remap/axi_id_remap.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpsoc/axi_id_remap_wrap.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_mem_if_DP/axi_mem_if_DP.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpsoc/axi_mem_if_DP_wrap.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/axi_multiplexer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/axi_node.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_slice/axi_r_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_mem_if_DP/axi_read_only_ctrl.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/axi_request_block.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_node/axi_response_block.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_slice_dc/axi_slice_dc_master.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/axi_slice_dc_master_wrap.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_slice_dc/axi_slice_dc_slave.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/axi_slice_dc_slave_wrap.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_slice/axi_w_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_mem_if_DP/axi_write_only_ctrl.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/rtl/cluster_clock_gating.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_peripherals/cluster_control_unit/cluster_control_unit.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/cluster_interconnect_wrap.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/cluster_peripherals.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/or10n/controller.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/core_data_memory.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/core_demux.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/core_region.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ctrl_unit/ctrl_fsm.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ctrl_unit/ctrl_if.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ctrl_unit/ctrl_unit.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/or10n/debug_unit.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/dmac_per_wrap.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/dmac_wrap.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/common_cells/edge_propagator_rx.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/common_cells/edge_propagator_tx.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_peripherals/event_unit/event_unit.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_peripherals/event_unit/event_unit_arbiter.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_peripherals/event_unit/event_unit_input.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_peripherals/event_unit/event_unit_mux.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_peripherals/event_unit/event_unit_sm.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/or10n/ex_stage.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/or10n/exc_controller.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ext_unit/ext_ar_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ext_unit/ext_aw_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ext_unit/ext_b_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ext_unit/ext_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ext_unit/ext_opc_buf.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ext_unit/ext_r_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ext_unit/ext_rx_if.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ext_unit/ext_tid_gen.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ext_unit/ext_tx_if.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ext_unit/ext_unit.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ext_unit/ext_w_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/common_cells/generic_fifo.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwce/rtl/hwce_engine.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwce/rtl/hwce_engine_fsm.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/hwce_p2p_tcdm.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/hwce_periph_adapt.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwce/rtl/hwce_shift_adder.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwce/rtl/hwce_sop.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwce/rtl/hwce_top.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwce/rtl/hwce_weight_loader.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwce/rtl/hwce_wmem_xbar.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/hwce_wrap.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwce/rtl/hwce_wrapper.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwce/rtl/hwce_wrapper_fsm.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwce/rtl/hwce_wrapper_slave.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/or10n/hwloop_controller.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/or10n/hwloop_regs.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwpe-sm/rtl/axi/hwpe_axi_addressgen_sink.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwpe-sm/rtl/axi/hwpe_axi_addressgen_sink_FS.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwpe-sm/rtl/axi/hwpe_axi_addressgen_source.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwpe-sm/rtl/axi/hwpe_axi_sink.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwpe-sm/rtl/axi/hwpe_axi_source.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwpe-sm/rtl/axi/hwpe_axi_source_FS.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwpe-sm/rtl/hwpe_sm_decoder.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwpe-sm/rtl/hwpe_sm_encoder.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwpe-sm/rtl/hwpe_sm_regfile.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwpe-sm/rtl/hwpe_sm_slave.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_peripherals/icache_ctrl_unit/icache_ctrl_unit.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/or10n/id_stage.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/or10n/if_stage.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/or10n/instr_core_interface.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_peripherals/event_unit/interrupt_mask.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpsoc/l2_ram_dp.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/or10n/load_store_unit.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/top/mchan.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/misc/mchan_arb_primitive.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/misc/mchan_arbiter.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/mchan_prog.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/misc/mchan_rr_flag_req.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_peripherals/mmu_config_unit/mmu_config_unit.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/or10n/mult.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwce/rtl/one_dsp_MACC.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/or10n/or10n_core.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/rtl/or10n_register_file.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/per2axi/per2axi.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/per2axi/per2axi_ar_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/per2axi/per2axi_aw_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/per2axi/per2axi_b_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/per2axi/per2axi_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/per2axi/per2axi_busy_unit.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/per2axi/per2axi_r_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/per2axi/per2axi_req_channel.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/per2axi/per2axi_res_channel.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/per2axi/per2axi_w_buffer.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/per2axi_wrap.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/periph_FIFO.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/periph_demux.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwce/rtl/pipe_pooling.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/components/pulp_interfaces.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/common_cells/pulp_sync_wedge.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/rtl/register_file_1r_1w_all.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpsoc/soc_bus_wrap.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/or10n/sp_registers.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ctrl_unit/synch_unit.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/tcdm_unit/tcdm_cmd_unpack.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/tcdm_dp_banks_asym.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/tcdm_g_master.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/tcdm_g_slave.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/tcdm_hwce_xbar.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_peripherals/tcdm_pipe_unit/tcdm_pipe_unit.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/tcdm_unit/tcdm_rx_if.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/tcdm_unit/tcdm_synch.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/tcdm_unit/tcdm_tx_if.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/tcdm_unit/tcdm_unit.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/tcdm_xbar.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/cluster_peripherals/timer_unit/timer_unit.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/trans_unit/trans_aligner.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ctrl_unit/trans_allocator.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ctrl_unit/trans_arbiter_wrap.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/trans_unit/trans_buffers.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ctrl_unit/trans_queue.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/trans_unit/trans_unit.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ctrl_unit/trans_unpack.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ctrl_unit/twd_trans_queue.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/mchan/ctrl_unit/twd_trans_splitter.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/uC_to_prog.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/uC_to_wei.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/or10n/wb_stage.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/wei_to_uC.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwce/rtl/weights_mem_dp_wrap.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpcluster/xbar_master_sel.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/hwpe/hwce/rtl/xbar_req_gen.sv
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/rtl/ulpsoc/ulpsoc.sv
}
read_verilog -library xil_defaultlib {
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_slice_dc/dc_data_buffer.v
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_slice_dc/dc_full_detector.v
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_slice_dc/dc_synchronizer.v
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_slice_dc/dc_token_ring.v
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_slice_dc/dc_token_ring_fifo_din.v
  /home/nur/neuraghe_2.0/neuraghe_2.0/fe/ips/axi/axi_slice_dc/dc_token_ring_fifo_dout.v
}
read_ip -quiet /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/ips/xilinx_l2_mem_4096x64_dp2/ip/xilinx_l2_mem_4096x64_dp2.xci
set_property used_in_implementation false [get_files -all /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/ips/xilinx_l2_mem_4096x64_dp2/ip/xilinx_l2_mem_4096x64_dp2_ooc.xdc]
set_property is_locked true [get_files /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/ips/xilinx_l2_mem_4096x64_dp2/ip/xilinx_l2_mem_4096x64_dp2.xci]

read_ip -quiet /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/ips/xilinx_tcdm_bank_2048x64_64/ip/xilinx_tcdm_bank_2048x64_64.xci
set_property used_in_implementation false [get_files -all /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/ips/xilinx_tcdm_bank_2048x64_64/ip/xilinx_tcdm_bank_2048x64_64_ooc.xdc]
set_property is_locked true [get_files /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/ips/xilinx_tcdm_bank_2048x64_64/ip/xilinx_tcdm_bank_2048x64_64.xci]

read_ip -quiet /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/ips/xilinx_tcdm_bank_1024x16_16_Sdp/ip/xilinx_tcdm_bank_1024x16_16_Sdp.xci
set_property used_in_implementation false [get_files -all /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/ips/xilinx_tcdm_bank_1024x16_16_Sdp/ip/xilinx_tcdm_bank_1024x16_16_Sdp_ooc.xdc]
set_property is_locked true [get_files /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/ips/xilinx_tcdm_bank_1024x16_16_Sdp/ip/xilinx_tcdm_bank_1024x16_16_Sdp.xci]

read_ip -quiet /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/ips/xilinx_tcdm_bank_8192x32/ip/xilinx_tcdm_bank_8192x32.xci
set_property used_in_implementation false [get_files -all /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/ips/xilinx_tcdm_bank_8192x32/ip/xilinx_tcdm_bank_8192x32_ooc.xdc]
set_property is_locked true [get_files /home/nur/neuraghe_2.0/neuraghe_2.0/fpga/ips/xilinx_tcdm_bank_8192x32/ip/xilinx_tcdm_bank_8192x32.xci]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top ulpsoc -part xc7z045ffg900-2 -directive AreaOptimized_high -control_set_opt_threshold 1


write_checkpoint -force -noxdef ulpsoc.dcp

catch { report_utilization -file ulpsoc_utilization_synth.rpt -pb ulpsoc_utilization_synth.pb }
