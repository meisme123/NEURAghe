module per2axi_r_buffer
  #(
    parameter ID_WIDTH = 4,
    parameter DATA_WIDTH = 64,
    parameter USER_WIDTH = 6,
    parameter STRB_WIDTH = DATA_WIDTH/8   // DO NOT OVERRIDE
    )
  (
   
   input logic                   clk_i,
   input logic                   rst_ni,
   
   input logic                   slave_valid_i,
   input logic  [DATA_WIDTH-1:0] slave_data_i,
   input logic  [1:0]            slave_resp_i,
   input logic  [USER_WIDTH-1:0] slave_user_i,
   input logic  [ID_WIDTH-1:0]   slave_id_i,
   input logic                   slave_last_i,
   output logic                  slave_ready_o,
   
   output logic                  master_valid_o,
   output logic [DATA_WIDTH-1:0] master_data_o,
   output logic [1:0]            master_resp_o,
   output logic [USER_WIDTH-1:0] master_user_o,
   output logic [ID_WIDTH-1:0]   master_id_o,
   output logic                  master_last_o,
   input  logic                  master_ready_i
   
   );
   
   logic [2+DATA_WIDTH+USER_WIDTH+ID_WIDTH:0] s_data_in;
   logic [2+DATA_WIDTH+USER_WIDTH+ID_WIDTH:0] s_data_out;
   
   assign s_data_in =  {slave_id_i,  slave_user_i,  slave_data_i,  slave_resp_i,  slave_last_i};
   assign              {master_id_o, master_user_o, master_data_o, master_resp_o, master_last_o} = s_data_out;
   
   per2axi_buffer
     #(
       .DATA_WIDTH(3+DATA_WIDTH+USER_WIDTH+ID_WIDTH)
       )
   buffer_i
     (
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .valid_o(master_valid_o),
      .data_o(s_data_out),
      .ready_i(master_ready_i),
      .valid_i(slave_valid_i),
      .data_i(s_data_in),
      .ready_o(slave_ready_o)
      );
   
endmodule