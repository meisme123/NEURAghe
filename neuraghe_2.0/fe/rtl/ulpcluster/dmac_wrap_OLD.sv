////////////////////////////////////////////////////////////////////////////////
// Company:        Multitherman Laboratory @ DEIS - University of Bologna     //
//                    Viale Risorgimento 2 40136                              //
//                    Bologna - fax 0512093785 -                              //
//                                                                            //
// Engineer:       Davide Rossi - davide.rossi@unibo.it                       //
//                                                                            //
// Additional contributions by:                                               //
//                 Igor Loi     - igor.loi@unibo.it                           //
//                                                                            //
//                                                                            //
// Create Date:    13/02/2013                                                 // 
// Design Name:    ULPSoC                                                     // 
// Module Name:    ulpcluster_top                                             //
// Project Name:   ULPSoC                                                     //
// Language:       SystemVerilog                                              //
//                                                                            //
// Description:    ULPSoC cluster                                             //
//                                                                            //
//                                                                            //
// Revision:                                                                  //
// Revision v0.1 - File Created                                               //
// Revision v0.2 - (23/02/2015) REmoved Tab, improved identation, and         //
//                 exported some parameters (APPROVED)                        //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

`include "ulpsoc_defines.sv"

module dmac_wrap
#(
    parameter NB_CORES       = 4,
    parameter AXI_ADDR_WIDTH = 32,
    parameter AXI_DATA_WIDTH = 64,
    parameter AXI_USER_WIDTH = 6,
    parameter AXI_ID_WIDTH   = 4,

    parameter TCDM_ADD_WIDTH = 13,

    parameter DATA_WIDTH     = 32,
    parameter ADDR_WIDTH     = 32,
    parameter BE_WIDTH       = DATA_WIDTH/8
)
(
    input logic                      clk_i,
    input logic                      rst_ni,

    input logic                      test_mode_i,

    XBAR_TCDM_BUS.Slave              ctrl_slave[NB_CORES-1:0],

    XBAR_TCDM_BUS.Master             tcdm_master[3:0],

    AXI_BUS.Master                   ext_master,

    output logic [NB_CORES-1:0]      term_event_o,
    output logic                     busy_o
);

   // CORE --> MCHAN CTRL INTERFACE BUS SIGNALS
   logic [NB_CORES-1:0][DATA_WIDTH-1:0]          s_ctrl_bus_wdata;
   logic [NB_CORES-1:0][ADDR_WIDTH-1:0]          s_ctrl_bus_add;
   logic [NB_CORES-1:0]                          s_ctrl_bus_req;
   logic [NB_CORES-1:0]                          s_ctrl_bus_wen;
   logic [NB_CORES-1:0][BE_WIDTH-1:0]            s_ctrl_bus_be;
   logic [NB_CORES-1:0]                          s_ctrl_bus_gnt;
   logic [NB_CORES-1:0][DATA_WIDTH-1:0]          s_ctrl_bus_r_rdata;
   logic [NB_CORES-1:0]                          s_ctrl_bus_r_valid;

   // MCHAN TCDM INIT --> TCDM MEMORY BUS SIGNALS
   logic [3:0][DATA_WIDTH-1:0]                   s_tcdm_bus_wdata;
   logic [3:0][ADDR_WIDTH-1:0]                   s_tcdm_bus_add;
   logic [3:0]                                   s_tcdm_bus_req;
   logic [3:0]                                   s_tcdm_bus_wen;
   logic [3:0][BE_WIDTH-1:0]                     s_tcdm_bus_be;
   logic [3:0]                                   s_tcdm_bus_gnt;
   logic [3:0][DATA_WIDTH-1:0]                   s_tcdm_bus_r_rdata;
   logic [3:0]                                   s_tcdm_bus_r_valid;

   genvar                   i;

   //********************************************************
   //************************ DMAC **************************
   //********************************************************

   generate

      for (i=0; i<NB_CORES; i++)
      begin : CTRL_SLAVE_BIND
         assign s_ctrl_bus_add[i]     = ctrl_slave[i].add;
         assign s_ctrl_bus_req[i]     = ctrl_slave[i].req;
         assign s_ctrl_bus_wdata[i]   = ctrl_slave[i].wdata;
         assign s_ctrl_bus_wen[i]     = ctrl_slave[i].wen;
         assign s_ctrl_bus_be[i]      = ctrl_slave[i].be;

         assign ctrl_slave[i].gnt     = s_ctrl_bus_gnt[i];
         assign ctrl_slave[i].r_opc   = 'b0;
         assign ctrl_slave[i].r_valid = s_ctrl_bus_r_valid[i];
         assign ctrl_slave[i].r_rdata = s_ctrl_bus_r_rdata[i];
      end

   endgenerate

   generate

      for (i=0; i<4; i++)
      begin : TCDM_MASTER_BIND
         assign tcdm_master[i].add      = s_tcdm_bus_add[i];
         assign tcdm_master[i].req      = s_tcdm_bus_req[i];
         assign tcdm_master[i].wdata    = s_tcdm_bus_wdata[i];
         assign tcdm_master[i].wen      = s_tcdm_bus_wen[i];
         assign tcdm_master[i].be       = s_tcdm_bus_be[i];

         assign s_tcdm_bus_gnt[i]       = tcdm_master[i].gnt;
         assign s_tcdm_bus_r_valid[i]   = tcdm_master[i].r_valid;
         assign s_tcdm_bus_r_rdata[i]   = tcdm_master[i].r_rdata;
      end

   endgenerate

   mchan
   #(
       .NB_CORES                 ( NB_CORES             ),    // NUMBER OF CORES
       .RX_BUFFER_DEPTH          ( 4                    ),    // DEPTH OF RX BUFFER (TRANS_UNIT)
       .TX_BUFFER_DEPTH          ( 4                    ),    // DEPTH OF TX BUFFER (TRANS_UNIT)
       .CORE_TRANS_QUEUE_DEPTH   ( 2                    ),    // DEPTH OF PRIVATE PER-CORE COMMAND QUEUE (CTRL_UNIT)
       .GLOBAL_TRANS_QUEUE_DEPTH ( 8                    ),    // DEPTH OF GLOBAL COMMAND QUEUE (CTRL_UNIT)
       .TCDM_ADD_WIDTH           ( TCDM_ADD_WIDTH       ),    // WIDTH OF TCDM ADDRESS
       .EXT_ADD_WIDTH            ( 32                   ),    // WIDTH OF GLOBAL EXTERNAL ADDRESS
       .NB_OUTSND_TRANS          ( 8                    ),    // NUMBER OF OUTSTANDING TRANSACTIONS
       .MCHAN_BURST_LENGTH       ( 64                   ),    // ANY POWER OF 2 VALUE FROM 32 TO 2048
       
       .AXI_ADDR_WIDTH           ( 32                   ),
       .AXI_DATA_WIDTH           ( 64                   ),
       .AXI_USER_WIDTH           ( 6                    ),
       .AXI_ID_WIDTH             ( 4                    )
   )
   mchan_i
   (
      .clk_i                     ( clk_i                ),
      .rst_ni                    ( rst_ni               ),
      
      .test_mode_i               (test_mode_i           ),
      
      // CONTROL TARGET
      //***************************************
      .ctrl_targ_req_i           ( s_ctrl_bus_req       ),
      .ctrl_targ_add_i           ( s_ctrl_bus_add       ),
      .ctrl_targ_type_i          ( s_ctrl_bus_wen       ),
      .ctrl_targ_be_i            ( s_ctrl_bus_be        ),
      .ctrl_targ_data_i          ( s_ctrl_bus_wdata     ),

      .ctrl_targ_gnt_o           ( s_ctrl_bus_gnt       ),
      .ctrl_targ_r_valid_o       ( s_ctrl_bus_r_valid   ),
      .ctrl_targ_r_data_o        ( s_ctrl_bus_r_rdata   ),

      // TCDM INITIATOR
      //***************************************
      .tcdm_init_req_o           ( s_tcdm_bus_req       ),
      .tcdm_init_add_o           ( s_tcdm_bus_add       ),
      .tcdm_init_type_o          ( s_tcdm_bus_wen       ),
      .tcdm_init_be_o            ( s_tcdm_bus_be        ),
      .tcdm_init_data_o          ( s_tcdm_bus_wdata     ),

      .tcdm_init_gnt_i           ( s_tcdm_bus_gnt       ),
      .tcdm_init_r_valid_i       ( s_tcdm_bus_r_valid   ),
      .tcdm_init_r_data_i        ( s_tcdm_bus_r_rdata   ),

      // EXTERNAL INITIATOR
      //***************************************
      .axi_master_aw_valid_o     ( ext_master.aw_valid  ),
      .axi_master_aw_addr_o      ( ext_master.aw_addr   ),
      .axi_master_aw_prot_o      ( ext_master.aw_prot   ),
      .axi_master_aw_region_o    ( ext_master.aw_region ),
      .axi_master_aw_len_o       ( ext_master.aw_len    ),
      .axi_master_aw_size_o      ( ext_master.aw_size   ),
      .axi_master_aw_burst_o     ( ext_master.aw_burst  ),
      .axi_master_aw_lock_o      ( ext_master.aw_lock   ),
      .axi_master_aw_cache_o     ( ext_master.aw_cache  ),
      .axi_master_aw_qos_o       ( ext_master.aw_qos    ),
      .axi_master_aw_id_o        ( ext_master.aw_id[3:0]),
      .axi_master_aw_user_o      ( ext_master.aw_user   ),
      .axi_master_aw_ready_i     ( ext_master.aw_ready  ),

      .axi_master_ar_valid_o     ( ext_master.ar_valid  ),
      .axi_master_ar_addr_o      ( ext_master.ar_addr   ),
      .axi_master_ar_prot_o      ( ext_master.ar_prot   ),
      .axi_master_ar_region_o    ( ext_master.ar_region ),
      .axi_master_ar_len_o       ( ext_master.ar_len    ),
      .axi_master_ar_size_o      ( ext_master.ar_size   ),
      .axi_master_ar_burst_o     ( ext_master.ar_burst  ),
      .axi_master_ar_lock_o      ( ext_master.ar_lock   ),
      .axi_master_ar_cache_o     ( ext_master.ar_cache  ),
      .axi_master_ar_qos_o       ( ext_master.ar_qos    ),
      .axi_master_ar_id_o        ( ext_master.ar_id[3:0]),
      .axi_master_ar_user_o      ( ext_master.ar_user   ),
      .axi_master_ar_ready_i     ( ext_master.ar_ready  ),

      .axi_master_w_valid_o      ( ext_master.w_valid   ),
      .axi_master_w_data_o       ( ext_master.w_data    ),
      .axi_master_w_strb_o       ( ext_master.w_strb    ),
      .axi_master_w_user_o       ( ext_master.w_user    ),
      .axi_master_w_last_o       ( ext_master.w_last    ),
      .axi_master_w_ready_i      ( ext_master.w_ready   ),

      .axi_master_r_valid_i      ( ext_master.r_valid   ),
      .axi_master_r_data_i       ( ext_master.r_data    ),
      .axi_master_r_resp_i       ( ext_master.r_resp    ),
      .axi_master_r_last_i       ( ext_master.r_last    ),
      .axi_master_r_id_i         ( ext_master.r_id[3:0] ),
      .axi_master_r_user_i       ( ext_master.r_user    ),
      .axi_master_r_ready_o      ( ext_master.r_ready   ),

      .axi_master_b_valid_i      ( ext_master.b_valid   ),
      .axi_master_b_resp_i       ( ext_master.b_resp    ),
      .axi_master_b_id_i         ( ext_master.b_id[3:0] ),
      .axi_master_b_user_i       ( ext_master.b_user    ),
      .axi_master_b_ready_o      ( ext_master.b_ready   ),

      .term_event_o              ( term_event_o         ),

      .busy_o                    ( busy_o               )
   );

endmodule
