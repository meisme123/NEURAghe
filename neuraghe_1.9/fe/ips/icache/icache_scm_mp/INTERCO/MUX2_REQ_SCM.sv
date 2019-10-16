////////////////////////////////////////////////////////////////////////////////
// Company:        Micrel Lab @ DEIS - University of Bologna                  //  
//                    Viale Risorgimento 2 40136                              //
//                    Bologna - fax 0512093785 -                              //
//                                                                            //
// Engineer:       Igor Loi - igor.loi@unibo.it                               //
//                                                                            //
// Additional contributions by:                                               //
//                                                                            //
//                                                                            //
//                                                                            //
// Create Date:    29/06/2011                                                 // 
// Design Name:    LOG_INTERCONNECT                                           // 
// Module Name:    MUX2_REQ                                                   //
// Project Name:   P2012 - ENCORE                                             //
// Language:       SystemVerilog                                              //
//                                                                            //
// Description:    two input multiplxer whith custom ports used to multiplex  //
//                 the datapath request data. It includes an embeddedd        //
//                 Fixed Priory arbiter with max priority to Channel 0 (CH0)  //
//                                                                            //
//                                                                            //
// Revision:                                                                  //
// Revision v0.1 - File Created                                               //
// Revision v0.2 - (19/02/2015) Restyling                                     //
//                                                                            //
// Additional Comments:                                                       //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

module MUX2_REQ_SCM 
#(
    parameter ID_WIDTH   = 20,
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter N_WAYS     = 4
)
(
    input  logic                                 data_req_CH0_i,
    input  logic [ADDR_WIDTH-1:0]                data_add_CH0_i,
    input  logic [DATA_WIDTH-1:0]                data_wdata_CH0_i,
    input  logic [N_WAYS-1:0]                    data_way_CH0_i,
    output logic                                 data_gnt_CH0_o,

    input  logic                                 data_req_CH1_i,
    input  logic [ADDR_WIDTH-1:0]                data_add_CH1_i,
    input  logic [DATA_WIDTH-1:0]                data_wdata_CH1_i,
    input  logic [N_WAYS-1:0]                    data_way_CH1_i,
    output logic                                 data_gnt_CH1_o,


    output  logic                                data_req_o,
    output  logic [ADDR_WIDTH-1:0]               data_add_o,
    output  logic [DATA_WIDTH-1:0]               data_wdata_o,
    output  logic [N_WAYS-1:0]                   data_way_o,
    input   logic                                data_gnt_i,

    input   logic                                clk,
    input   logic                                rst_n
);

    logic                                        SEL; // Mux Selector
    logic                                        RR_FLAG;

    // Request is simply an or between indoming request
    assign data_req_o = data_req_CH0_i | data_req_CH1_i;

      // FIXED PRIORITY ENCODER
    assign SEL                =   ~data_req_CH0_i | ( RR_FLAG & data_req_CH1_i);        // SEL FOR ROUND ROBIN MUX
    assign data_gnt_CH0_o     =    (( data_req_CH0_i & ~data_req_CH1_i) | ( data_req_CH0_i & ~RR_FLAG)) & data_gnt_i;
    assign data_gnt_CH1_o     =    ((~data_req_CH0_i &  data_req_CH1_i) | ( data_req_CH1_i &  RR_FLAG)) & data_gnt_i;

    assign RR_FLAG = 1'b1;  // max priority on CH1 for FLUSH and ICACHE handling

    // always_ff @(posedge clk, negedge rst_n)
    // begin
    //   if(rst_n == 1'b0)
    //       RR_FLAG <= 1'b0;
    //   else if((data_req_o == 1'b1) && (data_gnt_i == 1'b1))
    //           RR_FLAG <= ~RR_FLAG;
    // end

    always_comb
    begin : MUX2_REQ_COMB
      case(SEL) // synopsys full_case
      1'b0: begin
            data_add_o   = data_add_CH0_i;
            data_wdata_o = data_wdata_CH0_i;
            data_way_o   = data_way_CH0_i;
          end
      1'b1:
          begin
            data_add_o   = data_add_CH1_i;
            data_wdata_o = data_wdata_CH1_i;
            data_way_o   = data_way_CH1_i;
          end
      endcase
    end
endmodule