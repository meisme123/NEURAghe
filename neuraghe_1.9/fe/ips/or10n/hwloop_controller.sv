////////////////////////////////////////////////////////////////////////////////
// Company:        IIS @ ETHZ - Federal Institute of Technology               //
//                 DEI @ UNIBO - University of Bologna                        //
//                                                                            //
// Engineer:       Michael Gautschi - gautschi@iis.ee.ethz.ch                 //
//                                                                            //
// Additional contributions by:                                               //
//                                                                            //
//                                                                            //
// Create Date:    08/08/2014                                                 //
// Design Name:    hwloop controller                                          //
// Module Name:    hwloop_controller.sv                                       //
// Project Name:   OR10N                                                      //
// Language:       SystemVerilog                                              //
//                                                                            //
// Description:    Hardware loop controller unit. This unit is responsible to //
//                 handle hardware loops. Tasks are:                          //
//                 a) compare PC to all stored end addresses                  //
//                 b) jump to the right start address if counter =/ 0         //
//                                                                            //
// Revision:                                                                  //
// Revision v0.1 - File Created                                               //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////


`include "defines.sv"

module hwloop_controller
  (

   // from id stage
   input  logic                           enable_i,
   input  logic [31:0]                    current_pc_i,

   // from hwloop_regs
   input  logic [`HWLOOP_REGS-1:0] [31:0] hwloop_start_addr_i,
   input  logic [`HWLOOP_REGS-1:0] [31:0] hwloop_end_addr_i,
   input  logic [`HWLOOP_REGS-1:0] [31:0] hwloop_counter_i,

   // to hwloop_regs
   output logic [`HWLOOP_REGS-1:0]        hwloop_dec_cnt_o,

   // to id stage
   output logic                           hwloop_jump_o,
   output logic [31:0]                    hwloop_targ_addr_o
   );


   logic [`HWLOOP_REGS-1:0] pc_is_end_addr;

   // generate comparators. check for end address and the loop counter
   genvar i;
   for (i = 0; i < `HWLOOP_REGS; i++) begin
     assign pc_is_end_addr[i] = ((current_pc_i == hwloop_end_addr_i[i]) & (enable_i) & (hwloop_counter_i[i] > 32'b1)) ? 1'b1 : 1'b0;
   end

   // output signal for ID stage
   assign hwloop_jump_o = |pc_is_end_addr;

   // select corresponding start address and decrement counter. give highest priority to register 0
   always_comb begin
      hwloop_targ_addr_o = 32'b0;
      hwloop_dec_cnt_o = `HWLOOP_REGS'b0;

      if (pc_is_end_addr[0]) begin
        hwloop_targ_addr_o = hwloop_start_addr_i[0];
        hwloop_dec_cnt_o[0] = 1'b1;
      end
      else if (pc_is_end_addr[1]) begin
        hwloop_targ_addr_o = hwloop_start_addr_i[1];
        hwloop_dec_cnt_o[1] = 1'b1;
      end
/* -----\/----- EXCLUDED -----\/-----
      else if (pc_is_end_addr[2]) begin
        hwloop_targ_addr_o = hwloop_start_addr_i[2];
        hwloop_dec_cnt_o[2] = 1'b1;
      end
      else if (pc_is_end_addr[3]) begin
        hwloop_targ_addr_o = hwloop_start_addr_i[3];
        hwloop_dec_cnt_o[3] = 1'b1;
      end
 -----/\----- EXCLUDED -----/\----- */
   end

endmodule
