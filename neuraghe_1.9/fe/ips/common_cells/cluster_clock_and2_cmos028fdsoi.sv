
module cluster_clock_and2
(
    input  logic clk0_i,
    input  logic clk1_i,
    output logic clk_o
);

   //assign clk_o = clk0_i & clk1_i;

   C8T28SOI_LR_CNAND2X19_P0 ckand2
   (
      .Z(clk_o), 
      .A(clk0_i), 
      .B(clk1_i)
   );
   
endmodule
