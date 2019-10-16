/******************************************************************************
 *                                                                            *
 *          ERC Multitherman Lab @ DEI - University of Bologna                *
 *                      Viale Pepoli 3/2 - 40136                              *
 *                     Bologna - phone 0512092759                             *
 *                                                                            *
 * Engineer:       Igor Loi - igor.loi@unibo.it                               *
 *                 Francesco Conti - f.conti@unibo.it                         *
 *                                                                            *
 * Project:        Shared-memory HWPE wrapper                                 *
 * File:           hwpe_axi_sink.sv                                           *
 * Description:    Sink module for the AXI-Stream HWPE wrapper                *
 *                                                                            *
 ******************************************************************************/

`include "hwpe_sm_params.sv"
`include "hwpe_axi_params.sv"

module hwpe_axi_sink
#(
  // Cluster interface params
  parameter CLUS_ADDR_WIDTH   = 32,
  parameter CLUS_DATA_WIDTH   = 32,
  parameter CLUS_BE_WIDTH     = CLUS_DATA_WIDTH/8,
  // Stream interface params
  parameter STREAM_DATA_SIZE  = `STREAM_DATA_SIZE,
  parameter STREAM_BE_SIZE    = `STREAM_BE_SIZE,
  parameter STREAM_TID_SIZE   = `STREAM_TID_SIZE,
  parameter STREAM_TDEST_SIZE = `STREAM_TDEST_SIZE,
  parameter STREAM_TUSER_SIZE = `STREAM_TUSER_SIZE,
  // Sink params
  parameter FIFO_DEPTH        = 16,
  parameter WORD_STRIDE       = 2,
  parameter N_SINK_STREAMS    = 4,
  // Latch-based implementation
  parameter LATCH_FIFO        = 0,
  parameter NPX               = 4
)
(
  input logic clk,
  input logic rst_n,

  // LINT side
  output logic [N_SINK_STREAMS-1:0][NPX-1:0]                      tcdm_req_o,
  input  logic [N_SINK_STREAMS-1:0][NPX-1:0]                      tcdm_gnt_i,
  output logic [N_SINK_STREAMS-1:0][NPX-1:0][CLUS_ADDR_WIDTH-1:0] tcdm_add_o,
  output logic [N_SINK_STREAMS-1:0][NPX-1:0]                      tcdm_type_o,
  output logic [N_SINK_STREAMS-1:0][NPX-1:0][CLUS_BE_WIDTH-1:0]   tcdm_be_o,
  output logic [N_SINK_STREAMS-1:0][NPX-1:0][CLUS_DATA_WIDTH-1:0] tcdm_data_o,
  input  logic [N_SINK_STREAMS-1:0][NPX-1:0][CLUS_DATA_WIDTH-1:0] tcdm_r_data_i,
  input  logic [N_SINK_STREAMS-1:0][NPX-1:0]                      tcdm_r_valid_i,

  // AXI HWPE side
  input  logic [N_SINK_STREAMS-1:0]                        TVALID_i,
  output logic [N_SINK_STREAMS-1:0]                        TREADY_o,
  input  logic [N_SINK_STREAMS-1:0][NPX-1:0][STREAM_DATA_SIZE -1:0] TDATA_i,
  input  logic [N_SINK_STREAMS-1:0][STREAM_BE_SIZE   -1:0] TSTRB_i,
  input  logic [N_SINK_STREAMS-1:0][STREAM_BE_SIZE   -1:0] TKEEP_i,
  input  logic [N_SINK_STREAMS-1:0]                        TLAST_i,
  input  logic [N_SINK_STREAMS-1:0][STREAM_TID_SIZE  -1:0] TID_i,
  input  logic [N_SINK_STREAMS-1:0][STREAM_TDEST_SIZE-1:0] TDEST_i,
  input  logic [N_SINK_STREAMS-1:0][STREAM_TUSER_SIZE-1:0] TUSER_i,

  // From CFG regs
  input  stream_config_t[N_SINK_STREAMS-1:0]               stream_config_i,
  output stream_flags_t[N_SINK_STREAMS-1:0]                stream_flags_o,

  // Control signals
  input  logic[N_SINK_STREAMS-1:0]                         req_start_sink_i,
  output logic[N_SINK_STREAMS-1:0]                         ready_start_sink_o,
  output logic[N_SINK_STREAMS-1:0]                         done_sink_o,
  output  logic                  change_feat_o,
  output  logic [7:0]                 n_og_o
);

  enum logic [1:0]  {IDLE, SINK, DONE}      cs, ns;

  logic [N_SINK_STREAMS-1:0]                      tcdm_req_int;
  logic [N_SINK_STREAMS-1:0][CLUS_ADDR_WIDTH-1:0] tcdm_add_int;
  logic [N_SINK_STREAMS-1:0]                      tcdm_type_int;
  logic [N_SINK_STREAMS-1:0][CLUS_BE_WIDTH-1:0]   tcdm_be_int;
  logic [N_SINK_STREAMS-1:0][NPX-1:0][CLUS_DATA_WIDTH-1:0] tcdm_data_int;

  logic [N_SINK_STREAMS-1:0][CLUS_ADDR_WIDTH-1:0] gen_addr;
  logic [N_SINK_STREAMS-1:0] in_progress;

  logic [N_SINK_STREAMS-1:0] FIFO_GNT_push;
  logic [N_SINK_STREAMS-1:0] address_gen_en;
  logic [N_SINK_STREAMS-1:0] done_sink_int;
    
  stream_flags_t stream_flags_o_p;
  
/*
  hwpe_axi_fifo #(
    .DATA_WIDTH(CLUS_DATA_WIDTH + CLUS_BE_WIDTH  + 1 + CLUS_ADDR_WIDTH),
    .DATA_DEPTH(FIFO_DEPTH),
    .LATCH_FIFO(LATCH_FIFO)
  ) sink_fifo_i (
    .clk      (clk),
    .rst_n    (rst_n),

    .data_in  (  {tcdm_data_int, tcdm_be_int, tcdm_type_int, tcdm_add_int}),
    .valid_in (   tcdm_req_int  ),
    .grant_out(  FIFO_GNT_push ),

    .data_out ( {tcdm_data_o, tcdm_be_o, tcdm_type_o, tcdm_add_o} ),
    .valid_out( tcdm_req_o ),
    .grant_in (  tcdm_gnt_i)
  );
  */
  /*
  assign tcdm_req_o = tcdm_req_int;
  assign {tcdm_data_o, tcdm_be_o, tcdm_type_o, tcdm_add_o} = {tcdm_data_int, tcdm_be_int, tcdm_type_int, tcdm_add_int};
  assign FIFO_GNT_push = (tcdm_req_o == 1'b1) ? tcdm_gnt_i : 1'b1;
  */
  
  assign tcdm_data_o = tcdm_data_int;
   
  //difficile da fare parametrizzato
  //più veloce in questo modo
  

  logic [N_SINK_STREAMS-1:0] address_gen_inc;
  assign address_gen_inc = TVALID_i & FIFO_GNT_push;
  
  genvar i,j;
  generate
  for(i=0;i<N_SINK_STREAMS; i++)begin
    assign stream_flags_o[i]=stream_flags_o_p;
    assign FIFO_GNT_push[i] = (&tcdm_req_o[i][0]) ? tcdm_gnt_i[i][0] : 1'b1;
    
    for(j=0; j<NPX; j++)begin
      assign tcdm_req_o[i][j]  = tcdm_req_int[i];
      assign tcdm_be_o[i][j]   = tcdm_be_int[i];
      assign tcdm_type_o[i][j] = tcdm_type_int[i];
      assign tcdm_add_o[i][j]  = tcdm_add_int[i];
    end
  end
  endgenerate
  

  hwpe_axi_addressgen_sink #(
    .WORD_STRIDE (WORD_STRIDE),
    .N_SINK_STREAMS(N_SINK_STREAMS),
    .NPX    (NPX)
  ) addressgen_sink_i (
    .clk               (clk            ),
    .rst_n             (rst_n          ),
    .en                (address_gen_en ),
    .address_gen_inc_i (address_gen_inc),
    .stream_config_i   (stream_config_i),
    .gen_addr_o        (gen_addr       ),
    .in_progress_o     (in_progress_o    ),
    .stream_flags_o_p    (stream_flags_o_p ),
    .change_feat    (change_feat_o )//,
   // .n_og_o            (n_og_o          )
  );
  
  assign in_progress = {N_SINK_STREAMS{in_progress_o}};

  always_ff @(posedge clk, negedge rst_n)
  begin : fsm_seq
    if(rst_n == 1'b0) begin
      cs <= IDLE;
    end
    else begin
      cs <= ns;
    end
  end

  always_ff @(posedge clk or negedge rst_n)
  begin : done_sink_ff
    if(rst_n == 1'b0)
      done_sink_o <= {N_SINK_STREAMS{1'b0}};
    else
      done_sink_o <= done_sink_int;
  end

  always_comb
  begin : fsm_comb
    tcdm_req_int       = {N_SINK_STREAMS{1'b0}};
    tcdm_type_int      = {N_SINK_STREAMS{`LOAD}};
    tcdm_add_int       = {N_SINK_STREAMS{'0}};
    tcdm_data_int      = {N_SINK_STREAMS*NPX{'0}};
    tcdm_be_int        = {N_SINK_STREAMS{'0}};
    done_sink_int      = {N_SINK_STREAMS{1'b0}};
    ready_start_sink_o = {N_SINK_STREAMS{1'b0}};
    TREADY_o           = {N_SINK_STREAMS{1'b0}};
    address_gen_en     = {N_SINK_STREAMS{1'b0}};
    case(cs)
      IDLE : begin
        ready_start_sink_o = {N_SINK_STREAMS{1'b1}};
        if(req_start_sink_i) begin
          ns = SINK;
          address_gen_en = {N_SINK_STREAMS{1'b1}};
        end
        else begin
          ns = IDLE;
          address_gen_en = {N_SINK_STREAMS{1'b0}};
        end
      end
      SINK : begin
        if(FIFO_GNT_push)
          TREADY_o  = {N_SINK_STREAMS{1'b1}};
        else
          TREADY_o  = {N_SINK_STREAMS{1'b0}};
        tcdm_req_int  = TVALID_i;
        tcdm_data_int = TDATA_i;
        tcdm_be_int   = {4{TKEEP_i & TSTRB_i}};
        tcdm_add_int  = gen_addr;
        tcdm_type_int = TVALID_i ? {N_SINK_STREAMS{`STORE}}:{N_SINK_STREAMS{`LOAD}}; ;
        if(address_gen_inc == {N_SINK_STREAMS{1'b1}}) begin
          if(in_progress == {N_SINK_STREAMS{1'b1}}) begin
            ns = SINK;
            address_gen_en = {N_SINK_STREAMS{1'b1}};
          end
          else begin
            ns = IDLE;
            done_sink_int = {N_SINK_STREAMS{1'b1}};
            address_gen_en = {N_SINK_STREAMS{1'b0}};
          end
        end
        else begin
          ns = SINK;
          address_gen_en = {N_SINK_STREAMS{1'b1}};
        end
      end
      default : begin
        ns = IDLE;
        address_gen_en = {N_SINK_STREAMS{1'b0}};
      end
    endcase
  end

endmodule
