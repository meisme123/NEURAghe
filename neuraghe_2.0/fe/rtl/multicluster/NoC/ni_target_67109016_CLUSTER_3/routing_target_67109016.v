///////////////////////////////////////////////////////////////////////////////
// Copyright 2009 iNoCs                                                      //
//                                                                           //
// name         /home/chester/Desktop/prj/XPIPES_fresh/inocs/flow/rtl/verilog/ni_target_67109016_CLUSTER_3/routing_target_67109016.v                                     //
// author       Federico Angiolini - angiolini@inocs.com                     //
// author       Antonio Pullini - pullini@inocs.com                          //
// info         Routing tables for NI targets.  //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
//                    Automatically generated - don't edit                   //
//           File generated for topology: noc18_4sw_80bits_run0           //
///////////////////////////////////////////////////////////////////////////////

`include "noc_parameters.v"

// Route encoding: first hop in the LSBs, last hop in the MSBs
module routing_target_67109016(lut_address, lut_path);

    input [`SOURCEWD - 1 : 0] lut_address;
    output reg [6 : 0] lut_path;

    always @(lut_address)
        begin: compute_route
            case (lut_address) // synopsys parallel_case
                4'h0:
                    lut_path <= 7'b0000000;
                4'h3:
                    lut_path <= 7'b0000001;
                4'h6:
                    lut_path <= 7'b0000010;
                4'hd:
                    lut_path <= 7'b0000011;
                default:
                    lut_path <= 0;
            endcase
        end

endmodule
