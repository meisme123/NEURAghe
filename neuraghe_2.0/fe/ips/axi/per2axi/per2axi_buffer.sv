`include "per2axi_parameters.sv"

module per2axi_buffer
  #(
    parameter DATA_WIDTH = 32,
    parameter BUFFER_DEPTH = 2,
    parameter LOG_BUFFER_DEPTH = `log2(BUFFER_DEPTH)
    )
   (
    input  logic	            clk_i,
    input  logic                    rst_ni,
    
    output logic [DATA_WIDTH-1 : 0] data_o,
    output logic                    valid_o,
    input  logic                    ready_i,
    
    input  logic                    valid_i,
    input  logic [DATA_WIDTH-1 : 0] data_i,
    output logic                    ready_o
    );
   
   // Internal data structures
   logic [LOG_BUFFER_DEPTH-1:0]     pointer_in;  // location to which we last wrote
   logic [LOG_BUFFER_DEPTH-1:0]     pointer_out; // location from which we last sent
   logic [LOG_BUFFER_DEPTH:0] 	    elements;    // number of elements in the buffer
   logic [DATA_WIDTH-1:0] 	    buffer [BUFFER_DEPTH - 1 : 0];
   
   wire 			    full;
   
   integer 			    loop1;
   
   assign full = (elements == BUFFER_DEPTH);
   
   always @(posedge clk_i or negedge rst_ni)
     begin: elements_sequential
        if (rst_ni == 1'b0)
          elements <= 0;
        else
          begin
             // ------------------
             // Are we filling up?
             // ------------------
             // One out, none in
             if (ready_i && valid_o && (!valid_i || full))
               elements <= elements - 1;
             // None out, one in
             else if ((!valid_o || !ready_i) && valid_i && !full)
               elements <= elements + 1;
             // Else, either one out and one in, or none out and none in - stays unchanged
          end
     end
   
   always @(posedge clk_i or negedge rst_ni)
     begin: buffers_sequential
        if (rst_ni == 1'b0)
          begin
             for (loop1 = 0 ; loop1 < BUFFER_DEPTH ; loop1 = loop1 + 1)
               buffer[loop1] <= 0;
          end
        else
        begin
           // Update the memory
           if (valid_i && !full)
             buffer[pointer_in] <= data_i;
        end
     end
   
   always @(posedge clk_i or negedge rst_ni)
     begin: sequential
        if (rst_ni == 1'b0)
          begin
             pointer_out <= 0;
             pointer_in  <= 0;
          end
        else
          begin
             // ------------------------------------
             // Check what to do with the input side
             // ------------------------------------
             // We have some input, increase by 1 the input pointer
             if (valid_i && !full)
               begin
		  if (pointer_in == $unsigned(BUFFER_DEPTH - 1))
		    pointer_in <= 0;
		  else
		    pointer_in <= pointer_in + 1;
               end
             // Else we don't have any input, the input pointer stays the same
	     
             // -------------------------------------
             // Check what to do with the output side
             // -------------------------------------
             // We had pushed one flit out, we can try to go for the next one
             if (ready_i && valid_o)
               begin
		  if (pointer_out == $unsigned(BUFFER_DEPTH - 1))
		    pointer_out <= 0;
		  else
		    pointer_out <= pointer_out + 1;
               end
             // Else stay on the same output location
          end
     end
   
   // Update output ports
   assign data_o  = buffer[pointer_out];
   assign valid_o = (elements != 0);
   
   assign ready_o = ~full;
   
endmodule
