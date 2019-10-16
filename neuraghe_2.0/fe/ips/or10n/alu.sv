////////////////////////////////////////////////////////////////////////////////
// Company:        IIS @ ETHZ - Federal Institute of Technology               //
//                                                                            //
// Engineer:       Matthias Baer - baermatt@student.ethz.ch                   //
//                                                                            //
// Additional contributions by:                                               //
//                 Igor Loi - igor.loi@unibo.it                               //
//                 Andreas Traber - atraber@student.ethz.ch                   //
//                                                                            //
//                                                                            //
// Create Date:    19/09/2013                                                 //
// Design Name:    Pipelined Processor                                        //
// Module Name:    alu.sv                                                     //
// Project Name:   Processor                                                  //
// Language:       SystemVerilog                                              //
//                                                                            //
// Description:    Arithmetic logic unit of the pipelined processor           //
//                                                                            //
//                                                                            //
// Revision:                                                                  //
// Revision v0.1 - File Created                                               //
// Revision v0.2 - (August 6th 2014) Changed port and signal names, addedd    //
//                 comments                                                   //
// Revision v0.3 - (December 17 2014) Added vector support                    //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

`include "defines.sv"

module alu
(
   // Inputs of the ALU
   input  logic [`ALU_OP_WIDTH-1:0] operator_i,
   input  logic [31:0]              operand_a_i,
   input  logic [31:0]              operand_b_i,
   input  logic                     carry_i,
   input  logic                     flag_i,
`ifdef TCDM_ADDR_PRECAL
   input logic [31:0]               adder_i,
`endif

   input  logic [1:0]               vector_mode_i,
   input  logic [1:0]               cmp_mode_i,
   input  logic [1:0]               vec_ext_i,

   output logic [31:0]              adder_lsu_o,
   output logic [31:0]              result_o,
   output logic                     overflow_o,
   output logic                     carry_o,
   output logic                     flag_o
);


`ifdef TCDM_ADDR_PRECAL
  assign adder_lsu_o = adder_i;
`else
  assign adder_lsu_o = operand_a_i + operand_b_i;
`endif

  logic [31:0] operand_a_rev;     // bit reversed signal of operand_a_i

  // bit reverse operand_a for left shifts
  genvar       k;
  generate
    for(k = 0; k < 32; k++)
    begin
      assign operand_a_rev[k] = operand_a_i[31-k];
    end
  endgenerate

  //////////////////////////////////////////////////////////////////////////////////////////
  //   ____            _   _ _   _                      _      _       _     _            //
  //  |  _ \ __ _ _ __| |_(_) |_(_) ___  _ __   ___  __| |    / \   __| | __| | ___ _ __  //
  //  | |_) / _` | '__| __| | __| |/ _ \| '_ \ / _ \/ _` |   / _ \ / _` |/ _` |/ _ \ '__| //
  //  |  __/ (_| | |  | |_| | |_| | (_) | | | |  __/ (_| |  / ___ \ (_| | (_| |  __/ |    //
  //  |_|   \__,_|_|   \__|_|\__|_|\___/|_| |_|\___|\__,_| /_/   \_\__,_|\__,_|\___|_|    //
  //                                                                                      //
  //////////////////////////////////////////////////////////////////////////////////////////

  logic [3:0]  carry_in;
  logic [3:0]  carry_out;
  logic [31:0] adder_op_a;
  logic [31:0] adder_op_b;
  logic [31:0] adder_result;

  // prepare operand a
  assign adder_op_a = (operator_i == `ALU_ABS) ? ~operand_a_i : operand_a_i;

  // prepare operand b
  assign adder_op_b = (operator_i == `ALU_SUB) ? ~operand_b_i : operand_b_i;

  // prepare vector carrys
  always_comb
  begin
    carry_in  = {carry_out[2], carry_out[1], carry_out[0], 1'b0};

    case (operator_i)
      `ALU_ADDC: carry_in[0] = carry_i;

      `ALU_SUB, `ALU_ABS:
      begin
        case (vector_mode_i)
          default: // VEC_MODE32
          begin
            carry_in[0] = 1'b1;
          end

          `VEC_MODE16:
          begin
            carry_in[0] = 1'b1;
            carry_in[2] = 1'b1;
          end

          `VEC_MODE8:
          begin
            carry_in    = 4'b1111;
          end
        endcase
      end

      default:
      begin
        case (vector_mode_i)
          default: // VEC_MODE32
          begin
            carry_in[0] = 1'b0;
          end

          `VEC_MODE16:
          begin
            carry_in[0] = 1'b0;
            carry_in[2] = 1'b0;
          end

          `VEC_MODE8:
          begin
            carry_in    = 4'b0000;
          end
        endcase
      end
    endcase
  end

  // adder consisting of four slices
  assign {carry_out[0], adder_result[ 7: 0]} = adder_op_a[ 7: 0] + adder_op_b[ 7: 0] + carry_in[0];
  assign {carry_out[1], adder_result[15: 8]} = adder_op_a[15: 8] + adder_op_b[15: 8] + carry_in[1];
  assign {carry_out[2], adder_result[23:16]} = adder_op_a[23:16] + adder_op_b[23:16] + carry_in[2];
  assign {carry_out[3], adder_result[31:24]} = adder_op_a[31:24] + adder_op_b[31:24] + carry_in[3];


  // averaging by right shifting of one bit
  logic [31:0] result_avg;

  assign result_avg[ 6: 0] = adder_result[ 7: 1];
  assign result_avg[14: 8] = adder_result[15: 9];
  assign result_avg[22:16] = adder_result[23:17];
  assign result_avg[30:24] = adder_result[31:25];

  assign result_avg[ 7] =  (vector_mode_i == `VEC_MODE8)                                    ? ((operator_i == `ALU_AVGU) ? 1'b0 : adder_result[ 7]) : adder_result[ 8];
  assign result_avg[15] = ((vector_mode_i == `VEC_MODE16) || (vector_mode_i == `VEC_MODE8)) ? ((operator_i == `ALU_AVGU) ? 1'b0 : adder_result[15]) : adder_result[16];
  assign result_avg[23] =  (vector_mode_i == `VEC_MODE8)                                    ? ((operator_i == `ALU_AVGU) ? 1'b0 : adder_result[23]) : adder_result[24];
  assign result_avg[31] = (operator_i == `ALU_AVGU) ? 1'b0 : adder_result[31];


  ////////////////////////////////////////
  //  ____  _   _ ___ _____ _____       //
  // / ___|| | | |_ _|  ___|_   _|      //
  // \___ \| |_| || || |_    | |        //
  //  ___) |  _  || ||  _|   | |        //
  // |____/|_| |_|___|_|     |_|        //
  //                                    //
  ////////////////////////////////////////
  logic        shift_left;         // should we shift left?
  logic [31:0] shift_amt;          // amount of shift
  logic [31:0] shift_amt_left;     // amount of shift, adapted to vector mode for sll
  logic [31:0] shift_amt_int;      // amount of shift, adapted to vector mode for sll
  logic [31:0] shift_op_a;         // input of the shifter
  logic [31:0] shift_result;
  logic [31:0] shift_left_result;


  // by reversing the bits of the input, we also have the reverse the order of shift amounts
  always_comb
  begin
    case(vector_mode_i)
      default: // VEC_MODE32
      begin
        shift_amt_left[31: 0] = shift_amt[31: 0];
      end

      `VEC_MODE16:
      begin
        shift_amt_left[15: 0] = shift_amt[31:16];
        shift_amt_left[31:16] = shift_amt[15: 0];
      end

      `VEC_MODE8:
      begin
        shift_amt_left[ 7: 0] = shift_amt[31:24];
        shift_amt_left[15: 8] = shift_amt[23:16];
        shift_amt_left[23:16] = shift_amt[15: 8];
        shift_amt_left[31:24] = shift_amt[ 7: 0];
      end
    endcase
  end

  // choose the bit reversed or the normal input for shift operand a
  assign shift_op_a    = (shift_left == 1'b1) ? operand_a_rev : operand_a_i;
  assign shift_amt_int = (shift_left == 1'b1) ? shift_amt_left : shift_amt;

  // right shifts, we let the synthesizer optimize this
  always_comb
  begin
    case(vector_mode_i)
      default: // VEC_MODE32
      begin
        if(operator_i == `ALU_SRA)
          shift_result = $unsigned( $signed(shift_op_a)     >>> shift_amt_int[4:0] );
        else if(operator_i == `ALU_ROR)
          shift_result = {shift_op_a, shift_op_a} >> shift_amt_int[4:0];
        else
          shift_result = shift_op_a               >> shift_amt_int[4:0];
      end

      `VEC_MODE16:
      begin
        if(operator_i == `ALU_SRA)
        begin
          shift_result[31:16] = $unsigned( $signed(shift_op_a[31:16]) >>> shift_amt_int[19:16] );
          shift_result[15: 0] = $unsigned( $signed(shift_op_a[15: 0]) >>> shift_amt_int[ 3: 0] );
        end
        else
        begin
          shift_result[31:16] = shift_op_a[31:16]  >> shift_amt_int[19:16];
          shift_result[15: 0] = shift_op_a[15: 0]  >> shift_amt_int[ 3: 0];
        end
      end

      `VEC_MODE8:
      begin
        if(operator_i == `ALU_SRA)
        begin
          shift_result[31:24] = $unsigned( $signed(shift_op_a[31:24]) >>> shift_amt_int[26:24] );
          shift_result[23:16] = $unsigned( $signed(shift_op_a[23:16]) >>> shift_amt_int[18:16] );
          shift_result[15: 8] = $unsigned( $signed(shift_op_a[15: 8]) >>> shift_amt_int[10: 8] );
          shift_result[ 7: 0] = $unsigned( $signed(shift_op_a[ 7: 0]) >>> shift_amt_int[ 2: 0] );
        end
        else
        begin
          shift_result[31:24] = shift_op_a[31:24]  >> shift_amt_int[26:24];
          shift_result[23:16] = shift_op_a[23:16]  >> shift_amt_int[18:16];
          shift_result[15: 8] = shift_op_a[15: 8]  >> shift_amt_int[10: 8];
          shift_result[ 7: 0] = shift_op_a[ 7: 0]  >> shift_amt_int[ 2: 0];
        end
      end
    endcase; // case (vec_mode_i)
  end

  // bit reverse the shift_result for left shifts
  genvar       j;
  generate
    for(j = 0; j < 32; j++)
    begin
      assign shift_left_result[j] = shift_result[31-j];
    end
  endgenerate



  //////////////////////////////////////////////////////////////////
  //   ____ ___  __  __ ____   _    ____  ___ ____   ___  _   _   //
  //  / ___/ _ \|  \/  |  _ \ / \  |  _ \|_ _/ ___| / _ \| \ | |  //
  // | |  | | | | |\/| | |_) / _ \ | |_) || |\___ \| | | |  \| |  //
  // | |__| |_| | |  | |  __/ ___ \|  _ < | | ___) | |_| | |\  |  //
  //  \____\___/|_|  |_|_| /_/   \_\_| \_\___|____/ \___/|_| \_|  //
  //                                                              //
  //////////////////////////////////////////////////////////////////

  // results
  logic [3:0]  is_equal;
  logic [3:0]  is_greater;  // handles both signed and unsigned forms

  logic [3:0]  sel_minmax;  // mux control
  logic [31:0] result_minmax;
  logic [31:0] minmax_b;


  logic        do_min;

  // 8-bit vector comparisons, basic building blocks
  logic [3:0]  cmp_sign_mode;
  logic [3:0]  is_equal_vec;
  logic [3:0]  is_greater_vec;


  // generate cmp_sign_mode signal that is used for comparisons below
  always_comb
  begin
    cmp_sign_mode[3:0] = 4'b0000; // unsigned mode

    // signed mode
    if ((operator_i == `ALU_GTS) ||
        (operator_i == `ALU_GES) ||
        (operator_i == `ALU_LTS) ||
        (operator_i == `ALU_LES) ||
        (operator_i == `ALU_MAX) ||
        (operator_i == `ALU_MIN) ||
        (operator_i == `ALU_ABS))
    begin
      case (vector_mode_i)
        default:     cmp_sign_mode[3:0] = 4'b1000;
        `VEC_MODE16: cmp_sign_mode[3:0] = 4'b1010;
        `VEC_MODE8:  cmp_sign_mode[3:0] = 4'b1111;
      endcase
    end
  end

  // generate vector equal and greater than signals, cmp_sign_mode decides if the comparison is done signed or unsigned
  genvar      i;
  generate
    for(i = 0; i < 4; i++)
    begin
      assign is_equal_vec[i]   = (operand_a_i[8*i+7:8*i] == operand_b_i[8*i+7:i*8]);
      assign is_greater_vec[i] = $signed({operand_a_i[8*i+7] & cmp_sign_mode[i], operand_a_i[8*i+7:8*i]})
                                  >
                                 $signed({operand_b_i[8*i+7] & cmp_sign_mode[i], operand_b_i[8*i+7:i*8]});
    end
  endgenerate


  always_comb
  begin
    is_equal[3:0]   = {4{is_equal_vec[3] & is_equal_vec[2] & is_equal_vec[1] & is_equal_vec[0]}};
    is_greater[3:0] = {4{is_greater_vec[3] | (is_equal_vec[3] & (is_greater_vec[2]
                                            | (is_equal_vec[2] & (is_greater_vec[1]
                                             | (is_equal_vec[1] & (is_greater_vec[0]))))))}};

    case(vector_mode_i)
      default:; // see default assignment

      `VEC_MODE16:
      begin
        is_equal[1:0]   = {2{is_equal_vec[0]   & is_equal_vec[1]}};
        is_equal[3:2]   = {2{is_equal_vec[2]   & is_equal_vec[3]}};
        is_greater[1:0] = {2{is_greater_vec[1] | (is_equal_vec[1] & is_greater_vec[0])}};
        is_greater[3:2] = {2{is_greater_vec[3] | (is_equal_vec[3] & is_greater_vec[2])}};
      end

      `VEC_MODE8:
      begin
        is_equal[3:0]   = is_equal_vec[3:0];
        is_greater[3:0] = is_greater_vec[3:0];
      end
    endcase
  end


  // choose result value for min/max/abs
  assign minmax_b = (operator_i == `ALU_ABS) ? adder_result : operand_b_i;

  assign do_min   = ((operator_i == `ALU_MIN) || (operator_i == `ALU_MINU));

  // reuse the minmax mux also for the cmove instruction
  // the mux now handles, min, max, abs, cmov, ins
  always_comb
  begin
    sel_minmax[3:0] = is_greater ^ {4{do_min}};

    if(operator_i == `ALU_CMOV)
      sel_minmax[3:0] = {4{flag_i}};

    if(operator_i == `ALU_INS)
    begin
      if(vector_mode_i == `VEC_MODE16)
      begin
        sel_minmax[1:0] = {2{vec_ext_i[0]}};
        sel_minmax[3:2] = ~{2{vec_ext_i[0]}};
      end
      else // `VEC_MODE8
      begin
        sel_minmax[0] = (vec_ext_i != 2'b00);
        sel_minmax[1] = (vec_ext_i != 2'b01);
        sel_minmax[2] = (vec_ext_i != 2'b10);
        sel_minmax[3] = (vec_ext_i != 2'b11);
      end
    end
  end

  assign result_minmax[31:24] = (sel_minmax[3] == 1'b1) ? operand_a_i[31:24] : minmax_b[31:24];
  assign result_minmax[23:16] = (sel_minmax[2] == 1'b1) ? operand_a_i[23:16] : minmax_b[23:16];
  assign result_minmax[15: 8] = (sel_minmax[1] == 1'b1) ? operand_a_i[15: 8] : minmax_b[15: 8];
  assign result_minmax[ 7: 0] = (sel_minmax[0] == 1'b1) ? operand_a_i[ 7: 0] : minmax_b[ 7: 0];


  // generate comparison results
  logic [3:0] cmp_result;
  logic       any_result;
  logic       all_result;

  always_comb
  begin
    cmp_result = is_equal;

    case (operator_i)
      `ALU_EQ:            cmp_result = is_equal;
      `ALU_NE:            cmp_result = ~is_equal;
      `ALU_GTS, `ALU_GTU: cmp_result = is_greater;
      `ALU_GES, `ALU_GEU: cmp_result = is_greater | is_equal;
      `ALU_LTS, `ALU_LTU: cmp_result = ~(is_greater | is_equal);
      `ALU_LES, `ALU_LEU: cmp_result = ~is_greater;
      default:; // nothing to do
    endcase //~case(operator_i)
  end

  assign any_result = |cmp_result;
  assign all_result = &cmp_result;


  //////////////////////////////////////////////////
  //  _____      _                 _              //
  // | ____|_  _| |_ ___ _ __  ___(_) ___  _ __   //
  // |  _| \ \/ / __/ _ \ '_ \/ __| |/ _ \| '_ \  //
  // | |___ >  <| ||  __/ | | \__ \ | (_) | | | | //
  // |_____/_/\_\\__\___|_| |_|___/_|\___/|_| |_| //
  //                                              //
  //////////////////////////////////////////////////

  logic [7:0]  ext_byte;
  logic [15:0] ext_word;
  logic [31:0] result_ext;

  always_comb
  begin
    ext_byte = operand_a_i[7:0];

    if(operator_i == `ALU_EXT)
    begin
      case(vec_ext_i)
        2'b00: ext_byte = operand_a_i[ 7: 0];
        2'b01: ext_byte = operand_a_i[15: 8];
        2'b10: ext_byte = operand_a_i[23:16];
        2'b11: ext_byte = operand_a_i[31:24];
      endcase
    end
  end

  assign ext_word = ((vec_ext_i[0] == 1'b1) && (operator_i == `ALU_EXT)) ? operand_a_i[31:16] : operand_a_i[15:0];

  always_comb
  begin
    // zero extend byte
    result_ext = {24'b0, ext_byte[7:0]};

    // sign extend byte
    if((operator_i == `ALU_EXTBS) || ((operator_i == `ALU_EXT) && (vector_mode_i == `VEC_MODE8)))
      result_ext = {{24{ext_byte[7]}}, ext_byte[7:0]};

    // zero extend word
    if(operator_i == `ALU_EXTHZ)
      result_ext = {16'b0, ext_word[15:0]};

    // sign extend word
    if((operator_i == `ALU_EXTHS) || ((operator_i == `ALU_EXT) && (vector_mode_i == `VEC_MODE16)))
      result_ext = {{16{ext_word[15]}}, ext_word[15:0]};
  end

  /////////////////////////////////////////////////////////////////////
  //   ____  _ _      ____                  _      ___               //
  //  | __ )(_) |_   / ___|___  _   _ _ __ | |_   / _ \ _ __  ___    //
  //  |  _ \| | __| | |   / _ \| | | | '_ \| __| | | | | '_ \/ __|   //
  //  | |_) | | |_  | |__| (_) | |_| | | | | |_  | |_| | |_) \__ \_  //
  //  |____/|_|\__|  \____\___/ \__,_|_| |_|\__|  \___/| .__/|___(_) //
  //                                                   |_|           //
  /////////////////////////////////////////////////////////////////////

  logic [31:0] ff_input;   // either op_a_i or its bit reversed version
  logic [5:0]  clb_result; // count leading bits
  logic [5:0]  ff1_result; // holds the index of the first '1'
  logic [5:0]  fl1_result; // holds the index of the last '1'
  logic        ff_cmp;     // compare value for ff1 and fl1
  integer q;

  assign ff_input  = (operator_i == `ALU_FF1) ? operand_a_i : operand_a_rev;
  assign ff_cmp    = (operator_i == `ALU_CLB) ? ~operand_a_i[31] : 1'b1;

  always_comb
  begin
    ff1_result = 6'd0;

    for(q = 1; q < 33; q++)
    begin
      if(ff_input[q - 1] == ff_cmp)
      begin
        ff1_result = q;
        break;
      end
    end
  end

  // special case if ff1_res is 0 (no 1 found), then we keep the 0
  assign fl1_result = (ff1_result == 6'd0) ? 6'd0 : (6'd33 - ff1_result);
  assign clb_result = (ff1_result == 6'd0) ? 6'd0 : (ff1_result - 6'd2);


  // count the number of '1's in a word
  logic [5:0]  cnt_result; // holds the number of '1's in a word
  logic [1:0]  cnt_l1[16];
  logic [2:0]  cnt_l2[8];
  logic [3:0]  cnt_l3[4];
  logic [4:0]  cnt_l4[2];

  genvar      l, m, n, p;
  generate for(l = 0; l < 16; l++)
    begin
      assign cnt_l1[l] = operand_a_i[2*l] + operand_a_i[2*l + 1];
    end
  endgenerate

  generate for(m = 0; m < 8; m++)
    begin
      assign cnt_l2[m] = cnt_l1[2*m] + cnt_l1[2*m + 1];
    end
  endgenerate

  generate for(n = 0; n < 4; n++)
    begin
      assign cnt_l3[n] = cnt_l2[2*n] + cnt_l2[2*n + 1];
    end
  endgenerate

  generate for(p = 0; p < 2; p++)
    begin
      assign cnt_l4[p] = cnt_l3[2*p] + cnt_l3[2*p + 1];
    end
  endgenerate

  assign cnt_result = cnt_l4[0] + cnt_l4[1];

  ////////////////////////////////////////////////////////
  //   ____                 _ _     __  __              //
  //  |  _ \ ___  ___ _   _| | |_  |  \/  |_   ___  __  //
  //  | |_) / _ \/ __| | | | | __| | |\/| | | | \ \/ /  //
  //  |  _ <  __/\__ \ |_| | | |_  | |  | | |_| |>  <   //
  //  |_| \_\___||___/\__,_|_|\__| |_|  |_|\__,_/_/\_\  //
  //                                                    //
  ////////////////////////////////////////////////////////

  always_comb
  begin
    shift_left = 1'b0;
    shift_amt  = operand_b_i;
    result_o   = 'x;
    carry_o    = 1'b0;
    overflow_o = 1'b0;
    flag_o     = 1'b0;

    unique case (operator_i)
      // Standard Operations
      `ALU_ADD, `ALU_ADDC, `ALU_SUB:
      begin // Addition defined above
        result_o   = adder_result[31:0];
        carry_o    = carry_out[3];
        overflow_o = (adder_op_a[31] ^ adder_result[31]) & (adder_op_b[31] ^ adder_result[31]); // ++ => - and -- => +
      end
      `ALU_AVG, `ALU_AVGU: result_o = result_avg;
      `ALU_AND: result_o = operand_a_i & operand_b_i;
      `ALU_OR:  result_o = operand_a_i | operand_b_i;
      `ALU_XOR: result_o = operand_a_i ^ operand_b_i;

      // Shift Operations
      `ALU_MOVHI:
      begin
        shift_left = 1'b1;
        shift_amt  = 32'd16;
        result_o   = shift_left_result;
      end
      `ALU_SLL:
      begin
        shift_left = 1'b1;
        result_o   = shift_left_result;
      end

      `ALU_SRL, `ALU_SRA, `ALU_ROR: result_o = shift_result;

      // Extension Operations
      `ALU_EXTWZ, `ALU_EXTWS: result_o = operand_a_i;
      `ALU_EXTBZ, `ALU_EXTBS, `ALU_EXTHZ, `ALU_EXTHS, `ALU_EXT: result_o = result_ext;

      // Min/Max/Abs, CMOV, INS
      `ALU_MIN, `ALU_MINU, `ALU_MAX, `ALU_MAXU, `ALU_ABS, `ALU_CMOV, `ALU_INS: result_o = result_minmax;

      // Comparison Operations
      `ALU_EQ, `ALU_NE, `ALU_GTU, `ALU_GEU, `ALU_LTU, `ALU_LEU, `ALU_GTS, `ALU_GES, `ALU_LTS, `ALU_LES:
      begin
        result_o[31:24] = {8{cmp_result[3]}};
        result_o[23:16] = {8{cmp_result[2]}};
        result_o[15: 8] = {8{cmp_result[1]}};
        result_o[ 7: 0] = {8{cmp_result[0]}};

        case (cmp_mode_i)
          `ALU_CMP_ANY:
           begin
            flag_o = any_result;
           end
          `ALU_CMP_ALL:
          begin
            flag_o = all_result;
          end
          `ALU_CMP_FULL:
          begin
            flag_o = cmp_result[0];
          end
          default:;
        endcase //~case(cmp_mode_i)
      end

      `ALU_FF1: result_o = {26'h0, ff1_result};
      `ALU_FL1: result_o = {26'h0, fl1_result};
      `ALU_CLB: result_o = {26'h0, clb_result};
      `ALU_CNT: result_o = {26'h0, cnt_result};

      `ALU_NOP: ; // Do nothing

      default:
      begin
        //synopsys translate_off

        //synopsys translate_on
      end
    endcase //~case(operator_i)
  end

endmodule //~module alu

