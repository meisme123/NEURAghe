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
// Create Date:    02/07/2011                                                 // 
// Design Name:    LOG_INTERCONNECT                                           // 
// Module Name:    ResponseTree_PE                                            //
// Project Name:   P2012 - ENCORE                                             //
// Language:       SystemVerilog                                              //
//                                                                            //
// Description:    Peripheral Response tree: This block performs the Routing  //
//                 between N_SLAVE requests. There is no arbitration in this  //
//                 block. Since there is no chanche of request collision on   //
//                 same master. Response latencies are deterministic therefore//
//                 the response arrive always in the same order they are sent.//
//                                                                            //
// Revision:                                                                  //
// Revision v0.1 02/07/2011  - File Created                                   //
// 	    v0.2 15/08/2012  - Improved the Interface Structure,              //
//                             Changed the routing mechanism                  //
// Additional Comments:                                                       //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

`include "parameters.v"


module ResponseTree_PE 
#(
    parameter N_SLAVE     = 16,
    parameter DATA_WIDTH  = 32
) 
(
    // Response Input Channel 0
    input logic [N_SLAVE-1:0] 			data_r_valid_i,
    input logic [N_SLAVE-1:0][DATA_WIDTH-1:0]	data_r_rdata_i,
    input logic [N_SLAVE-1:0]			data_r_opc_i,
    // Response Output Channel
    output logic 					data_r_valid_o,
    output logic [DATA_WIDTH-1:0]			data_r_rdata_o,
    output logic 					data_r_opc_o
);

    localparam LOG_SLAVE 	= `log2(N_SLAVE-1); //N_SLAVE=8-> 3; N_SLAVE>8-> 4 
    localparam N_WIRE     	=  N_SLAVE - 2;

    genvar j,k;

    generate
      if(N_SLAVE == 2)
	begin : INCR // START of  N_SLAVE  == 2
		    // ---------------- FAN IN PRIMITIVE RESP -------------------------
		    FanInPrimitive_PE_Resp 
		    #(
                        .DATA_WIDTH(DATA_WIDTH)
		    )
		    i_FanInPrimitive_PE_Resp
		    (
			// RIGTH SIDE
			.data_r_rdata0_i(data_r_rdata_i[0]),
			.data_r_rdata1_i(data_r_rdata_i[1]),
			.data_r_valid0_i(data_r_valid_i[0]),
			.data_r_valid1_i(data_r_valid_i[1]),
			.data_r_opc0_i(data_r_opc_i[0]),
			.data_r_opc1_i(data_r_opc_i[1]),
			// LEFT SIDE
			.data_r_rdata_o(data_r_rdata_o),
			.data_r_valid_o(data_r_valid_o),
			.data_r_opc_o(data_r_opc_o)
		    );
	end // END OF N_SLAVE  == 2
      else // More than two master
	begin : BINARY_TREE
	    //// ---------------------------------------------------------------------- ////
	    //// -------               REQ ARBITRATION TREE WIRES           ----------- ////
	    //// ---------------------------------------------------------------------- ////	
	    logic [DATA_WIDTH-1:0]  		data_r_rdata_LEVEL[N_WIRE-1:0];
	    logic				data_r_valid_LEVEL[N_WIRE-1:0];
	    logic				data_r_opc_LEVEL[N_WIRE-1:0];
	  
 	      for(j=0; j < LOG_SLAVE; j++) // Iteration for the number of the stages minus one
		begin : STAGE
		  for(k=0; k<2**j; k=k+1) // Iteration needed to create the binary tree
		    begin : INCR_VERT
		    
		      if (j == 0 )  // LAST NODE, drives the module outputs
		      begin : LAST_NODE
			  FanInPrimitive_PE_Resp 
                          #(
                              .DATA_WIDTH(DATA_WIDTH)
                          )
                          i_FanInPrimitive_PE_Resp
                          (
			  // RIGTH SIDE
			  .data_r_rdata0_i(data_r_rdata_LEVEL[2*k]),
			  .data_r_rdata1_i(data_r_rdata_LEVEL[2*k+1]),
			  .data_r_valid0_i(data_r_valid_LEVEL[2*k]),
			  .data_r_valid1_i(data_r_valid_LEVEL[2*k+1]),
			  .data_r_opc0_i(data_r_opc_LEVEL[2*k]),
			  .data_r_opc1_i(data_r_opc_LEVEL[2*k+1]),			  
			  // RIGTH SIDE
			  .data_r_rdata_o(data_r_rdata_o),
			  .data_r_valid_o(data_r_valid_o),
			  .data_r_opc_o(data_r_opc_o)
			  );
		      end 
		      else if ( j < LOG_SLAVE - 1) // Middle Nodes
			      begin : MIDDLE_NODES // START of MIDDLE LEVELS Nodes   
                                  FanInPrimitive_PE_Resp 
                                  #(
                                      .DATA_WIDTH(DATA_WIDTH)
                                  )
                                  i_FanInPrimitive_PE_Resp
                                  (
				  // RIGTH SIDE				  
				  .data_r_rdata0_i(data_r_rdata_LEVEL[((2**j)*2-2) + 2*k]),
				  .data_r_rdata1_i(data_r_rdata_LEVEL[((2**j)*2-2) + 2*k +1]),
				  .data_r_valid0_i(data_r_valid_LEVEL[((2**j)*2-2) + 2*k]),
				  .data_r_valid1_i(data_r_valid_LEVEL[((2**j)*2-2) + 2*k+1]),
				  .data_r_opc0_i(data_r_opc_LEVEL[((2**j)*2-2) + 2*k]),
				  .data_r_opc1_i(data_r_opc_LEVEL[((2**j)*2-2) + 2*k+1]),			  				  
				  // LEFT SIDE
				  .data_r_rdata_o(data_r_rdata_LEVEL[((2**(j-1))*2-2) + k]),
				  .data_r_valid_o(data_r_valid_LEVEL[((2**(j-1))*2-2) + k]),
				  .data_r_opc_o(data_r_opc_LEVEL[((2**(j-1))*2-2) + k])
				  );
			      end  // END of MIDDLE LEVELS Nodes   
			   else // First stage (connected with the Main inputs ) --> ( j == N_SLAVE - 1 )
			      begin : LEAF_NODES  // START of FIRST LEVEL Nodes (LEAF)
				  FanInPrimitive_PE_Resp 
                                  #(
                                      .DATA_WIDTH(DATA_WIDTH)
                                  )
                                  i_FanInPrimitive_PE_Resp
                                  (
				  // RIGTH SIDE	
				  .data_r_rdata0_i(data_r_rdata_i[2*k]),
				  .data_r_rdata1_i(data_r_rdata_i[2*k+1]),
				  .data_r_valid0_i(data_r_valid_i[2*k]),
				  .data_r_valid1_i(data_r_valid_i[2*k+1]),
				  .data_r_opc0_i(data_r_opc_i[2*k]),
				  .data_r_opc1_i(data_r_opc_i[2*k+1]),  
				  // LEFT SIDE
				  .data_r_rdata_o(data_r_rdata_LEVEL[((2**(j-1))*2-2) + k]),
				  .data_r_valid_o(data_r_valid_LEVEL[((2**(j-1))*2-2) + k]),
				  .data_r_opc_o(data_r_opc_LEVEL[((2**(j-1))*2-2) + k])
				  );
			      end // End of FIRST LEVEL Nodes (LEAF)
		    end
		  
		end
    end
    endgenerate


endmodule
