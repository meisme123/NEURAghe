# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    rt::HARTNDb_startJobStats
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    rt::set_parameter enableParallelHelperSpawn true
    set ::env(RT_TMP) "./.Xil/Vivado-12550-mcarr/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    rt::set_parameter areaStrategy 2
    set rt::partid xc7z045ffg900-2

    set rt::multiChipSynthesisFlow false
    source $::env(SYNTH_COMMON)/common_vhdl.tcl
    set rt::defaultWorkLibName xil_defaultlib

    # Skipping read_* RTL commands because this is post-elab optimize flow
    set rt::useElabCache true
    if {$rt::useElabCache == false} {
      rt::read_verilog -sv -include {
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/or10n/include
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_interconnect/rtl/peripheral_interco
    /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/includes
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/include
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_peripherals/include
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_peripherals/event_unit/include
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/icache/icache_scm_sp/globals
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwpe-sm/rtl
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwpe-sm/rtl/axi
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi2per
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/per2axi
  } {
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_interconnect/rtl/peripheral_interco/AddressDecoder_PE_Req.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_interconnect/rtl/peripheral_interco/AddressDecoder_Resp_PE.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_interconnect/rtl/peripheral_interco/ArbitrationTree_PE.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_interconnect/rtl/peripheral_interco/FanInPrimitive_PE_Resp.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_interconnect/rtl/peripheral_interco/FanInPrimitive_Req_PE.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_peripherals/event_unit/HW_barrier.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_peripherals/event_unit/HW_barrier_logic.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_id_remap/ID_Gen_16.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_id_remap/ID_Gen_4.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_id_remap/ID_Gen_64.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_interconnect/rtl/peripheral_interco/MUX2_REQ_PE.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_interconnect/rtl/peripheral_interco/RR_Flag_Req_PE.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_interconnect/rtl/peripheral_interco/RequestBlock1CH_PE.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_interconnect/rtl/peripheral_interco/RequestBlock2CH_PE.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_interconnect/rtl/peripheral_interco/ResponseBlock_PE.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_interconnect/rtl/peripheral_interco/ResponseTree_PE.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_interconnect/rtl/peripheral_interco/XBAR_PE.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/or10n/alu.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi2per/axi2per.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi2per/axi2per_ar_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi2per/axi2per_aw_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi2per/axi2per_b_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi2per/axi2per_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi2per/axi2per_r_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi2per/axi2per_req_channel.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi2per/axi2per_res_channel.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi2per/axi2per_w_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/axi2per_wrap.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node/axi_AR_allocator.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node/axi_AW_allocator.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node/axi_ArbitrationTree.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node/axi_BR_allocator.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node/axi_BW_allocator.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node/axi_DW_allocator.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node/axi_FanInPrimitive_Req.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node/axi_RR_Flag_Req.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node/axi_address_decoder_AR.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node/axi_address_decoder_AW.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node/axi_address_decoder_BR.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node/axi_address_decoder_BW.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node/axi_address_decoder_DW.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_slice/axi_ar_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_slice/axi_aw_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_slice/axi_b_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_id_remap/axi_id_remap.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpsoc/axi_id_remap_wrap.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_mem_if_DP/axi_mem_if_DP.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpsoc/axi_mem_if_DP_wrap.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node/axi_multiplexer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node/axi_node.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_slice/axi_r_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_mem_if_DP/axi_read_only_ctrl.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node/axi_request_block.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node/axi_response_block.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_slice_dc/axi_slice_dc_master.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/axi_slice_dc_master_wrap.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_slice_dc/axi_slice_dc_slave.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/axi_slice_dc_slave_wrap.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_slice/axi_w_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_mem_if_DP/axi_write_only_ctrl.sv
      /home/nur/NEURAghe/neuraghe_1.9/fpga/rtl/cluster_clock_gating.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_peripherals/cluster_control_unit/cluster_control_unit.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/cluster_interconnect_wrap.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/cluster_peripherals.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/or10n/controller.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/core_data_memory.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/core_demux.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/core_region.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ctrl_unit/ctrl_fsm.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ctrl_unit/ctrl_if.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ctrl_unit/ctrl_unit.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/or10n/debug_unit.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/dmac_per_wrap.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/dmac_wrap.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/common_cells/edge_propagator_rx.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/common_cells/edge_propagator_tx.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_peripherals/event_unit/event_unit.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_peripherals/event_unit/event_unit_arbiter.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_peripherals/event_unit/event_unit_input.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_peripherals/event_unit/event_unit_mux.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_peripherals/event_unit/event_unit_sm.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/or10n/ex_stage.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/or10n/exc_controller.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ext_unit/ext_ar_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ext_unit/ext_aw_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ext_unit/ext_b_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ext_unit/ext_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ext_unit/ext_opc_buf.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ext_unit/ext_r_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ext_unit/ext_rx_if.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ext_unit/ext_tid_gen.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ext_unit/ext_tx_if.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ext_unit/ext_unit.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ext_unit/ext_w_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/common_cells/generic_fifo.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl/hwce_engine.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl/hwce_engine_fsm.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl/hwce_linebuffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/hwce_p2p_tcdm.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/hwce_periph_adapt.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl/hwce_shift_adder.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl/hwce_sop.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl/hwce_sop_add.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl/hwce_top.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl/hwce_weight_loader.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl/hwce_wmem_xbar.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/hwce_wrap.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl/hwce_wrapper.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl/hwce_wrapper_fsm.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl/hwce_wrapper_slave.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/or10n/hwloop_controller.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/or10n/hwloop_regs.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwpe-sm/rtl/axi/hwpe_axi_addressgen_sink.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwpe-sm/rtl/axi/hwpe_axi_fifo.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwpe-sm/rtl/axi/hwpe_axi_fifo_earlystall.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwpe-sm/rtl/axi/hwpe_axi_sink.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwpe-sm/rtl/axi/hwpe_axi_source.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwpe-sm/rtl/hwpe_sm_decoder.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwpe-sm/rtl/hwpe_sm_encoder.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwpe-sm/rtl/hwpe_sm_regfile.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwpe-sm/rtl/hwpe_sm_slave.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_peripherals/icache_ctrl_unit/icache_ctrl_unit.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/or10n/id_stage.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/or10n/if_stage.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/or10n/instr_core_interface.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_peripherals/event_unit/interrupt_mask.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpsoc/l2_ram_dp.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/or10n/load_store_unit.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/top/mchan.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/misc/mchan_arb_primitive.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/misc/mchan_arbiter.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/mchan_prog.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/misc/mchan_rr_flag_req.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_peripherals/mmu_config_unit/mmu_config_unit.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/or10n/mult.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl/one_dsp_MACC.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/or10n/or10n_core.sv
      /home/nur/NEURAghe/neuraghe_1.9/fpga/rtl/or10n_register_file.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/per2axi/per2axi.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/per2axi/per2axi_ar_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/per2axi/per2axi_aw_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/per2axi/per2axi_b_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/per2axi/per2axi_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/per2axi/per2axi_busy_unit.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/per2axi/per2axi_r_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/per2axi/per2axi_req_channel.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/per2axi/per2axi_res_channel.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/per2axi/per2axi_w_buffer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/per2axi_wrap.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/periph_FIFO.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/periph_demux.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl/pipe_pooling.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl/pooling_data_shift_register.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl/pooling_layer.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/components/pulp_interfaces.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/common_cells/pulp_sync_wedge.sv
      /home/nur/NEURAghe/neuraghe_1.9/fpga/rtl/register_file_1r_1w.sv
      /home/nur/NEURAghe/neuraghe_1.9/fpga/rtl/register_file_1r_1w_all.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpsoc/soc_bus_wrap.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/or10n/sp_registers.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ctrl_unit/synch_unit.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/tcdm_unit/tcdm_cmd_unpack.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/tcdm_dp_banks_asym.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/tcdm_g_master.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/tcdm_g_slave.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_peripherals/tcdm_pipe_unit/tcdm_pipe_unit.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/tcdm_unit/tcdm_rx_if.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/tcdm_unit/tcdm_synch.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/tcdm_unit/tcdm_tx_if.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/tcdm_unit/tcdm_unit.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/tcdm_xbar.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_peripherals/timer_unit/timer_unit.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/trans_unit/trans_aligner.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ctrl_unit/trans_allocator.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ctrl_unit/trans_arbiter_wrap.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/trans_unit/trans_buffers.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ctrl_unit/trans_queue.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/trans_unit/trans_unit.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ctrl_unit/trans_unpack.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ctrl_unit/twd_trans_queue.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/ctrl_unit/twd_trans_splitter.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/uC_to_prog.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/or10n/wb_stage.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl/weights_mem_dp_wrap.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpcluster/xbar_master_sel.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl/xbar_req_gen.sv
      /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/ulpsoc/ulpsoc.sv
      /home/nur/Xilinx/Vivado/2017.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv
    }
      rt::read_verilog -include {
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/or10n/include
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_interconnect/rtl/peripheral_interco
    /home/nur/NEURAghe/neuraghe_1.9/fe/rtl/includes
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/mchan/include
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_peripherals/include
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/cluster_peripherals/event_unit/include
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/icache/icache_scm_sp/globals
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwce/rtl
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwpe-sm/rtl
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/hwpe/hwpe-sm/rtl/axi
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi2per
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_node
    /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/per2axi
  } {
      ./.Xil/Vivado-12550-mcarr/realtime/xilinx_l2_mem_8192x64_dp2_stub.v
      ./.Xil/Vivado-12550-mcarr/realtime/xilinx_tcdm_bank_4096x64_asym_stub.v
      ./.Xil/Vivado-12550-mcarr/realtime/xilinx_tcdm_bank_2048x64_stub.v
      ./.Xil/Vivado-12550-mcarr/realtime/xilinx_tcdm_bank_8192x32_stub.v
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_slice_dc/dc_data_buffer.v
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_slice_dc/dc_full_detector.v
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_slice_dc/dc_synchronizer.v
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_slice_dc/dc_token_ring.v
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_slice_dc/dc_token_ring_fifo_din.v
      /home/nur/NEURAghe/neuraghe_1.9/fe/ips/axi/axi_slice_dc/dc_token_ring_fifo_dout.v
    }
      rt::read_vhdl -lib xpm /home/nur/Xilinx/Vivado/2017.1/data/ip/xpm/xpm_VCOMP.vhd
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification true
    set rt::SDCFileList ./.Xil/Vivado-12550-mcarr/realtime/ulpsoc_synth.xdc
    rt::sdcChecksum
    set rt::top ulpsoc
    set rt::reportTiming false
    rt::set_parameter elaborateOnly false
    rt::set_parameter elaborateRtl false
    rt::set_parameter eliminateRedundantBitOperator true
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter ramStyle auto
    rt::set_parameter merge_flipflops true
    rt::set_parameter syncControlMinFanout 0
    rt::set_parameter minInstsInControlSet 1
# MODE: 
    rt::set_parameter webTalkPath {/home/nur/NEURAghe/neuraghe_1.9/fpga/soc/soc.cache/wt}
    rt::set_parameter enableSplitFlowPath "./.Xil/Vivado-12550-mcarr/"
    set ok_to_delete_rt_tmp true 
    if { [rt::get_parameter parallelDebug] } { 
       set ok_to_delete_rt_tmp false 
    } 
    if {$rt::useElabCache == false} {
        set oldMIITMVal [rt::get_parameter maxInputIncreaseToMerge]; rt::set_parameter maxInputIncreaseToMerge 1000
        set oldCDPCRL [rt::get_parameter createDfgPartConstrRecurLimit]; rt::set_parameter createDfgPartConstrRecurLimit 1
      rt::run_synthesis -module $rt::top
        rt::set_parameter maxInputIncreaseToMerge $oldMIITMVal
        rt::set_parameter createDfgPartConstrRecurLimit $oldCDPCRL
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    rt::HARTNDb_stopJobStats
    rt::HARTNDb_reportJobStats "Synthesis Optimization Runtime"
    rt::HARTNDb_stopSystemStats
    if { $rt::flowresult == 1 } { return -code error }

    if { [ info exists ::env(RT_TMP) ] } {
      if { [info exists ok_to_delete_rt_tmp] && $ok_to_delete_rt_tmp } { 
        file delete -force $::env(RT_TMP)
      }
    }


  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] && [info exists rt::doParallel] && $rt::doParallel} { 
     $rt::db killSynthHelper $hsKey
  } 
  rt::set_parameter helper_shm_key "" 
    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  $rt::db resetHdlParse
  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] && [info exists rt::doParallel] && $rt::doParallel} { 
     $rt::db killSynthHelper $hsKey
  } 
  source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  return -code "error" $rt::result
}
