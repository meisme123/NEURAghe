////////////////////////////////////////////////////////////////////////////////
// Company:        Multitherman Laboratory @ DEIS - University of Bologna     //
//                    Viale Risorgimento 2 40136                              //
//                    Bologna - fax 0512093785 -                              //
//                                                                            //
// Engineer:       Davide Rossi - davide.rossi@unibo.it                       //
//                                                                            //
// Additional contributions by:                                               //
//                                                                            //
//                                                                            //
//                                                                            //
// Create Date:    13/02/2013                                                 //
// Design Name:    ULPSoC                                                     //
// Module Name:    ulpsoc_top                                                 //
// Project Name:   ULPSoC                                                     //
// Language:       SystemVerilog                                              //
//                                                                            //
// Description:    ULPSoC top                                                 //
//                                                                            //
//                                                                            //
// Revision:                                                                  //
// Revision v0.1 - File Created                                               //
// Revision v0.2 - (27/3/2015) Moved Level Shifter in the SoC domain          //
//                 Removed FLIPWELL parameter                                 //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

`include "ulpsoc_defines.sv"

module ulpsoc
  #(
    parameter AXI_ADDR_WIDTH    = 32,
    parameter AXI_DATA_WIDTH    = 64,
    parameter AXI_ID_WIDTH      = 10,
    parameter AXI_USER_WIDTH    = 6,
    parameter AXI_STRB_WIDTH    = AXI_DATA_WIDTH/8,
    parameter BUFFER_WIDTH      = 8,
`ifdef BIG_L2_ONLY_SIM
    parameter L2_MEM_ADDR_WIDTH = 18,    // 2**L2_MEM_ADDR_WIDTH rows (64bit each) in L2 --> TOTAL L2 SIZE = 8byte * 2^L2_MEM_ADDR_WIDTH
`else
    parameter L2_MEM_ADDR_WIDTH = 13, // when creating bitstream L2 size is 32768x64bit
`endif
    parameter RM_SIZE           = 4,
    parameter WM_SIZE           = 4,
    parameter REMAP_ADDR        = 1,
    parameter AXI_TO_PS_ID_WIDTH   = 4,
   // parameter AXI_STDOUT_ID_WIDTH  = 4,
    
    parameter DATA_WIDTH           = 32,
    parameter ADDR_WIDTH           = 32,
    parameter BE_WIDTH             = DATA_WIDTH/8  
      
    )
   (
    input  logic        rstn_sync_i,
    input  logic        clk_soc_i,
    input  logic        clk_cluster_fast_i,
    input  logic        clk_wmem_i,
    
    input  logic        test_mode_i,
    input  logic        mode_select_i,
    input logic         fetch_en_i,
    
    output logic        eoc_o,  
    output logic [1:0]  return_o,       
    
    input  logic [31:0] from_ps_bus_aw_addr,
    input  logic [2:0]  from_ps_bus_aw_prot,
    input  logic [3:0]  from_ps_bus_aw_region,
    input  logic [7:0]  from_ps_bus_aw_len,
    input  logic [2:0]  from_ps_bus_aw_size,
    input  logic [1:0]  from_ps_bus_aw_burst,
    input  logic        from_ps_bus_aw_lock,
    input  logic [3:0]  from_ps_bus_aw_cache,
    input  logic [3:0]  from_ps_bus_aw_qos,
    input  logic [9:0]  from_ps_bus_aw_id,
    input  logic [5:0]  from_ps_bus_aw_user,
    output logic        from_ps_bus_aw_ready,
    input  logic        from_ps_bus_aw_valid,
    
    input  logic [31:0] from_ps_bus_ar_addr,
    input  logic [2:0]  from_ps_bus_ar_prot,
    input  logic [3:0]  from_ps_bus_ar_region,
    input  logic [7:0]  from_ps_bus_ar_len,
    input  logic [2:0]  from_ps_bus_ar_size,
    input  logic [1:0]  from_ps_bus_ar_burst,
    input  logic        from_ps_bus_ar_lock,
    input  logic [3:0]  from_ps_bus_ar_cache,
    input  logic [3:0]  from_ps_bus_ar_qos,
    input  logic [9:0]  from_ps_bus_ar_id,
    input  logic [5:0]  from_ps_bus_ar_user,
    output logic        from_ps_bus_ar_ready,
    input  logic        from_ps_bus_ar_valid,
    
    input  logic [63:0] from_ps_bus_w_data,
    input  logic [7:0]  from_ps_bus_w_strb,
    input  logic [5:0]  from_ps_bus_w_user,
    input  logic        from_ps_bus_w_last,
    output logic        from_ps_bus_w_ready,
    input  logic        from_ps_bus_w_valid,
    
    output logic [63:0] from_ps_bus_r_data,
    output logic [1:0]  from_ps_bus_r_resp,
    output logic        from_ps_bus_r_last,
    output logic [9:0]  from_ps_bus_r_id,
    output logic [5:0]  from_ps_bus_r_user,
    input  logic        from_ps_bus_r_ready,
    output logic        from_ps_bus_r_valid,
    
    output logic [1:0]  from_ps_bus_b_resp,
    output logic [9:0]  from_ps_bus_b_id,
    output logic [5:0]  from_ps_bus_b_user,
    input  logic        from_ps_bus_b_ready,
    output logic        from_ps_bus_b_valid,  
    
        
    
    output logic [31:0] stdout_master_aw_addr,
    output logic [2:0]  stdout_master_aw_prot,
    output logic [3:0]  stdout_master_aw_region,
    output logic [7:0]  stdout_master_aw_len,
    output logic [2:0]  stdout_master_aw_size,
    output logic [1:0]  stdout_master_aw_burst,
    output logic        stdout_master_aw_lock,
    output logic [3:0]  stdout_master_aw_cache,
    output logic [3:0]  stdout_master_aw_qos,
    output logic [AXI_TO_PS_ID_WIDTH-1:0]  stdout_master_aw_id,
    output logic [5:0]  stdout_master_aw_user,
    input  logic        stdout_master_aw_ready,
    output logic        stdout_master_aw_valid,
    
    output logic [31:0] stdout_master_ar_addr,
    output logic [2:0]  stdout_master_ar_prot,
    output logic [3:0]  stdout_master_ar_region,
    output logic [7:0]  stdout_master_ar_len,
    output logic [2:0]  stdout_master_ar_size,
    output logic [1:0]  stdout_master_ar_burst,
    output logic        stdout_master_ar_lock,
    output logic [3:0]  stdout_master_ar_cache,
    output logic [3:0]  stdout_master_ar_qos,
    output logic [AXI_TO_PS_ID_WIDTH -1:0]  stdout_master_ar_id,
    output logic [5:0]  stdout_master_ar_user,
    input  logic        stdout_master_ar_ready,
    output logic        stdout_master_ar_valid,
    
    output logic [63:0] stdout_master_w_data,
    output logic [7:0]  stdout_master_w_strb,
    output logic [5:0]  stdout_master_w_user,
    output logic        stdout_master_w_last,
    input  logic        stdout_master_w_ready,
    output logic        stdout_master_w_valid,
    
    input  logic [63:0] stdout_master_r_data,
    input  logic [1:0]  stdout_master_r_resp,
    input  logic        stdout_master_r_last,
    input  logic [AXI_TO_PS_ID_WIDTH -1:0]  stdout_master_r_id,
    input  logic [5:0]  stdout_master_r_user,
    output logic        stdout_master_r_ready,
    input  logic        stdout_master_r_valid,
    
    input  logic [1:0]  stdout_master_b_resp,
    input  logic [AXI_TO_PS_ID_WIDTH -1:0]  stdout_master_b_id,
    input  logic [5:0]  stdout_master_b_user,
    output logic        stdout_master_b_ready,
    input  logic        stdout_master_b_valid,  
    
    
    
    output logic [31:0] to_ps_bus_aw_addr,
    output logic [2:0]  to_ps_bus_aw_prot,
    output logic [3:0]  to_ps_bus_aw_region,
    output logic [7:0]  to_ps_bus_aw_len,
    output logic [2:0]  to_ps_bus_aw_size,
    output logic [1:0]  to_ps_bus_aw_burst,
    output logic        to_ps_bus_aw_lock,
    output logic [3:0]  to_ps_bus_aw_cache,
    output logic [3:0]  to_ps_bus_aw_qos,
    output logic [AXI_TO_PS_ID_WIDTH -1 :0]  to_ps_bus_aw_id,
    output logic [5:0]  to_ps_bus_aw_user,
    input  logic        to_ps_bus_aw_ready,
    output logic        to_ps_bus_aw_valid,
    
    output logic [31:0] to_ps_bus_ar_addr,
    output logic [2:0]  to_ps_bus_ar_prot,
    output logic [3:0]  to_ps_bus_ar_region,
    output logic [7:0]  to_ps_bus_ar_len,
    output logic [2:0]  to_ps_bus_ar_size,
    output logic [1:0]  to_ps_bus_ar_burst,
    output logic        to_ps_bus_ar_lock,
    output logic [3:0]  to_ps_bus_ar_cache,
    output logic [3:0]  to_ps_bus_ar_qos,
    output logic [AXI_TO_PS_ID_WIDTH -1 :0]  to_ps_bus_ar_id,
    output logic [5:0]  to_ps_bus_ar_user,
    input  logic        to_ps_bus_ar_ready,
    output logic        to_ps_bus_ar_valid,
    
    output logic [63:0] to_ps_bus_w_data,
    output logic [7:0]  to_ps_bus_w_strb,
    output logic [5:0]  to_ps_bus_w_user,
    output logic        to_ps_bus_w_last,
    input  logic        to_ps_bus_w_ready,
    output logic        to_ps_bus_w_valid,
    
    input  logic [63:0] to_ps_bus_r_data,
    input  logic [1:0]  to_ps_bus_r_resp,
    input  logic        to_ps_bus_r_last,
    input  logic [AXI_TO_PS_ID_WIDTH -1 :0]  to_ps_bus_r_id,
    input  logic [5:0]  to_ps_bus_r_user,
    output logic        to_ps_bus_r_ready,
    input logic         to_ps_bus_r_valid,
    
    input  logic [1:0]  to_ps_bus_b_resp,
    input  logic [AXI_TO_PS_ID_WIDTH -1 :0]  to_ps_bus_b_id,
    input  logic [5:0]  to_ps_bus_b_user,
    output logic        to_ps_bus_b_ready,
    input  logic        to_ps_bus_b_valid,
    
    
    
    
    
    output logic [31:0] dma2ddr_bus_aw_addr,
    output logic [2:0]  dma2ddr_bus_aw_prot,
    output logic [3:0]  dma2ddr_bus_aw_region,
    output logic [7:0]  dma2ddr_bus_aw_len,
    output logic [2:0]  dma2ddr_bus_aw_size,
    output logic [1:0]  dma2ddr_bus_aw_burst,
    output logic        dma2ddr_bus_aw_lock,
    output logic [3:0]  dma2ddr_bus_aw_cache,
    output logic [3:0]  dma2ddr_bus_aw_qos,
    output logic [AXI_TO_PS_ID_WIDTH -1 :0]  dma2ddr_bus_aw_id,
    output logic [5:0]  dma2ddr_bus_aw_user,
    input  logic        dma2ddr_bus_aw_ready,
    output logic        dma2ddr_bus_aw_valid,
    
    output logic [31:0] dma2ddr_bus_ar_addr,
    output logic [2:0]  dma2ddr_bus_ar_prot,
    output logic [3:0]  dma2ddr_bus_ar_region,
    output logic [7:0]  dma2ddr_bus_ar_len,
    output logic [2:0]  dma2ddr_bus_ar_size,
    output logic [1:0]  dma2ddr_bus_ar_burst,
    output logic        dma2ddr_bus_ar_lock,
    output logic [3:0]  dma2ddr_bus_ar_cache,
    output logic [3:0]  dma2ddr_bus_ar_qos,
    output logic [AXI_TO_PS_ID_WIDTH -1 :0]  dma2ddr_bus_ar_id,
    output logic [5:0]  dma2ddr_bus_ar_user,
    input  logic        dma2ddr_bus_ar_ready,
    output logic        dma2ddr_bus_ar_valid,
    
    output logic [63:0] dma2ddr_bus_w_data,
    output logic [7:0]  dma2ddr_bus_w_strb,
    output logic [5:0]  dma2ddr_bus_w_user,
    output logic        dma2ddr_bus_w_last,
    input  logic        dma2ddr_bus_w_ready,
    output logic        dma2ddr_bus_w_valid,
    
    input  logic [63:0] dma2ddr_bus_r_data,
    input  logic [1:0]  dma2ddr_bus_r_resp,
    input  logic        dma2ddr_bus_r_last,
    input  logic [AXI_TO_PS_ID_WIDTH -1 :0]  dma2ddr_bus_r_id,
    input  logic [5:0]  dma2ddr_bus_r_user,
    output logic        dma2ddr_bus_r_ready,
    input logic         dma2ddr_bus_r_valid,
    
    input  logic [1:0]  dma2ddr_bus_b_resp,
    input  logic [AXI_TO_PS_ID_WIDTH -1 :0]  dma2ddr_bus_b_id,
    input  logic [5:0]  dma2ddr_bus_b_user,
    output logic        dma2ddr_bus_b_ready,
    input  logic        dma2ddr_bus_b_valid,


    
    
    
    
    output logic [31:0] wei2ddr_bus_aw_addr,
    output logic [2:0]  wei2ddr_bus_aw_prot,
    output logic [3:0]  wei2ddr_bus_aw_region,
    output logic [7:0]  wei2ddr_bus_aw_len,
    output logic [2:0]  wei2ddr_bus_aw_size,
    output logic [1:0]  wei2ddr_bus_aw_burst,
    output logic        wei2ddr_bus_aw_lock,
    output logic [3:0]  wei2ddr_bus_aw_cache,
    output logic [3:0]  wei2ddr_bus_aw_qos,
    output logic [AXI_TO_PS_ID_WIDTH -1 :0]  wei2ddr_bus_aw_id,
    output logic [5:0]  wei2ddr_bus_aw_user,
    input  logic        wei2ddr_bus_aw_ready,
    output logic        wei2ddr_bus_aw_valid,
    
    output logic [31:0] wei2ddr_bus_ar_addr,
    output logic [2:0]  wei2ddr_bus_ar_prot,
    output logic [3:0]  wei2ddr_bus_ar_region,
    output logic [7:0]  wei2ddr_bus_ar_len,
    output logic [2:0]  wei2ddr_bus_ar_size,
    output logic [1:0]  wei2ddr_bus_ar_burst,
    output logic        wei2ddr_bus_ar_lock,
    output logic [3:0]  wei2ddr_bus_ar_cache,
    output logic [3:0]  wei2ddr_bus_ar_qos,
    output logic [AXI_TO_PS_ID_WIDTH -1 :0]  wei2ddr_bus_ar_id,
    output logic [5:0]  wei2ddr_bus_ar_user,
    input  logic        wei2ddr_bus_ar_ready,
    output logic        wei2ddr_bus_ar_valid,
    
    output logic [63:0] wei2ddr_bus_w_data,
    output logic [7:0]  wei2ddr_bus_w_strb,
    output logic [5:0]  wei2ddr_bus_w_user,
    output logic        wei2ddr_bus_w_last,
    input  logic        wei2ddr_bus_w_ready,
    output logic        wei2ddr_bus_w_valid,
    
    input  logic [63:0] wei2ddr_bus_r_data,
    input  logic [1:0]  wei2ddr_bus_r_resp,
    input  logic        wei2ddr_bus_r_last,
    input  logic [AXI_TO_PS_ID_WIDTH -1 :0]  wei2ddr_bus_r_id,
    input  logic [5:0]  wei2ddr_bus_r_user,
    output logic        wei2ddr_bus_r_ready,
    input logic         wei2ddr_bus_r_valid,
    
    input  logic [1:0]  wei2ddr_bus_b_resp,
    input  logic [AXI_TO_PS_ID_WIDTH -1 :0]  wei2ddr_bus_b_id,
    input  logic [5:0]  wei2ddr_bus_b_user,
    output logic        wei2ddr_bus_b_ready,
    input  logic        wei2ddr_bus_b_valid 
);


`define ZC76C
//`define ZC76C2x4
//`define ZEDBOARD



`ifdef ZEDBOARD  
    localparam N_ROW           = 2; //`NB_HWCE_ROW;
    localparam N_COL           = 2; //`NB_HWCE_COL;
    localparam BANK_SIZE_32BIT = 4096;
`endif

`ifdef ZC76C  
    localparam N_ROW           = 4; //`NB_HWCE_ROW;
    localparam N_COL           = 4; //`NB_HWCE_COL;
    localparam BANK_SIZE_32BIT = 8192;
`endif 
 
`ifdef ZC76C2x2 
    localparam N_ROW           = 2; //`NB_HWCE_ROW;
    localparam N_COL           = 2; //`NB_HWCE_COL;
    localparam BANK_SIZE_32BIT = 8192;
`endif    
 
`ifdef ZC76C2x4 
    localparam N_ROW           = 4; //`NB_HWCE_ROW;
    localparam N_COL           = 2; //`NB_HWCE_COL;
    localparam BANK_SIZE_32BIT = 8192;
`endif  
    
    
    localparam CONV_WIDTH     = 16; //legal values 16 or 8


    localparam NPF            = 3; // number of parallel filters 3x3

    //CLUSTER PARAMETERS
    
    localparam NB_CORES              = `NB_CORES;
    localparam NB_HWACC_PORTS        = 4;
    localparam NB_DMAS               = `NB_DMAS;
    localparam NB_MPERIPHS           = `NB_MPERIPHS;
    localparam N_Y_BANKS             = 20;
    localparam NB_TCDM_BANKS         = N_Y_BANKS + NPF*N_COL; // `NB_TCDM_BANKS;
    localparam NB_SPERIPHS           = `NB_SPERIPHS;
    
    localparam BANK_SIZE_64BIT       = BANK_SIZE_32BIT/2;

    
    localparam WEI_MEM_BANK_SIZE = 2048;//1024;
    

    //ICACHE PARAMETERS
    localparam NB_CACHE_BANKS        = 4;


    //CORE PARAMETERS
    localparam ROM_BOOT_ADDR         = 32'h1A000000;
    localparam BOOT_ADDR             = 32'h1C000000;
`ifdef RISCV
    localparam INSTR_RDATA_WIDTH     = 128;
`else
    localparam INSTR_RDATA_WIDTH     = 32;
`endif

    // AXI PARAMETERS
    localparam DC_SLICE_BUFFER_WIDTH = 8;

    //CLUSTER MAIN PARAMETERS

    //MCHAN PARAMETERS
    localparam TCDM_ADD_WIDTH        = $clog2(BANK_SIZE_32BIT * NB_TCDM_BANKS * 4)+1;//18, // Total bit used to address the whole TCDM ( 2^17 = 128K; TCDM SIZE = 64Kof SRAM + 8K of SCM; ADDR WIDTH = 17 bits )

    //TCDM PARAMETERS
    localparam TEST_SET_BIT          = 22; // bits used to indicate a test and set opration during a load in TCDM
    
    localparam ADDR_SRAM_WIDTH_A       = $clog2(BANK_SIZE_64BIT); //11; // bits used to address a single bank in SRAM TCDM
    localparam ADDR_SRAM_WIDTH_B       = $clog2(BANK_SIZE_32BIT); //11; // bits used to address a single bank in SRAM TCDM
  
    //PERIPH PARAMETERS
    localparam PE_ROUTING_LSB        = 10; // LSB used as routing BIT in periph interco
    localparam PE_ROUTING_MSB        = 13;  // MSB used as routing BIT in periph interco
    
   
    localparam HWCE_PORTS = NPF*N_COL+2*N_ROW;
  
    localparam WEI_MEM_ADDR_WIDTH = $clog2(N_ROW*N_COL*WEI_MEM_BANK_SIZE*8); // bits to address the total size of the weight mem

    localparam LOG_CLUSTER     = 5;  // NOT USED RIGTH NOW

    








    //********************************************************
    //***************** SIGNALS DECLARATION ******************
    //********************************************************
 
  logic [1:0]                        instr_req;
  logic [1:0][31:0]                  instr_addr;
  logic [1:0]                        instr_gnt;
  logic [1:0]                        instr_r_valid;
  logic [1:0][31:0] instr_r_rdata;

    

    logic                               s_clk_soc;
    logic                               s_clk_fast;

    logic                               s_rstn_sync;


    logic  [7:0]                        s_soc_events;

    assign s_soc_events = 8'b0;

    AXI_BUS
     #(
       .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
       .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
       .AXI_ID_WIDTH(AXI_TO_PS_ID_WIDTH),
       .AXI_USER_WIDTH(AXI_USER_WIDTH)
       )
   stdout_master();  
    
   AXI_BUS
     #(
       .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
       .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
       .AXI_ID_WIDTH(AXI_ID_WIDTH),
       .AXI_USER_WIDTH(AXI_USER_WIDTH)
       )
   stdout_master_pre_id_remap();  
   
   AXI_BUS
    #(
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ID_WIDTH(AXI_ID_WIDTH),
        .AXI_USER_WIDTH(AXI_USER_WIDTH)
    )
    s_soc_l2_bus();
    
    AXI_BUS
    #(
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ID_WIDTH(AXI_ID_WIDTH),
        .AXI_USER_WIDTH(AXI_USER_WIDTH)
    )
    dummy_axi_if();
    
    AXI_BUS
    #(
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ID_WIDTH(AXI_ID_WIDTH),
        .AXI_USER_WIDTH(AXI_USER_WIDTH)
    )
    dummy_axi_if_2();
    
    UNICAD_MEM_BUS_64  s_soc_l2_mem();
    
    UNICAD_MEM_BUS_64  s_soc_l2_mem_b();
    
    AXI_BUS
    #(
        .AXI_ADDR_WIDTH  ( AXI_ADDR_WIDTH ),
        .AXI_DATA_WIDTH  ( AXI_DATA_WIDTH ),
        .AXI_ID_WIDTH    ( AXI_ID_WIDTH   ),
        .AXI_USER_WIDTH  ( AXI_USER_WIDTH )
    )
    instr_master();
    
   
   

    AXI_BUS
    #(
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ID_WIDTH(AXI_ID_WIDTH),
        .AXI_USER_WIDTH(AXI_USER_WIDTH)
    )
    from_ps_bus();

    AXI_BUS
    #(
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ID_WIDTH(AXI_TO_PS_ID_WIDTH),
        .AXI_USER_WIDTH(AXI_USER_WIDTH)
    )
    to_ps_bus();
    

    AXI_BUS
    #(
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ID_WIDTH(AXI_ID_WIDTH),
        .AXI_USER_WIDTH(AXI_USER_WIDTH)
    )
    to_ps_bus_pre_id_remap();
    
    AXI_BUS
    #(
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ID_WIDTH(AXI_TO_PS_ID_WIDTH),
        .AXI_USER_WIDTH(AXI_USER_WIDTH)
    )
    dma2ddr_bus();
    
    AXI_BUS
    #(
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ID_WIDTH(AXI_TO_PS_ID_WIDTH),
        .AXI_USER_WIDTH(AXI_USER_WIDTH)
    )
    wei2ddr_bus();

   
    
    AXI_BUS
    #(
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ID_WIDTH(AXI_ID_WIDTH),
        .AXI_USER_WIDTH(AXI_USER_WIDTH)
    )
    data_slave();

    AXI_BUS
    #(
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ID_WIDTH(AXI_ID_WIDTH),
        .AXI_USER_WIDTH(AXI_USER_WIDTH)
    )
    data_slave_id_remapped();

  

    AXI_BUS
    #(
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ID_WIDTH(AXI_ID_WIDTH),
        .AXI_USER_WIDTH(AXI_USER_WIDTH)
    )
    s_soc_rom_bus();

    AXI_BUS
    #(
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ID_WIDTH(AXI_ID_WIDTH),
        .AXI_USER_WIDTH(AXI_USER_WIDTH)
    )
    s_soc_apb_bus();



    logic [7:0]   s_soc_events_ack;
    logic [7:0]   s_soc_events_val;



    assign s_rstn_sync  = rstn_sync_i;
    assign s_clk_soc    = clk_soc_i;
    assign s_clk_fast   = clk_cluster_fast_i;
  

// PS7 DDR BASE ADDRESS 0x00100000
// PS7 DDR LAST ADDRESS 0x3FFFFFFF

/*
██████╗ ██████╗ ██████╗     ██████╗ ███████╗███╗   ███╗ █████╗ ██████╗ 
██╔══██╗██╔══██╗██╔══██╗    ██╔══██╗██╔════╝████╗ ████║██╔══██╗██╔══██╗
██║  ██║██║  ██║██████╔╝    ██████╔╝█████╗  ██╔████╔██║███████║██████╔╝
██║  ██║██║  ██║██╔══██╗    ██╔══██╗██╔══╝  ██║╚██╔╝██║██╔══██║██╔═══╝ 
██████╔╝██████╔╝██║  ██║    ██║  ██║███████╗██║ ╚═╝ ██║██║  ██║██║     
╚═════╝ ╚═════╝ ╚═╝  ╚═╝    ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     
                                                                       
*/

generate
  if (REMAP_ADDR==1) begin
  
    always_comb  begin : address_signals_remapped
      //slave
      from_ps_bus.aw_addr   = {4'h1, from_ps_bus_aw_addr[27:0]};          // input
      from_ps_bus.ar_addr   = {4'h1, from_ps_bus_ar_addr[27:0]};          // input      

`ifdef ZEDBOARD      
      //on ZEDBOARD the ddr space reserved for neuraghe starts from 0x18000000
      
      //master
      to_ps_bus_aw_addr     = {5'b00011, to_ps_bus.aw_addr[26:0]};          // output
      to_ps_bus_ar_addr     = {5'b00011, to_ps_bus.ar_addr[26:0]};          // output
      
       //master
      dma2ddr_bus_aw_addr     = {5'b00011, dma2ddr_bus.aw_addr[26:0]};          // output
      dma2ddr_bus_ar_addr     = {5'b00011, dma2ddr_bus.ar_addr[26:0]};          // output
      
      //master
      wei2ddr_bus_aw_addr     = {5'b00011, wei2ddr_bus.aw_addr[26:0]};          // output
      wei2ddr_bus_ar_addr     = {5'b00011, wei2ddr_bus.ar_addr[26:0]};          // output
`else      
      //on ZC706 the ddr space reserved for neuraghe starts from 0x30000000
      
      //master
      to_ps_bus_aw_addr     = {4'h3, to_ps_bus.aw_addr[27:0]};          // output
      to_ps_bus_ar_addr     = {4'h3, to_ps_bus.ar_addr[27:0]};          // output
      
       //master
      dma2ddr_bus_aw_addr     = {4'h3, dma2ddr_bus.aw_addr[27:0]};          // output
      dma2ddr_bus_ar_addr     = {4'h3, dma2ddr_bus.ar_addr[27:0]};          // output
      
      //master
      wei2ddr_bus_aw_addr     = {4'h3, wei2ddr_bus.aw_addr[27:0]};          // output
      wei2ddr_bus_ar_addr     = {4'h3, wei2ddr_bus.ar_addr[27:0]};          // output
`endif     
      
      stdout_master_aw_addr = {16'hE000, stdout_master.aw_addr[15:0]};          // output
      stdout_master_ar_addr = {16'hE000, stdout_master.ar_addr[15:0]};          // output
    end
  
  end
  else begin
    always_comb  begin : address_signals_direct
      //slave
      from_ps_bus.aw_addr   = from_ps_bus_aw_addr;          // input
      from_ps_bus.ar_addr   = from_ps_bus_ar_addr;          // input
      
      
      //master
      to_ps_bus_aw_addr   = to_ps_bus.aw_addr;          // output
      to_ps_bus_ar_addr   = to_ps_bus.ar_addr;          // output
      
      //master
      dma2ddr_bus_aw_addr   = dma2ddr_bus.aw_addr;          // output
      dma2ddr_bus_ar_addr   = dma2ddr_bus.ar_addr;          // output
      
      //master
      wei2ddr_bus_aw_addr   = wei2ddr_bus.aw_addr;          // output
      wei2ddr_bus_ar_addr   = wei2ddr_bus.ar_addr;          // output
      
      stdout_master_aw_addr   = stdout_master.aw_addr;          // output
      stdout_master_ar_addr   = stdout_master.ar_addr;          // output
    end
  end
endgenerate


   
always_comb  begin : from_ps_bus_if
    from_ps_bus.aw_lock   = from_ps_bus_aw_lock;          // input
    from_ps_bus.ar_lock   = from_ps_bus_ar_lock;          // input
    from_ps_bus.w_last    = from_ps_bus_w_last;           // input
    from_ps_bus_r_last    = from_ps_bus.r_last;           // output
  //  from_ps_bus.aw_addr   = from_ps_bus_aw_addr;          // input
    from_ps_bus.aw_prot   = from_ps_bus_aw_prot;          // input
    from_ps_bus.aw_region = from_ps_bus_aw_region;        // input
    from_ps_bus.aw_len    = from_ps_bus_aw_len;           // input
    from_ps_bus.aw_size   = from_ps_bus_aw_size;          // input
    from_ps_bus.aw_burst  = from_ps_bus_aw_burst;         // input
    from_ps_bus.aw_cache  = from_ps_bus_aw_cache;         // input
    from_ps_bus.aw_qos    = from_ps_bus_aw_qos;           // input
    from_ps_bus.aw_id     = from_ps_bus_aw_id;            // input
    from_ps_bus.aw_user   = from_ps_bus_aw_user;          // input
    from_ps_bus_aw_ready  = from_ps_bus.aw_ready;
    from_ps_bus.aw_valid  = from_ps_bus_aw_valid;
    
 //   from_ps_bus.ar_addr   = from_ps_bus_ar_addr;          // input
    from_ps_bus.ar_prot   = from_ps_bus_ar_prot;          // input
    from_ps_bus.ar_region = from_ps_bus_ar_region;        // input
    from_ps_bus.ar_len    = from_ps_bus_ar_len;           // input
    from_ps_bus.ar_size   = from_ps_bus_ar_size;          // input
    from_ps_bus.ar_burst  = from_ps_bus_ar_burst;         // input
    from_ps_bus.ar_cache  = from_ps_bus_ar_cache;         // input
    from_ps_bus.ar_qos    = from_ps_bus_ar_qos;           // input
    from_ps_bus.ar_id     = from_ps_bus_ar_id;            // input
    from_ps_bus.ar_user   = from_ps_bus_ar_user;          // input
    from_ps_bus_ar_ready  = from_ps_bus.ar_ready;
    from_ps_bus.ar_valid  = from_ps_bus_ar_valid;
    
    from_ps_bus.w_data    = from_ps_bus_w_data;           // input
    from_ps_bus.w_strb    = from_ps_bus_w_strb;           // input
    from_ps_bus.w_user    = from_ps_bus_w_user;           // input
    from_ps_bus_w_ready   = from_ps_bus.w_ready;
    from_ps_bus.w_valid   = from_ps_bus_w_valid;
    
    from_ps_bus_r_data    = from_ps_bus.r_data;           // output
    from_ps_bus_r_resp    = from_ps_bus.r_resp;           // output
    from_ps_bus_r_id      = from_ps_bus.r_id;             // output
    from_ps_bus_r_user    = from_ps_bus.r_user;           // output
    from_ps_bus.r_ready   = from_ps_bus_r_ready;
    from_ps_bus_r_valid   = from_ps_bus.r_valid;
    
    from_ps_bus_b_resp    = from_ps_bus.b_resp;           // output
    from_ps_bus_b_id      = from_ps_bus.b_id;             // output
    from_ps_bus_b_user    = from_ps_bus.b_user;           // output
    from_ps_bus.b_ready   = from_ps_bus_b_ready;
    from_ps_bus_b_valid   = from_ps_bus.b_valid;    



  end

  always_comb
  begin : to_ps_bus_if
    to_ps_bus_aw_lock   = to_ps_bus.aw_lock;          // output
    to_ps_bus_ar_lock   = to_ps_bus.ar_lock;          // output
    to_ps_bus_w_last    = to_ps_bus.w_last;           // output
    to_ps_bus.r_last    = to_ps_bus_r_last;           // input
   // to_ps_bus_aw_addr   = to_ps_bus.aw_addr;          // output
    to_ps_bus_aw_prot   = to_ps_bus.aw_prot;          // output
    to_ps_bus_aw_region = to_ps_bus.aw_region;        // output
    to_ps_bus_aw_len    = to_ps_bus.aw_len;           // output
    to_ps_bus_aw_size   = to_ps_bus.aw_size;          // output
    to_ps_bus_aw_burst  = to_ps_bus.aw_burst;         // output
    to_ps_bus_aw_cache  = to_ps_bus.aw_cache;         // output
    to_ps_bus_aw_qos    = to_ps_bus.aw_qos;           // output
    to_ps_bus_aw_id     = to_ps_bus.aw_id;            // output
    to_ps_bus_aw_user   = to_ps_bus.aw_user;          // output
    to_ps_bus.aw_ready  = to_ps_bus_aw_ready;
    to_ps_bus_aw_valid  = to_ps_bus.aw_valid;
    
   // to_ps_bus_ar_addr   = to_ps_bus.ar_addr;          // output
    to_ps_bus_ar_prot   = to_ps_bus.ar_prot;          // output
    to_ps_bus_ar_region = to_ps_bus.ar_region;        // output
    to_ps_bus_ar_len    = to_ps_bus.ar_len;           // output
    to_ps_bus_ar_size   = to_ps_bus.ar_size;          // output
    to_ps_bus_ar_burst  = to_ps_bus.ar_burst;         // output
    to_ps_bus_ar_cache  = to_ps_bus.ar_cache;         // output
    to_ps_bus_ar_qos    = to_ps_bus.ar_qos;           // output
    to_ps_bus_ar_id     = to_ps_bus.ar_id;            // output
    to_ps_bus_ar_user   = to_ps_bus.ar_user;          // output
    to_ps_bus.ar_ready  = to_ps_bus_ar_ready;
    to_ps_bus_ar_valid  = to_ps_bus.ar_valid;
     
    to_ps_bus_w_data    = to_ps_bus.w_data;           // output
    to_ps_bus_w_strb    = to_ps_bus.w_strb;           // output
    to_ps_bus_w_user    = to_ps_bus.w_user;           // output
    to_ps_bus.w_ready   = to_ps_bus_w_ready;
    to_ps_bus_w_valid   = to_ps_bus.w_valid;
     
    to_ps_bus.r_data    = to_ps_bus_r_data;           // input
    to_ps_bus.r_resp    = to_ps_bus_r_resp;           // input
    to_ps_bus.r_id      = to_ps_bus_r_id;             // input
    to_ps_bus.r_user    = to_ps_bus_r_user;           // input
    to_ps_bus_r_ready   = to_ps_bus.r_ready;
    to_ps_bus.r_valid   = to_ps_bus_r_valid;
      
    to_ps_bus.b_resp    = to_ps_bus_b_resp;           // input
    to_ps_bus.b_id      = to_ps_bus_b_id;             // input
    to_ps_bus.b_user    = to_ps_bus_b_user;           // input
    to_ps_bus_b_ready   = to_ps_bus.b_ready;
    to_ps_bus.b_valid   = to_ps_bus_b_valid;

  end
  
  
  
  
  
  
  
  
  
  always_comb
  begin : dma2ddr_bus_if
    dma2ddr_bus_aw_lock   = dma2ddr_bus.aw_lock;          // output
    dma2ddr_bus_ar_lock   = dma2ddr_bus.ar_lock;          // output
    dma2ddr_bus_w_last    = dma2ddr_bus.w_last;           // output
    dma2ddr_bus.r_last    = dma2ddr_bus_r_last;           // input
   // dma2ddr_bus_aw_addr   = dma2ddr_bus.aw_addr;          // output
    dma2ddr_bus_aw_prot   = dma2ddr_bus.aw_prot;          // output
    dma2ddr_bus_aw_region = dma2ddr_bus.aw_region;        // output
    dma2ddr_bus_aw_len    = dma2ddr_bus.aw_len;           // output
    dma2ddr_bus_aw_size   = dma2ddr_bus.aw_size;          // output
    dma2ddr_bus_aw_burst  = dma2ddr_bus.aw_burst;         // output
    dma2ddr_bus_aw_cache  = dma2ddr_bus.aw_cache;         // output
    dma2ddr_bus_aw_qos    = dma2ddr_bus.aw_qos;           // output
    dma2ddr_bus_aw_id     = dma2ddr_bus.aw_id;            // output
    dma2ddr_bus_aw_user   = dma2ddr_bus.aw_user;          // output
    dma2ddr_bus.aw_ready  = dma2ddr_bus_aw_ready;
    dma2ddr_bus_aw_valid  = dma2ddr_bus.aw_valid;
    
   // dma2ddr_bus_ar_addr   = dma2ddr_bus.ar_addr;          // output
    dma2ddr_bus_ar_prot   = dma2ddr_bus.ar_prot;          // output
    dma2ddr_bus_ar_region = dma2ddr_bus.ar_region;        // output
    dma2ddr_bus_ar_len    = dma2ddr_bus.ar_len;           // output
    dma2ddr_bus_ar_size   = dma2ddr_bus.ar_size;          // output
    dma2ddr_bus_ar_burst  = dma2ddr_bus.ar_burst;         // output
    dma2ddr_bus_ar_cache  = dma2ddr_bus.ar_cache;         // output
    dma2ddr_bus_ar_qos    = dma2ddr_bus.ar_qos;           // output
    dma2ddr_bus_ar_id     = dma2ddr_bus.ar_id;            // output
    dma2ddr_bus_ar_user   = dma2ddr_bus.ar_user;          // output
    dma2ddr_bus.ar_ready  = dma2ddr_bus_ar_ready;
    dma2ddr_bus_ar_valid  = dma2ddr_bus.ar_valid;
     
    dma2ddr_bus_w_data    = dma2ddr_bus.w_data;           // output
    dma2ddr_bus_w_strb    = dma2ddr_bus.w_strb;           // output
    dma2ddr_bus_w_user    = dma2ddr_bus.w_user;           // output
    dma2ddr_bus.w_ready   = dma2ddr_bus_w_ready;
    dma2ddr_bus_w_valid   = dma2ddr_bus.w_valid;
     
    dma2ddr_bus.r_data    = dma2ddr_bus_r_data;           // input
    dma2ddr_bus.r_resp    = dma2ddr_bus_r_resp;           // input
    dma2ddr_bus.r_id      = dma2ddr_bus_r_id;             // input
    dma2ddr_bus.r_user    = dma2ddr_bus_r_user;           // input
    dma2ddr_bus_r_ready   = dma2ddr_bus.r_ready;
    dma2ddr_bus.r_valid   = dma2ddr_bus_r_valid;
      
    dma2ddr_bus.b_resp    = dma2ddr_bus_b_resp;           // input
    dma2ddr_bus.b_id      = dma2ddr_bus_b_id;             // input
    dma2ddr_bus.b_user    = dma2ddr_bus_b_user;           // input
    dma2ddr_bus_b_ready   = dma2ddr_bus.b_ready;
    dma2ddr_bus.b_valid   = dma2ddr_bus_b_valid;

  end
  
  
  
  
  
    always_comb
  begin : wei2ddr_bus_if
    wei2ddr_bus_aw_lock   = wei2ddr_bus.aw_lock;          // output
    wei2ddr_bus_ar_lock   = wei2ddr_bus.ar_lock;          // output
    wei2ddr_bus_w_last    = wei2ddr_bus.w_last;           // output
    wei2ddr_bus.r_last    = wei2ddr_bus_r_last;           // input
   // wei2ddr_bus_aw_addr   = wei2ddr_bus.aw_addr;          // output
    wei2ddr_bus_aw_prot   = wei2ddr_bus.aw_prot;          // output
    wei2ddr_bus_aw_region = wei2ddr_bus.aw_region;        // output
    wei2ddr_bus_aw_len    = wei2ddr_bus.aw_len;           // output
    wei2ddr_bus_aw_size   = wei2ddr_bus.aw_size;          // output
    wei2ddr_bus_aw_burst  = wei2ddr_bus.aw_burst;         // output
    wei2ddr_bus_aw_cache  = wei2ddr_bus.aw_cache;         // output
    wei2ddr_bus_aw_qos    = wei2ddr_bus.aw_qos;           // output
    wei2ddr_bus_aw_id     = wei2ddr_bus.aw_id;            // output
    wei2ddr_bus_aw_user   = wei2ddr_bus.aw_user;          // output
    wei2ddr_bus.aw_ready  = wei2ddr_bus_aw_ready;
    wei2ddr_bus_aw_valid  = wei2ddr_bus.aw_valid;
    
   // wei2ddr_bus_ar_addr   = wei2ddr_bus.ar_addr;          // output
    wei2ddr_bus_ar_prot   = wei2ddr_bus.ar_prot;          // output
    wei2ddr_bus_ar_region = wei2ddr_bus.ar_region;        // output
    wei2ddr_bus_ar_len    = wei2ddr_bus.ar_len;           // output
    wei2ddr_bus_ar_size   = wei2ddr_bus.ar_size;          // output
    wei2ddr_bus_ar_burst  = wei2ddr_bus.ar_burst;         // output
    wei2ddr_bus_ar_cache  = wei2ddr_bus.ar_cache;         // output
    wei2ddr_bus_ar_qos    = wei2ddr_bus.ar_qos;           // output
    wei2ddr_bus_ar_id     = wei2ddr_bus.ar_id;            // output
    wei2ddr_bus_ar_user   = wei2ddr_bus.ar_user;          // output
    wei2ddr_bus.ar_ready  = wei2ddr_bus_ar_ready;
    wei2ddr_bus_ar_valid  = wei2ddr_bus.ar_valid;
     
    wei2ddr_bus_w_data    = wei2ddr_bus.w_data;           // output
    wei2ddr_bus_w_strb    = wei2ddr_bus.w_strb;           // output
    wei2ddr_bus_w_user    = wei2ddr_bus.w_user;           // output
    wei2ddr_bus.w_ready   = wei2ddr_bus_w_ready;
    wei2ddr_bus_w_valid   = wei2ddr_bus.w_valid;
     
    wei2ddr_bus.r_data    = wei2ddr_bus_r_data;           // input
    wei2ddr_bus.r_resp    = wei2ddr_bus_r_resp;           // input
    wei2ddr_bus.r_id      = wei2ddr_bus_r_id;             // input
    wei2ddr_bus.r_user    = wei2ddr_bus_r_user;           // input
    wei2ddr_bus_r_ready   = wei2ddr_bus.r_ready;
    wei2ddr_bus.r_valid   = wei2ddr_bus_r_valid;
      
    wei2ddr_bus.b_resp    = wei2ddr_bus_b_resp;           // input
    wei2ddr_bus.b_id      = wei2ddr_bus_b_id;             // input
    wei2ddr_bus.b_user    = wei2ddr_bus_b_user;           // input
    wei2ddr_bus_b_ready   = wei2ddr_bus.b_ready;
    wei2ddr_bus.b_valid   = wei2ddr_bus_b_valid;

  end
  
  
  
  

  always_comb
  begin : stdout_master_if
    stdout_master_aw_lock   = stdout_master.aw_lock;          // output
    stdout_master_ar_lock   = stdout_master.ar_lock;          // output
    stdout_master_w_last    = stdout_master.w_last;           // output
    stdout_master.r_last    = stdout_master_r_last;           // input
  //  stdout_master_aw_addr   = stdout_master.aw_addr;          // output
    stdout_master_aw_prot   = stdout_master.aw_prot;          // output
    stdout_master_aw_region = stdout_master.aw_region;        // output
    stdout_master_aw_len    = stdout_master.aw_len;           // output
    stdout_master_aw_size   = stdout_master.aw_size;          // output
    stdout_master_aw_burst  = stdout_master.aw_burst;         // output
    stdout_master_aw_cache  = stdout_master.aw_cache;         // output
    stdout_master_aw_qos    = stdout_master.aw_qos;           // output
    stdout_master_aw_id     = stdout_master.aw_id;            // output
    stdout_master_aw_user   = stdout_master.aw_user;          // output
    stdout_master.aw_ready  = stdout_master_aw_ready;
    stdout_master_aw_valid  = stdout_master.aw_valid;
     
 //   stdout_master_ar_addr   = stdout_master.ar_addr;          // output
    stdout_master_ar_prot   = stdout_master.ar_prot;          // output
    stdout_master_ar_region = stdout_master.ar_region;        // output
    stdout_master_ar_len    = stdout_master.ar_len;           // output
    stdout_master_ar_size   = stdout_master.ar_size;          // output
    stdout_master_ar_burst  = stdout_master.ar_burst;         // output
    stdout_master_ar_cache  = stdout_master.ar_cache;         // output
    stdout_master_ar_qos    = stdout_master.ar_qos;           // output
    stdout_master_ar_id     = stdout_master.ar_id;            // output
    stdout_master_ar_user   = stdout_master.ar_user;          // output
    stdout_master.ar_ready  = stdout_master_ar_ready;
    stdout_master_ar_valid  = stdout_master.ar_valid;
     
    stdout_master_w_data    = stdout_master.w_data;           // output
    stdout_master_w_strb    = stdout_master.w_strb;           // output
    stdout_master_w_user    = stdout_master.w_user;           // output
    stdout_master.w_ready   = stdout_master_w_ready;
    stdout_master_w_valid   = stdout_master.w_valid;
    
    stdout_master.r_data    = stdout_master_r_data;           // input
    stdout_master.r_resp    = stdout_master_r_resp;           // input
    stdout_master.r_id      = stdout_master_r_id;             // input
    stdout_master.r_user    = stdout_master_r_user;           // input
    stdout_master_r_ready   = stdout_master.r_ready;
    stdout_master.r_valid   = stdout_master_r_valid;
    
    stdout_master.b_resp    = stdout_master_b_resp;           // input
    stdout_master.b_id      = stdout_master_b_id;             // input
    stdout_master.b_user    = stdout_master_b_user;           // input
    stdout_master_b_ready   = stdout_master.b_ready;
    stdout_master.b_valid   = stdout_master_b_valid;

  end


    assign dummy_axi_if_2.aw_valid  = 1'b0;
    assign dummy_axi_if_2.aw_addr   = 'b0;
    assign dummy_axi_if_2.aw_prot   = 'b0;
    assign dummy_axi_if_2.aw_region = 'b0;
    assign dummy_axi_if_2.aw_len    = 'b0;
    assign dummy_axi_if_2.aw_size   = 'b0;
    assign dummy_axi_if_2.aw_burst  = 'b0;
    assign dummy_axi_if_2.aw_lock   = 1'b0;
    assign dummy_axi_if_2.aw_cache  = 'b0;
    assign dummy_axi_if_2.aw_qos    = 'b0;
    assign dummy_axi_if_2.aw_id     = 'b0;
    assign dummy_axi_if_2.aw_user   = 'b0;
    //assign dummy_axi_if_2.aw_ready  = 'b0;

    assign dummy_axi_if_2.ar_valid  = 1'b0;
    assign dummy_axi_if_2.ar_addr   = 'b0;
    assign dummy_axi_if_2.ar_prot   = 'b0;
    assign dummy_axi_if_2.ar_region = 'b0;
    assign dummy_axi_if_2.ar_len    = 'b0;
    assign dummy_axi_if_2.ar_size   = 'b0;
    assign dummy_axi_if_2.ar_burst  = 'b0;
    assign dummy_axi_if_2.ar_lock   = 1'b0;
    assign dummy_axi_if_2.ar_cache  = 'b0;
    assign dummy_axi_if_2.ar_qos    = 'b0;
    assign dummy_axi_if_2.ar_id     = 'b0;
    assign dummy_axi_if_2.ar_user   = 'b0;
    //assign dummy_axi_if_2.ar_ready  = 'b0;
    
    // assign dummy_axi_if_2.r_valid   = 'b0;
    // assign dummy_axi_if_2.r_data    = 'b0;
    // assign dummy_axi_if_2.r_resp    = 'b0;
    // assign dummy_axi_if_2.r_last    = 'b0;
    // assign dummy_axi_if_2.r_id      = 'b0;
    // assign dummy_axi_if_2.r_user    = 'b0;
    assign dummy_axi_if_2.r_ready   = 1'b0;
    
    assign dummy_axi_if_2.w_valid   = 1'b0;
    assign dummy_axi_if_2.w_data    = 'b0;
    assign dummy_axi_if_2.w_strb    = 'b0;
    assign dummy_axi_if_2.w_last    = 1'b0;
    assign dummy_axi_if_2.w_user    = 'b0;
    //assign dummy_axi_if_2.w_ready   = 'b0;
    
    // assign dummy_axi_if_2.b_valid   = 'b0;
    // assign dummy_axi_if_2.b_resp    = 'b0;
    // assign dummy_axi_if_2.b_id      = 'b0;
    // assign dummy_axi_if_2.b_user    = 'b0;
    assign dummy_axi_if_2.b_ready   = 1'b0;


AXI_BUS
    #(
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ID_WIDTH(AXI_ID_WIDTH),
        .AXI_USER_WIDTH(AXI_USER_WIDTH)
    )
    wei_dma_cntr_master();
    
    AXI_BUS
    #(
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ID_WIDTH(AXI_ID_WIDTH),
        .AXI_USER_WIDTH(AXI_USER_WIDTH)
    )
    mperiph_bus();




    // PER2AXI - EXT BUS SIGNALS
    AXI_BUS
    #(
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ID_WIDTH(AXI_ID_WIDTH),
        .AXI_USER_WIDTH(AXI_USER_WIDTH)
    )
    s_core_ext_bus();



/*


███████╗ ██████╗  ██████╗    ██████╗ ██╗   ██╗███████╗
██╔════╝██╔═══██╗██╔════╝    ██╔══██╗██║   ██║██╔════╝
███████╗██║   ██║██║         ██████╔╝██║   ██║███████╗
╚════██║██║   ██║██║         ██╔══██╗██║   ██║╚════██║
███████║╚██████╔╝╚██████╗    ██████╔╝╚██████╔╝███████║
╚══════╝ ╚═════╝  ╚═════╝    ╚═════╝  ╚═════╝ ╚══════╝
                                                      


*/
   //********************************************************
    //*********************** SOC BUS ************************
    //********************************************************

    soc_bus_wrap
    #(
        .AXI_ADDR_WIDTH      ( AXI_ADDR_WIDTH  ),
        .AXI_DATA_WIDTH      ( AXI_DATA_WIDTH  ),
        .AXI_ID_WIDTH        ( AXI_ID_WIDTH    ), 
        .AXI_USER_WIDTH      ( AXI_USER_WIDTH  )
    )
    soc_bus_wrap_i
    (
        .clk_i                ( s_clk_soc                  ),
        .rst_ni               ( s_rstn_sync                ),
        .test_en_i            ( test_mode_i                ),
                
        .cluster_data_slave   ( s_core_ext_bus             ),
        .soc_ps_slave         ( from_ps_bus                ),
                
        .soc_ps_master        ( to_ps_bus_pre_id_remap     ),
        .core_dmem_master     ( data_slave                 ),
        .soc_stdout_master    ( stdout_master_pre_id_remap ),
        .core_imem_master     ( s_soc_l2_bus               ),
        .periph_master        ( mperiph_bus                ),
        .wei_dma_master       ( wei_dma_cntr_master        )
    ); 




   logic [4:0]        cluster_id_i;
   assign cluster_id_i= 5'd0 ;
   
   
   
   logic             busy_o;




    //********************************************************
    //***************** SIGNALS DECLARATION ******************
    //********************************************************
    logic [NB_CORES-1:0]                fetch_enable_reg_int;
    logic [NB_CORES-1:0]                fetch_en_int;
    logic                               s_addr_tran_en;
    logic                               s_rst_n;



    // CORES - XBAR TCDM BUS SIGNALS
    XBAR_TCDM_BUS
      s_core_xbar_bus[NB_CORES+NB_HWACC_PORTS-1:0]();

    // CORES - DMACTRL BUS SIGNALS
    XBAR_TCDM_BUS
      s_core_dmactrl_bus[4-1:0]();

   // CORES - Event Unit Direct BUS SIGNALS
    XBAR_PERIPH_BUS
      s_core_euctrl_bus[NB_CORES-1:0]();

    // CORES - XBAR PERIPH BUS SIGNALS
    XBAR_PERIPH_BUS
      s_core_periph_bus[NB_CORES-1:0]();


    
    
    
    
    // CORES INSTRUCTION BUS SIGNALS
    AXI_BUS
    #(
        .AXI_ADDR_WIDTH (AXI_ADDR_WIDTH ),
        .AXI_DATA_WIDTH (AXI_DATA_WIDTH ),
        .AXI_ID_WIDTH   (AXI_ID_WIDTH   ),
        .AXI_USER_WIDTH (AXI_USER_WIDTH )
    )
    s_core_instr_bus();

    // HWACC configuration port
    XBAR_PERIPH_BUS
      s_hwacc_cfg_bus();

    logic [3:0]         hwacc_evt_interrupt; //FIXME FRANCESCO --> 4 bit or should be parametrizable

    XBAR_TCDM_BUS       s_hwce_xbar_bport_bus  [HWCE_PORTS-1:0](); // [31:0]
    TCDM_BANK_MEM_BUS   s_tcdm_bus_sram_bport  [NB_TCDM_BANKS-1:0](); 

   //----------------------------------------------------------------------//
   // Interfaces between ICache - L0 - Icache_Interco and Icache_ctrl_unit //
   //                                                                      //
   ICACHE_CTRL_UNIT_BUS  IC_ctrl_unit_bus[NB_CACHE_BANKS]();
   L0_CTRL_UNIT_BUS      L0_ctrl_unit_bus[NB_CORES]();
   //----------------------------------------------------------------------//

  // Interfaces between TCDM_INTERCO and SCM-SRAM MEMORIES
  TCDM_BANK_MEM_BUS_64BIT            s_tcdm_bus_sram[NB_TCDM_BANKS-1:0]();
  TCDM_BANK_MEM_BUS                  s_tcdm_bus_scm [NB_TCDM_BANKS-1:0]();

  // Interfaces for BBMUX Control unit and Clock Gating control unit
  CLKGATE_CONFIG_BUS                 clkgate_bus();



  // CLK reset, and other control signals

  logic                              s_cluster_int_busy;

  logic [1:0]                       return_int;

  logic [7:0]                        ext_events_int;

  logic [NB_CORES-1:0]               ready_to_shutdown;



  

   logic                            tcdm_sleep;
   
   
   

`ifndef DUAL_CORE
      assign ready_to_shutdown[1]=0;
      assign instr_req[1]=0;
      assign instr_addr[1]=0;
      
      assign s_core_dmactrl_bus[1].req=0;
      assign s_core_dmactrl_bus[1].add=0;
      assign s_core_dmactrl_bus[1].wen=0;
      assign s_core_dmactrl_bus[1].wdata=0;
      assign s_core_dmactrl_bus[1].be=0;
      
      assign s_core_euctrl_bus[1].req=0;
      assign s_core_euctrl_bus[1].add=0;
      assign s_core_euctrl_bus[1].wen=0;
      assign s_core_euctrl_bus[1].wdata=0;
      assign s_core_euctrl_bus[1].be=0;
      assign s_core_euctrl_bus[1].id=0;
   
      assign s_core_periph_bus[1].req=0;
      assign s_core_periph_bus[1].add=0;
      assign s_core_periph_bus[1].wen=0;
      assign s_core_periph_bus[1].wdata=0;
      assign s_core_periph_bus[1].be=0;
      assign s_core_periph_bus[1].id=0; 

`endif




  genvar index;

  assign busy_o = s_cluster_int_busy | (| ready_to_shutdown);

  assign fetch_en_int   = fetch_enable_reg_int;

 
  assign s_rst_n= s_rstn_sync;


   //********************************************************
   //***************** INT ISLAND ***************************
   //********************************************************
   logic[NB_CORES-1:0] IRQ_link;
   logic[NB_CORES-1:0] NMIRQ_link;


  
  
  
   
   // Interface between GPCore and BRAM
  XBAR_TCDM_BUS                  s_core_bram_bus();
    
  


    genvar i;

    logic [NB_TCDM_BANKS-1:0]           enable_req_pipe;
    logic [NB_TCDM_BANKS-1:0]           enable_resp_pipe;

    logic [NB_CORES-1:0]                s_term_event;

    logic s_per2axi_busy;
    logic s_axi2per_busy;
    logic s_axi2mem_busy;
    logic s_dmac_busy;

    assign s_cluster_int_busy = s_per2axi_busy | s_axi2per_busy | s_axi2mem_busy | s_dmac_busy;


   //********************************************************
   //***************** SIGNALS DECLARATION ******************
   //********************************************************
   

    XBAR_TCDM_BUS
      s_dma_xbar_bus[NB_DMAS-1:0]();

    // XBAR - SLAVE PERIPHERALS BUS SIGNALS
    XBAR_PERIPH_BUS
      s_xbar_speriph_bus[NB_SPERIPHS-1:0]();

    // EXT - XBAR PERIPHS BUS SIGNALS
    XBAR_TCDM_BUS
      s_mperiph_xbar_bus[`NB_MPERIPHS-1:0]();

    // MMU CONFIGURATION SIGNALS (from peripheral unit)
    MMU_CONFIG_BUS
      s_mmu_bus();



    //********************************************************
    //************************ AXI2PER ***********************
    //********************************************************
    axi2per_wrap
    #(
        .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ID_WIDTH(AXI_ID_WIDTH),
        .AXI_USER_WIDTH(AXI_USER_WIDTH)
    )
    axi2per_wrap_i
    (
        .clk_i(s_clk_soc),
        .rst_ni(s_rst_n),

        .axi_slave(mperiph_bus),

        .periph_master(s_mperiph_xbar_bus[`NB_MPERIPHS-1]),

        .busy_o(s_axi2per_busy)
    );

    //********************************************************
    //************************ PER2AXI ***********************
    //********************************************************

    per2axi_wrap
    #(
        .NB_CORES       (4),
        .PER_ADDR_WIDTH (32),
        .PER_ID_WIDTH   (NB_CORES+NB_MPERIPHS),
        .AXI_ADDR_WIDTH (AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH (AXI_DATA_WIDTH),
        .AXI_USER_WIDTH (AXI_USER_WIDTH),
        .AXI_ID_WIDTH   (6) //IGOR FIXES: was AXI_ID_WIDTH aka 6
    )
    per2axi_wrap_i
    (
        .clk_i          ( s_clk_soc),
        .rst_ni         ( s_rst_n),
        .periph_slave   ( s_xbar_speriph_bus[`SPER_EXT_ID]),
        .axi_master     ( s_core_ext_bus),
        .busy_o         ( s_per2axi_busy)
    );


/*

██████╗ ███╗   ███╗ █████╗ 
██╔══██╗████╗ ████║██╔══██╗
██║  ██║██╔████╔██║███████║
██║  ██║██║╚██╔╝██║██╔══██║
██████╔╝██║ ╚═╝ ██║██║  ██║
╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝
                           

*/




    //********************************************************
    //************************* DMAC *************************
    //********************************************************
    logic [4-1:0]                s_term_event_int;
    assign s_term_event = s_term_event_int[NB_CORES-1:0]; // workaround for a warning: Port size (4) does not match connection size (2) for port 'term_event_o'.
   
    dmac_wrap
    #(
        .NB_CORES       ( 4                ), //FIXME, cores are actually 2 but changing this parameter to 2 will get errors.
        .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH   ),
        .AXI_DATA_WIDTH ( AXI_DATA_WIDTH   ),
        .AXI_ID_WIDTH   ( AXI_TO_PS_ID_WIDTH     ),
        .AXI_USER_WIDTH ( AXI_USER_WIDTH   ),
        .BANK_SIZE_32BIT( BANK_SIZE_32BIT  ),

        // Bits used to address the TCDM
        .TCDM_ADD_WIDTH ( TCDM_ADD_WIDTH   ),
        //main CLuster paramters
        .DATA_WIDTH     ( DATA_WIDTH       ),
        .ADDR_WIDTH     ( ADDR_WIDTH       ),
        .BE_WIDTH       ( BE_WIDTH         )
    )
    dmac_wrap_i
    (
        .clk_i          ( s_clk_soc          ),
        .rst_ni         ( s_rst_n            ),        
        .test_mode_i    ( test_mode_i        ),
        .term_event_o   ( s_term_event_int   ),
        .busy_o         ( s_dmac_busy        ),
        
        .ctrl_slave     ( s_core_dmactrl_bus ),

        .tcdm_master    ( s_dma_xbar_bus     ),

        .ext_master     ( dma2ddr_bus        )
    );
    
    
    
/*
██╗███╗   ██╗████████╗███████╗██████╗  ██████╗ ██████╗ ███╗   ██╗███╗   ██╗███████╗ ██████╗████████╗
██║████╗  ██║╚══██╔══╝██╔════╝██╔══██╗██╔════╝██╔═══██╗████╗  ██║████╗  ██║██╔════╝██╔════╝╚══██╔══╝
██║██╔██╗ ██║   ██║   █████╗  ██████╔╝██║     ██║   ██║██╔██╗ ██║██╔██╗ ██║█████╗  ██║        ██║   
██║██║╚██╗██║   ██║   ██╔══╝  ██╔══██╗██║     ██║   ██║██║╚██╗██║██║╚██╗██║██╔══╝  ██║        ██║   
██║██║ ╚████║   ██║   ███████╗██║  ██║╚██████╗╚██████╔╝██║ ╚████║██║ ╚████║███████╗╚██████╗   ██║   
╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═╝   
                                                                                                    
*/
    //********************************************************
    //*************** CLUSTER INTERCONNECT *******************
    //********************************************************
    cluster_interconnect_wrap
    #(
        .NB_CORES           ( NB_CORES        ),
        .NB_HWACC_PORTS     ( NB_HWACC_PORTS  ),
        .NB_DMAS            ( NB_DMAS         ),
        .NB_MPERIPHS        ( NB_MPERIPHS     ),
        .NB_TCDM_BANKS      ( NB_TCDM_BANKS   ),
        .NB_SPERIPHS        ( NB_SPERIPHS     ),

        .DATA_WIDTH         ( DATA_WIDTH      ),
        .ADDR_WIDTH         ( ADDR_WIDTH      ),
        .BE_WIDTH           ( BE_WIDTH        ),

        .TEST_SET_BIT       ( TEST_SET_BIT    ),
        
        .ADDR_SRAM_WIDTH_A  ( ADDR_SRAM_WIDTH_A ),
        .ADDR_SRAM_WIDTH_B  ( ADDR_SRAM_WIDTH_B ),

        .LOG_CLUSTER        ( LOG_CLUSTER     ),
        .PE_ROUTING_LSB     ( PE_ROUTING_LSB  ),
        .PE_ROUTING_MSB     ( PE_ROUTING_MSB  ),
        .N_BPORTS           ( HWCE_PORTS      ),
        .NPF                (       NPF       ),
        .N_ROW              (      N_ROW      ),
        .N_COL              (      N_COL      ),
        .N_SLAVES_XBAR      ( N_Y_BANKS       ),
        
        .BANK_SIZE          ( BANK_SIZE_64BIT )
    )
    cluster_interconnect_wrap_i
    (
        .clk_i                  ( s_clk_soc                           ),
        .clk_fast_i             ( s_clk_fast                          ),
        .rst_ni                 ( s_rst_n                             ),

        .hwce_tcdm_slave        ( s_hwce_xbar_bport_bus               ), 
        .core_periph_slave      ( s_core_periph_bus                   ),
        .dma_slave              ( s_dma_xbar_bus                      ),
        .mperiph_slave          ( s_mperiph_xbar_bus[NB_MPERIPHS-1:0] ),

        .tcdm_sram_master       ( s_tcdm_bus_sram                     ), // to memories
        .tcdm_sram_master_bport ( s_tcdm_bus_sram_bport               ), // to memories

        .speriph_master         ( s_xbar_speriph_bus                  ),
        .enable_req_pipe_i      ( enable_req_pipe                     ),
        .enable_resp_pipe_i     ( enable_resp_pipe                    )
    );

    //********************************************************
    //************** CLUSTER PERIPHERALS *********************
    //********************************************************

   cluster_peripherals
   #(
       .NB_CORES       ( NB_CORES       ),
       .NB_SPERIPHS    ( NB_SPERIPHS    ),
       .NB_CACHE_BANKS ( NB_CACHE_BANKS ),
       .NB_TCDM_BANKS  ( NB_TCDM_BANKS  ),
       .NB_HWACC_PORTS ( NB_HWACC_PORTS ),
       .RM_SIZE        ( RM_SIZE        ),
       .WM_SIZE        ( WM_SIZE        )
   )
   cluster_peripherals_i
   (

      .clk_i(s_clk_soc),
      .rst_ni(s_rst_n),

      .ext_events_i(ext_events_int), //not used
      .dma_events_i(s_term_event),
      .en_sa_boot_i(mode_select_i), //not used
      .fetch_en_i(fetch_en_i),
      .ready_to_shutdown_i(ready_to_shutdown),

      .addr_tran_en_o(s_addr_tran_en),

      .speriph_slave(s_xbar_speriph_bus[NB_SPERIPHS-2:0]),

      .core_eu_direct_link (s_core_euctrl_bus),

      .hwacc_cfg_master(s_hwacc_cfg_bus),
      .hwacc_events_i('0),

      .eoc_o(eoc_o),
      .return_o(return_o),
      
      .fetch_enable_reg_o(fetch_enable_reg_int),
      .IRQ_o(IRQ_link),
      .NMIRQ_o(NMIRQ_link),
      
      
      
      .enable_req_pipe_o (enable_req_pipe), //not used
      .enable_resp_pipe_o (enable_resp_pipe) , //not used

      .clkgate_bus(clkgate_bus), //not used

      .mmu_bus(s_mmu_bus), //not used

      // SRAM SPEED REGULATION --> TCDM
      .rm_o   (), //not used
      .wm_o   (), //not used

      .LS_o   (), //not used
      .HS_o   (), //not used

      .IC_ctrl_unit_bus     ( IC_ctrl_unit_bus ), //not used
      .L0_ctrl_unit_bus     ( L0_ctrl_unit_bus ) //not used
   );
   
   
   
   
   
   

   
   
   
   
   
   
   
   
   XBAR_TCDM_BUS
      ext2mem_bus ();


    axi2per_wrap
    #(
        .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH ),
        .AXI_DATA_WIDTH ( AXI_DATA_WIDTH ),
        .AXI_ID_WIDTH   ( AXI_ID_WIDTH   ),
        .AXI_USER_WIDTH ( AXI_USER_WIDTH )
    )
    axi2per_datamem_i
    (
        .clk_i          ( s_clk_soc      ),
        .rst_ni         ( s_rst_n         ),

        .axi_slave      ( data_slave     ),
        .periph_master  ( ext2mem_bus    ),
        .busy_o         (                )
    );






     core_data_memory
      #(
      .BANK_SIZE      (         8192    ), // BANK_SIZE_32BIT
      .NB_BANKS       ( 1               ),
      .MEM_ADDR_WIDTH ( 32              )
      )
      core_data_memory_i
      (
      .clk_i          ( s_clk_soc       ),
      .rst_ni         ( s_rst_n         ),
      .core_slave     ( s_core_bram_bus ),
      .ext_slave      ( ext2mem_bus     )
      );


   //********************************************************
   //***************** CORE ISLANDS *************************
   //********************************************************
   //------------------------------------------------------//
   //          ██████╗ ██████╗ ██████╗ ███████╗            //
   //         ██╔════╝██╔═══██╗██╔══██╗██╔════╝            //
   //         ██║     ██║   ██║██████╔╝█████╗              //
   //         ██║     ██║   ██║██╔══██╗██╔══╝              //
   //         ╚██████╗╚██████╔╝██║  ██║███████╗            //
   //          ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝            //
   //------------------------------------------------------//
  
     core_region
            #(
                .CORE_ID             ( 0                ),
                .ADDR_WIDTH          ( 32                ),
                .DATA_WIDTH          ( 32                ),
                .INSTR_RDATA_WIDTH   ( INSTR_RDATA_WIDTH ),
                .ROM_BOOT_ADDR       ( ROM_BOOT_ADDR     ),
                .BOOT_ADDR           ( BOOT_ADDR         )
            )
            core_region_i
            (
                .clk_i               (  s_clk_soc          ),
                .rst_ni              (  s_rst_n              ),
        `ifdef REMAP_ADDRESS
                .base_addr_i         (  base_addr_i          ),
        `endif
                .init_ni             (  '0             ),
                .cluster_id_i        (  cluster_id_i         ),
                .fetch_en_i          (  fetch_en_int[0]      ),
                .addr_tran_en_i      (  s_addr_tran_en       ),
                .IRQ_i               (  IRQ_link[0]          ),
                .NMIRQ_i             (  NMIRQ_link[0]        ),
                .test_mode_i         (  test_mode_i          ),
                .ready_to_shutdown_o ( ready_to_shutdown[0]  ),

                //----- INSTRUCTION CACHE BIND --------------//
                .instr_req_o         (  instr_req[0]         ),
                .instr_gnt_i         (  instr_gnt[0]         ),
                .instr_addr_o        (  instr_addr[0]        ),
                .instr_r_rdata_i     (  instr_r_rdata[0]     ),
                .instr_r_valid_i     (  instr_r_valid[0]     ),

                //----- DEBUG UNIT I$ BIND -----------------//
                .dbginf_stall_i      (  '0      ),
                .dbginf_bp_o         (          ),
                .dbginf_strobe_i     (  '0     ),
                .dbginf_ack_o        (         ),
                .dbginf_we_i         (  '0         ),
                .dbginf_addr_i       (  '0       ),
                .dbginf_data_i       (  '0      ),
                .dbginf_data_o       (        ),

                // Interfaces to TCDM interco, DMA ctrl unit, PERIP interco
                .tcdm_data_master   (  s_core_bram_bus   ),
                .dma_ctrl_master    (  s_core_dmactrl_bus[0] ),
                .eu_ctrl_master     (  s_core_euctrl_bus[0]  ),
                .periph_data_master (  s_core_periph_bus[0]  )

                // Execution traces (FPGA only)
`ifdef TRACE_EXECUTION
                ,
                .instr_trace_cycles_o ( instr_trace_cycles_o[((i+1)*64)-1:i*64] ),
                .instr_trace_instr_o  ( instr_trace_instr_o [((i+1)*32)-1:i*32] ),
                .instr_trace_pc_o     ( instr_trace_pc_o    [((i+1)*32)-1:i*32] ),
                .instr_trace_valid_o  ( instr_trace_valid_o [0]                 )
`endif
              );
        
   
   
   genvar iii;
   
   generate
      for (genvar iii=NB_CORES; iii<4; iii++) begin
        assign s_core_dmactrl_bus[iii].req   = '0;
        assign s_core_dmactrl_bus[iii].add   = '0;
        assign s_core_dmactrl_bus[iii].wen   = '0;
        assign s_core_dmactrl_bus[iii].wdata = '0;
        assign s_core_dmactrl_bus[iii].be    = '0;
      end
  endgenerate







  /*
  
██╗  ██╗██╗    ██╗ ██████╗███████╗       ██╗       ██████╗ ███╗   ███╗ █████╗ 
██║  ██║██║    ██║██╔════╝██╔════╝       ██║       ██╔══██╗████╗ ████║██╔══██╗
███████║██║ █╗ ██║██║     █████╗      ████████╗    ██║  ██║██╔████╔██║███████║
██╔══██║██║███╗██║██║     ██╔══╝      ██╔═██╔═╝    ██║  ██║██║╚██╔╝██║██╔══██║
██║  ██║╚███╔███╔╝╚██████╗███████╗    ██████║      ██████╔╝██║ ╚═╝ ██║██║  ██║
╚═╝  ╚═╝ ╚══╝╚══╝  ╚═════╝╚══════╝    ╚═════╝      ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝
                                                                              
*/
XBAR_TCDM_BUS_64BIT    weights_mem_bus[2-1:0]();

dmac_per_wrap
    #(
        .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH   ),
        .AXI_DATA_WIDTH ( AXI_DATA_WIDTH   ),
        .AXI_ID_WIDTH_CNTR   ( AXI_ID_WIDTH     ),
        .AXI_ID_WIDTH_EXT   ( AXI_TO_PS_ID_WIDTH     ),
        .AXI_USER_WIDTH ( AXI_USER_WIDTH   ),
        .WEI_MEM_BANK_SIZE( WEI_MEM_BANK_SIZE  ),

        //main CLuster paramters
        .MEM_ADD_WIDTH  ( WEI_MEM_ADDR_WIDTH   ), 
        .DATA_WIDTH     ( DATA_WIDTH       ),
        .ADDR_WIDTH     ( ADDR_WIDTH       ),
        .BE_WIDTH       ( BE_WIDTH              ),
        .BUFFER_WIDTH   ( DC_SLICE_BUFFER_WIDTH )
    )
    dmac_wei_wrap_i
    (
        .clk_dma_i      ( clk_wmem_i            ),
        .clk_axi_i      ( s_clk_soc               ),
        .rst_ni         ( s_rst_n               ),
              
        .ctrl_slave     ( wei_dma_cntr_master   ),

        .mem_master     ( weights_mem_bus       ),

        .ext_master     ( wei2ddr_bus        )
    );



    assign weights_mem_bus[0].gnt = '0;
    assign weights_mem_bus[0].r_valid = '0;
    assign weights_mem_bus[0].r_rdata = '0;









  //**********************************************
  //*************** HW ACCELERATOR ***************

  hwce_wrap
   #(
      .N_MASTER_PORT     ( HWCE_PORTS           ), 
      .BANK_SIZE         ( BANK_SIZE_32BIT      ),
      .WEI_MEM_BANK_SIZE ( WEI_MEM_BANK_SIZE    ),
      .ID_WIDTH          ( NB_CORES+NB_MPERIPHS ),
      .N_ROW             ( N_ROW                ),
      .N_COL             ( N_COL                ),
      .NPF               ( NPF                  ),
      .CONV_WIDTH        ( CONV_WIDTH           )
   )
   hwce_wrap_i
   (
      .clk_i            ( s_clk_soc                                     ),
      .clk_fast_i       ( s_clk_fast                                    ),
      .clk_wmem_i       ( clk_wmem_i                     ),
      .rst_n            ( s_rst_n                                       ),
      .test_mode        ( test_mode_i                                   ),
      .hwacc_xbar_master( s_hwce_xbar_bport_bus [HWCE_PORTS-1:0] ), //3*4+2*4=20
      .hwacc_cfg_slave  ( s_hwacc_cfg_bus                               ),
      .weights_mem_bus  ( weights_mem_bus [1:1]),
      .evt_interrupt_o  ( hwacc_evt_interrupt[0]                        )
    );

  genvar ii, kk;  /*
  generate
 

  for (kk=HWCE_PORTS; kk<N_BPORTS; kk++)  // binding to ground unsed bport bus.
  begin
    assign s_hwce_xbar_bport_bus[kk].req   = 1'b0;
    assign s_hwce_xbar_bport_bus[kk].add   = 32'b0;
    assign s_hwce_xbar_bport_bus[kk].wen   = 1'b1;
    assign s_hwce_xbar_bport_bus[kk].be    = 4'b0;
    assign s_hwce_xbar_bport_bus[kk].wdata = 32'b0;
  end
  endgenerate
  */
  //assign s_hwce_xbar_bport_bus[3].req   = '0;
  //assign s_hwce_xbar_bport_bus[3].add   = '0;
  //assign s_hwce_xbar_bport_bus[3].wen   = '0;
  //assign s_hwce_xbar_bport_bus[3].be    = '0;
  //assign s_hwce_xbar_bport_bus[3].wdata = '0;

  assign hwacc_evt_interrupt[3:1] = 4'b0;







/*


████████╗ ██████╗██████╗ ███╗   ███╗
╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
   ██║   ██║     ██║  ██║██╔████╔██║
   ██║   ██║     ██║  ██║██║╚██╔╝██║
   ██║   ╚██████╗██████╔╝██║ ╚═╝ ██║
   ╚═╝    ╚═════╝╚═════╝ ╚═╝     ╚═╝
                                    
*/
   tcdm_dp_banks_asym
   #(
       .BANK_SIZE   ( BANK_SIZE_64BIT       ),
       .NB_BANKS    ( NB_TCDM_BANKS         )
   )
   tcdm_sram_island
   (
      .clk_a_i      ( s_clk_soc             ),
      .clk_b_i      ( s_clk_fast            ),
      .rst_ni       ( s_rst_n               ),
      
      .tcdm_slave   ( s_tcdm_bus_sram       ),
      .tcdm_slave_b ( s_tcdm_bus_sram_bport )
   );


    generate
        for(i=0;i<8;i++)
        begin :  edge_propagator_rx_i
            edge_propagator_rx       edge_propagator_rx_i
            (
                .clk_i   (s_clk_soc                 ),
                .rstn_i  (s_rst_n                   ),
                .valid_i (s_soc_events_val[i]       ),
                .ack_o   (s_soc_events_ack[i]       ),
                .valid_o (ext_events_int[i]         )
            );
        end
    endgenerate



 



   //********************************************************
   //*************** AXI ID REMAP SOC <-> PS ****************
   //********************************************************

   axi_id_remap_wrap
     #(
       .AXI_ADDR_WIDTH   ( AXI_ADDR_WIDTH ),
       .AXI_DATA_WIDTH   ( AXI_DATA_WIDTH ),
       .AXI_ID_WIDTH     ( AXI_ID_WIDTH   ),
       .AXI_USER_WIDTH   ( AXI_USER_WIDTH ),
       .AXI_ID_IN_WIDTH  ( AXI_ID_WIDTH           ),
       .AXI_ID_OUT_WIDTH ( AXI_TO_PS_ID_WIDTH    ),
       .AXI_ID_SLOT      ( 16                     )
       )
   to_ps_id_remap_wrap_i
     (
      .clk_i             ( s_clk_soc              ),
      .rst_ni            ( s_rstn_sync            ),

      .axi_slave         ( to_ps_bus_pre_id_remap ),

      .axi_master        ( to_ps_bus              )
      );


   //********************************************************
   //********** AXI ID REMAP SOC <-> PS STDOUT **************
   //********************************************************

   axi_id_remap_wrap
     #(
       .AXI_ADDR_WIDTH   (AXI_ADDR_WIDTH),
       .AXI_DATA_WIDTH   (AXI_DATA_WIDTH),
       .AXI_ID_WIDTH     (AXI_ID_WIDTH  ),
       .AXI_USER_WIDTH   (AXI_USER_WIDTH),
       .AXI_ID_IN_WIDTH  (AXI_ID_WIDTH  ),
       .AXI_ID_OUT_WIDTH (AXI_TO_PS_ID_WIDTH             ),
       .AXI_ID_SLOT      (16            )
       )
   stdout_id_remap_wrap_i
     (
      .clk_i(s_clk_soc),
      .rst_ni(s_rstn_sync),

      .axi_slave(stdout_master_pre_id_remap),

      .axi_master(stdout_master)
      );





    
    
    //********************************************************
   //****** AXI to UNICAD MEMORY PROTOCOL ADAPTER ***********
   //********************************************************


    
    
    
    assign dummy_axi_if.aw_valid  = 1'b0;
    assign dummy_axi_if.aw_addr   = 'b0;
    assign dummy_axi_if.aw_prot   = 'b0;
    assign dummy_axi_if.aw_region = 'b0;
    assign dummy_axi_if.aw_len    = 'b0;
    assign dummy_axi_if.aw_size   = 'b0;
    assign dummy_axi_if.aw_burst  = 'b0;
    assign dummy_axi_if.aw_lock   = 1'b0;
    assign dummy_axi_if.aw_cache  = 'b0;
    assign dummy_axi_if.aw_qos    = 'b0;
    assign dummy_axi_if.aw_id     = 'b0;
    assign dummy_axi_if.aw_user   = 'b0;
    //assign dummy_axi_if.aw_ready  = 'b0;

    assign dummy_axi_if.ar_valid  = 1'b0;
    assign dummy_axi_if.ar_addr   = 'b0;
    assign dummy_axi_if.ar_prot   = 'b0;
    assign dummy_axi_if.ar_region = 'b0;
    assign dummy_axi_if.ar_len    = 'b0;
    assign dummy_axi_if.ar_size   = 'b0;
    assign dummy_axi_if.ar_burst  = 'b0;
    assign dummy_axi_if.ar_lock   = 1'b0;
    assign dummy_axi_if.ar_cache  = 'b0;
    assign dummy_axi_if.ar_qos    = 'b0;
    assign dummy_axi_if.ar_id     = 'b0;
    assign dummy_axi_if.ar_user   = 'b0;
    //assign dummy_axi_if.ar_ready  = 'b0;
    
    // assign dummy_axi_if.r_valid   = 'b0;
    // assign dummy_axi_if.r_data    = 'b0;
    // assign dummy_axi_if.r_resp    = 'b0;
    // assign dummy_axi_if.r_last    = 'b0;
    // assign dummy_axi_if.r_id      = 'b0;
    // assign dummy_axi_if.r_user    = 'b0;
    assign dummy_axi_if.r_ready   = 1'b0;
    
    assign dummy_axi_if.w_valid   = 1'b0;
    assign dummy_axi_if.w_data    = 'b0;
    assign dummy_axi_if.w_strb    = 'b0;
    assign dummy_axi_if.w_last    = 1'b0;
    assign dummy_axi_if.w_user    = 'b0;
    //assign dummy_axi_if.w_ready   = 'b0;
    
    // assign dummy_axi_if.b_valid   = 'b0;
    // assign dummy_axi_if.b_resp    = 'b0;
    // assign dummy_axi_if.b_id      = 'b0;
    // assign dummy_axi_if.b_user    = 'b0;
    assign dummy_axi_if.b_ready   = 1'b0;
    
    axi_mem_if_DP_wrap
    #(
        .AXI_ADDRESS_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ID_WIDTH(AXI_ID_WIDTH),
        .AXI_USER_WIDTH(AXI_USER_WIDTH),
        .MEM_ADDR_WIDTH(L2_MEM_ADDR_WIDTH),
        .BUFF_DEPTH_SLAVE(4)
    )
    l2_mem_if_i
    (
        .clk_i        ( s_clk_soc       ),
        .rst_ni       ( s_rstn_sync     ),
        .test_en_i    ( test_mode_i     ),

        .axi_slave_LP(s_soc_l2_bus),
        .axi_slave_HP(dummy_axi_if),

        .mem_master(s_soc_l2_mem)
    );
    
    `ifdef ICACHE
    axi_mem_if_DP_wrap
    #(
        .AXI_ADDRESS_WIDTH(AXI_ADDR_WIDTH),
        .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
        .AXI_ID_WIDTH(AXI_ID_WIDTH),
        .AXI_USER_WIDTH(AXI_USER_WIDTH),
        .MEM_ADDR_WIDTH(L2_MEM_ADDR_WIDTH),
        .BUFF_DEPTH_SLAVE(4)
    )
    l2_mem_bport_if_i
    (
        .clk_i(s_clk_soc),
        .rst_ni(s_rstn_sync),
        .test_en_i(test_mode_i),

        .axi_slave_LP(instr_master),
        .axi_slave_HP(dummy_axi_if_2),

        .mem_master(s_soc_l2_mem_b)
    );
    `endif
    //********************************************************
   //********************* SOC L2 RAM ***********************
   //********************************************************

    l2_ram_dp
    #(
        .MEM_ADDR_WIDTH ( L2_MEM_ADDR_WIDTH ),
        .RM_SIZE        ( RM_SIZE           ),
        .WM_SIZE        ( WM_SIZE           )
    )
    l2_ram_i
    (
        .clk_i          ( s_clk_soc         ),
        .rst_ni         ( s_rstn_sync       ),

        .init_ni        ( s_rstn_sync       ),

        .test_mode_i    ( test_mode_i       ),

        .mem_slave      ( s_soc_l2_mem      ),
`ifdef ICACHE
        .mem_slave_b    ( s_soc_l2_mem_b    ),
`else
        .instr_req      ( instr_req     [0] ),
        .instr_addr     ( instr_addr    [0] ),
        .instr_gnt      ( instr_gnt     [0] ),
        .instr_r_valid  ( instr_r_valid [0] ),
        .instr_r_rdata  ( instr_r_rdata [0] ),        
`endif
        // Read and Write margins
        .rm_l2_mem_i    ( 4'b0              ), //unused in FPGA
        .wm_l2_mem_i    ( 4'b0              ), //unused in FPGA
        .LS_l2_mem_i    ( 1'b1              ), //unused in FPGA
        .HS_l2_mem_i    ( 1'b0              ), //unused in FPGA
        .sleep_l2_mem_i ( 1'b0              )  //unused in FPGA
    );
    
    
    generate
        for(i=0;i<8;i++)
        begin :  edge_propagator_tx_i
            edge_propagator_tx       edge_propagator_tx_i
            (
                .clk_i   (s_clk_soc                 ),
                .rstn_i  (s_rstn_sync               ),
                .valid_i (s_soc_events[i]           ),
                .ack_i   (s_soc_events_ack[i] ),
                .valid_o (s_soc_events_val[i]       )
            );
        end
    endgenerate
    

endmodule