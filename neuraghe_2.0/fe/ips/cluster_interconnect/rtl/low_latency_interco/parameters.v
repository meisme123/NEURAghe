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
// Revision v0.2 - File Cleaned , removed defines and moved in the rtl files  // 
//                 as paramereters (19/02/2015)                               //
//                                                                            //
// Additional Comments:                                                       //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

//---------------------------------------------------//
//                   MACROS HERE                     //
//---------------------------------------------------//
`define ADDR_OFFSET(VALUE) ( $clog2(VALUE) - 3 ) // Address Offset: OFFSET IS 32bit--> 2bit; 64bit--> 3bit; 128bit--> 4bit and so on

// LOG2()
`define log2(VALUE)          ((VALUE) < ( 1 ) ? 0 : (VALUE) < ( 2 ) ? 1 : (VALUE) < ( 4 ) ? 2 : (VALUE)< (8) ? 3:(VALUE) < ( 16 )  ? 4 : (VALUE) < ( 32 )  ? 5 : (VALUE) < ( 64 )  ? 6 : (VALUE) < ( 128 ) ? 7 : (VALUE) < ( 256 ) ? 8 : (VALUE) < ( 512 ) ? 9 : 10)
      
`define log2_non_zero(VALUE) ((VALUE) < ( 1 ) ? 1 : (VALUE) < ( 2 ) ? 1 : (VALUE) < ( 4 ) ? 2 : (VALUE)< (8) ? 3:(VALUE) < ( 16 )  ? 4 : (VALUE) < ( 32 )  ? 5 : (VALUE) < ( 64 )  ? 6 : (VALUE) < ( 128 ) ? 7 : (VALUE) < ( 256 ) ? 8 : (VALUE) < ( 512 ) ? 9 : 10)


// Comment this to enable Stall based Flow COntrol
`define GNT_BASED_FC	


