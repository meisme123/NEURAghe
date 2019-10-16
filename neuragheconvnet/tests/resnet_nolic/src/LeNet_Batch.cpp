// This code is auto-generated. Do not edit.

#include "LeNet_Batch.h"

#include "assert.h"

#define ELEM_PER_WS 32

#define PRECISION8 0

// global variables

#if !(_RELEASE_)
	#define _rprintf_(...) printf(__VA_ARGS__)
	//#define spatconv_forward_hw(...) spatconv_forward_hw_sync(__VA_ARGS__)
	#ifdef _DEBUG_
		#define _dprintf_(...) printf(__VA_ARGS__)
		#define _dprint_data_(...) print_data(__VA_ARGS__)
	#else
		#define _dprintf_(...) ;
		#define _dprint_data_(...) ;
	#endif
#else
	#define _rprintf_(...) ;
	#define _dprintf_(...) ;
	#define _dprint_data_(...) ;
#endif

// global variables
SOCMAP socs[2];
DATA* wPointer;


SPATCONV scale1_conv2d_5x5_0_param;
SPATCONV scale1_conv2d_5x5_1_param;
SPATCONV scale1_conv2d_5x5_2_param;
SPATCONV scale1_conv2d_5x5_3_param;
SPATCONV scale2_block0_A_conv2d_param;
SPATCONV scale2_block0_B_conv2d_param;
SPATCONV scale2_block1_A_conv2d_param;
SPATCONV scale2_block1_B_conv2d_param;
SPATCONV scale3_block0_shortcut_conv2d_param;
SPATCONV scale3_block0_A_conv2d_param;
SPATCONV scale3_block0_B_conv2d_param;
SPATCONV scale3_block1_A_conv2d_param;
SPATCONV scale3_block1_B_conv2d_param;
SPATCONV scale4_block0_shortcut_conv2d_param;
SPATCONV scale4_block0_A_conv2d_param;
SPATCONV scale4_block0_B_conv2d_param;
SPATCONV scale4_block1_A_conv2d_param;
SPATCONV scale4_block1_B_conv2d_param;
SPATCONV scale5_block0_shortcut_conv2d_param;
SPATCONV scale5_block0_A_conv2d_param;
SPATCONV scale5_block0_B_conv2d_param;
SPATCONV scale5_block1_A_conv2d_param;
SPATCONV scale5_block1_B_conv2d_param;
LINEAR_FP16 xw_plus_b_MatMul_param;


DATA *scale1_conv2d_5x5_0_out;
DATA *scale1_conv2d_5x5_1_out;
DATA *scale1_conv2d_5x5_2_out;
DATA *scale1_conv2d_5x5_3_out;
DATA *tmp_out; 

DATA scale1_conv2d_padding_output[3 * 228 * 228];
DATA scale1_conv2d_merge_output[64 * 112 * 112];
DATA scale1_Relu_output[64 * 112 * 112];
DATA scale2_max_pool_output[64 * 56 * 56];	
DATA scale2_block0_A_conv2d_output[200704];	
DATA scale2_block0_B_conv2d_output[200704];
DATA scale2_block0_Residual_Add_Add_output[64 * 56 * 56];	
DATA scale2_block1_A_conv2d_output[200704];	
DATA scale2_block1_B_conv2d_output[200704];	
DATA scale3_block0_shortcut_conv2d_output[100352];	
DATA scale3_block0_A_conv2d_output[100352];	
DATA scale3_block0_B_conv2d_output[100352];	
DATA scale3_block1_A_conv2d_output[100352];	
DATA scale3_block1_B_conv2d_output[100352];	
DATA scale4_block0_shortcut_conv2d_output[50176];	
DATA scale4_block0_A_conv2d_output[50176];	
DATA scale4_block0_B_conv2d_output[50176];	
DATA scale4_block1_A_conv2d_output[50176];	
DATA scale4_block1_B_conv2d_output[50176];	
DATA scale5_block0_shortcut_conv2d_output[25088];	
DATA scale5_block0_A_conv2d_output[25088];	
DATA scale5_block0_B_conv2d_output[25088];
DATA scale5_block0_B_conv2d_output_hw[512 * 8 * 7];	
DATA scale5_block1_A_conv2d_output[25088];	
DATA scale5_block1_B_conv2d_output[25088];
DATA scale5_block1_B_conv2d_output_hw[512 * 8 * 7];
DATA scale2_block0_Shortcut[64 * 56 * 56];
DATA avg_pool_output[512 * 1 * 1];
DATA scale2_block1_Shortcut[64 * 56 * 56];
DATA scale2_block1_Residual_Add_Add_output[64 * 56 * 56];
DATA scale3_block0_Shortcut[128 * 28 * 28];	
DATA scale3_block0_Residual_Add_Add_output[128 * 28 * 28];
DATA scale3_block1_Shortcut[128 * 28 * 28];	
DATA scale3_block1_Residual_Add_Add_output[128 * 28 * 28];
DATA scale4_block0_Shortcut[256 * 14 * 14];	
DATA scale4_block0_Residual_Add_Add_output[256 * 14 * 14];
DATA scale4_block1_Shortcut[256 * 14 * 14];
DATA scale4_block1_Residual_Add_Add_output[256 * 14 * 14];	
DATA scale5_block0_Shortcut[512 * 8 * 7];
DATA scale5_block0_Residual_Add_Add_output[512 * 7 * 7];
DATA scale5_block0_Residual_Add_Add_output_hw[512 * 8 * 7];
DATA scale5_block1_Shortcut[512 * 8 * 7];
DATA scale5_block1_Residual_Add_Add_output[512 * 7 * 7];
DATA scale5_block1_Residual_Add_Add_output_tmp[512 * 8 * 7];


void init_platform(char* bitstream){
	init_soc(socs, &wPointer, _MAXMEM_, 0, bitstream);
}

/*

 ██████╗███╗   ██╗███╗   ██╗    ██╗███╗   ██╗██╗████████╗
██╔════╝████╗  ██║████╗  ██║    ██║████╗  ██║██║╚══██╔══╝
██║     ██╔██╗ ██║██╔██╗ ██║    ██║██╔██╗ ██║██║   ██║   
██║     ██║╚██╗██║██║╚██╗██║    ██║██║╚██╗██║██║   ██║   
╚██████╗██║ ╚████║██║ ╚████║    ██║██║ ╚████║██║   ██║   
 ╚═════╝╚═╝  ╚═══╝╚═╝  ╚═══╝    ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   
                                                                                                              
                                                          
*/

void cnnMainInit(VARNAME load_data_dir)
{
        #define _NCOL_ 4
        #define _NROW_ 4
        int minIF=0;
        int wsize=0;
        int minOF=0;
        int IG=0, OG=0;

	double time;
	VARNAME filename;

	SIZE scale1_conv2d_5x5_out_dim = 64 * 226 * 226;
	scale1_conv2d_5x5_0_out = (DATA*)neu_DDRmalloc(scale1_conv2d_5x5_out_dim*sizeof(DATA));
	scale1_conv2d_5x5_1_out = (DATA*)neu_DDRmalloc(scale1_conv2d_5x5_out_dim*sizeof(DATA));
	scale1_conv2d_5x5_2_out = (DATA*)neu_DDRmalloc(scale1_conv2d_5x5_out_dim*sizeof(DATA));
	scale1_conv2d_5x5_3_out = (DATA*)neu_DDRmalloc(scale1_conv2d_5x5_out_dim*sizeof(DATA));
	tmp_out = (DATA*)neu_DDRmalloc(_MAXMEM_*sizeof(DATA));

int minmaxog = 4;
if (_NCOL_ == 2)
   minmaxog=9;
	/*
	 * Convolution layer
	 * IF = 3 x 226 x 226 --> OF = 64 x 113 x 113
	 * W 64 x 3 x 5 x 5
	 * Pad    2x2
	 * Stride 2x2
	 */
	scale1_conv2d_5x5_0_param = spatconv_create();
	scale1_conv2d_5x5_0_param->pout = 64;
	scale1_conv2d_5x5_0_param->pin = 3;
	scale1_conv2d_5x5_0_param->kern_s[0] = 64;
	scale1_conv2d_5x5_0_param->kern_s[1] = 3;
	scale1_conv2d_5x5_0_param->kern_s[2] = 5;
	scale1_conv2d_5x5_0_param->kern_s[3] = 5;
        
        if (scale1_conv2d_5x5_0_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale1_conv2d_5x5_0_param->pin/minIF;
        if (scale1_conv2d_5x5_0_param->pin%minIF)
          IG++;
        
        OG= scale1_conv2d_5x5_0_param->pout/minOF;
        if (scale1_conv2d_5x5_0_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  

	// preprocessed weight dim = 7168
	// original weight shape = 64 x 3 x 5 x 5;
	sprintf(filename, "%s/scale1_conv2d_5x5_0_weights_array_file", load_data_dir);
	scale1_conv2d_5x5_0_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale1_conv2d_5x5_0_param->kernel);
		
	SIZE scale1_conv2d_5x5_0_bias_dim = 64;
	scale1_conv2d_5x5_0_param->bias = (DATA*)neu_DDRmalloc(scale1_conv2d_5x5_0_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale1_conv2d_5x5_0_bias_array_file", load_data_dir);
	load_fixed(filename,scale1_conv2d_5x5_0_bias_dim,scale1_conv2d_5x5_0_param->bias);
	
	SIZE scale1_conv2d_5x5_0_dim = 64 * 113 * 113;
	
	
	/*
	 * Convolution layer
	 * IF = 3 x 226 x 226 --> OF = 64 x 113 x 113
	 * W 64 x 3 x 5 x 5
	 * Pad    2x2
	 * Stride 2x2
	 */
	scale1_conv2d_5x5_1_param = spatconv_create();
	scale1_conv2d_5x5_1_param->pout = 64;
	scale1_conv2d_5x5_1_param->pin = 3;
	scale1_conv2d_5x5_1_param->kern_s[0] = 64;
	scale1_conv2d_5x5_1_param->kern_s[1] = 3;
	scale1_conv2d_5x5_1_param->kern_s[2] = 5;
	scale1_conv2d_5x5_1_param->kern_s[3] = 5;
	
        
        if (scale1_conv2d_5x5_1_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale1_conv2d_5x5_1_param->pin/minIF;
        if (scale1_conv2d_5x5_1_param->pin%minIF)
          IG++;
        
        OG= scale1_conv2d_5x5_1_param->pout/minOF;
        if (scale1_conv2d_5x5_1_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
        
	// preprocessed weight dim = 7168
	// original weight shape = 64 x 3 x 5 x 5;
	sprintf(filename, "%s/scale1_conv2d_5x5_1_weights_array_file", load_data_dir);
	scale1_conv2d_5x5_1_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale1_conv2d_5x5_1_param->kernel);
	
	SIZE scale1_conv2d_5x5_1_bias_dim = 64;
	scale1_conv2d_5x5_1_param->bias = (DATA*)neu_DDRmalloc(scale1_conv2d_5x5_1_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale1_conv2d_5x5_1_bias_array_file", load_data_dir);
	load_fixed(filename,scale1_conv2d_5x5_1_bias_dim,scale1_conv2d_5x5_1_param->bias);
	
	SIZE scale1_conv2d_5x5_1_dim = 64 * 113 * 113;
	
	
	/*
	 * Convolution layer
	 * IF = 3 x 226 x 226 --> OF = 64 x 113 x 113
	 * W 64 x 3 x 5 x 5
	 * Pad    2x2
	 * Stride 2x2
	 */
	scale1_conv2d_5x5_2_param = spatconv_create();
	scale1_conv2d_5x5_2_param->pout = 64;
	scale1_conv2d_5x5_2_param->pin = 3;
	scale1_conv2d_5x5_2_param->kern_s[0] = 64;
	scale1_conv2d_5x5_2_param->kern_s[1] = 3;
	scale1_conv2d_5x5_2_param->kern_s[2] = 5;
	scale1_conv2d_5x5_2_param->kern_s[3] = 5;
	
        if (scale1_conv2d_5x5_2_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale1_conv2d_5x5_2_param->pin/minIF;
        if (scale1_conv2d_5x5_2_param->pin%minIF)
          IG++;
        
        OG= scale1_conv2d_5x5_2_param->pout/minOF;
        if (scale1_conv2d_5x5_2_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 7168
	// original weight shape = 64 x 3 x 5 x 5;
	sprintf(filename, "%s/scale1_conv2d_5x5_2_weights_array_file", load_data_dir);
	scale1_conv2d_5x5_2_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));	
	load_fixed(filename,wsize,scale1_conv2d_5x5_2_param->kernel);
	
	SIZE scale1_conv2d_5x5_2_bias_dim = 64;
	scale1_conv2d_5x5_2_param->bias = (DATA*)neu_DDRmalloc(scale1_conv2d_5x5_2_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale1_conv2d_5x5_2_bias_array_file", load_data_dir);
	load_fixed(filename,scale1_conv2d_5x5_2_bias_dim,scale1_conv2d_5x5_2_param->bias);
	
	SIZE scale1_conv2d_5x5_2_dim = 64 * 113 * 113;
	
	
	/*
	 * Convolution layer
	 * IF = 3 x 226 x 226 --> OF = 64 x 113 x 113
	 * W 64 x 3 x 5 x 5
	 * Pad    2x2
	 * Stride 2x2
	 */
	scale1_conv2d_5x5_3_param = spatconv_create();
	scale1_conv2d_5x5_3_param->pout = 64;
	scale1_conv2d_5x5_3_param->pin = 3;
	scale1_conv2d_5x5_3_param->kern_s[0] = 64;
	scale1_conv2d_5x5_3_param->kern_s[1] = 3;
	scale1_conv2d_5x5_3_param->kern_s[2] = 5;
	scale1_conv2d_5x5_3_param->kern_s[3] = 5;
	
        if (scale1_conv2d_5x5_3_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale1_conv2d_5x5_3_param->pin/minIF;
        if (scale1_conv2d_5x5_3_param->pin%minIF)
          IG++;
        
        OG= scale1_conv2d_5x5_3_param->pout/minOF;
        if (scale1_conv2d_5x5_3_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 7168
	// original weight shape = 64 x 3 x 5 x 5;
	sprintf(filename, "%s/scale1_conv2d_5x5_3_weights_array_file", load_data_dir);
	scale1_conv2d_5x5_3_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale1_conv2d_5x5_3_param->kernel);
	
	SIZE scale1_conv2d_5x5_3_bias_dim = 64;
	scale1_conv2d_5x5_3_param->bias = (DATA*)neu_DDRmalloc(scale1_conv2d_5x5_3_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale1_conv2d_5x5_3_bias_array_file", load_data_dir);
	load_fixed(filename,scale1_conv2d_5x5_3_bias_dim,scale1_conv2d_5x5_3_param->bias);
	
	SIZE scale1_conv2d_5x5_3_dim = 64 * 113 * 113;

	SIZE scale2_max_pool_dim = 64 * 56 * 56;

	/*
	 * Convolution layer
	 * IF = 64 x 56 x 56 --> OF = 64 x 56 x 56
	 * W 64 x 64 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	scale2_block0_A_conv2d_param = spatconv_create();
	scale2_block0_A_conv2d_param->pout = 64;
	scale2_block0_A_conv2d_param->pin = 64;
	scale2_block0_A_conv2d_param->kern_s[0] = 64;
	scale2_block0_A_conv2d_param->kern_s[1] = 64;
	scale2_block0_A_conv2d_param->kern_s[2] = 3;
	scale2_block0_A_conv2d_param->kern_s[3] = 3;
	
        if (scale2_block0_A_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale2_block0_A_conv2d_param->pin/minIF;
        if (scale2_block0_A_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale2_block0_A_conv2d_param->pout/minOF;
        if (scale2_block0_A_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 43008
	// original weight shape = 64 x 64 x 3 x 3;
	sprintf(filename, "%s/scale2_block0_A_conv2d_weights_array_file", load_data_dir);
	scale2_block0_A_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
        
	load_fixed(filename,wsize,scale2_block0_A_conv2d_param->kernel);
	
	SIZE scale2_block0_A_conv2d_bias_dim = 64;
	scale2_block0_A_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale2_block0_A_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale2_block0_A_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale2_block0_A_conv2d_bias_dim,scale2_block0_A_conv2d_param->bias);
	
	SIZE scale2_block0_A_conv2d_dim = 64 * 56 * 56;
	
	
	/*
	 * Convolution layer
	 * IF = 64 x 56 x 56 --> OF = 64 x 56 x 56
	 * W 64 x 64 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	scale2_block0_B_conv2d_param = spatconv_create();
	scale2_block0_B_conv2d_param->pout = 64;
	scale2_block0_B_conv2d_param->pin = 64;
	scale2_block0_B_conv2d_param->kern_s[0] = 64;
	scale2_block0_B_conv2d_param->kern_s[1] = 64;
	scale2_block0_B_conv2d_param->kern_s[2] = 3;
	scale2_block0_B_conv2d_param->kern_s[3] = 3;
	
        if (scale2_block0_B_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale2_block0_B_conv2d_param->pin/minIF;
        if (scale2_block0_B_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale2_block0_B_conv2d_param->pout/minOF;
        if (scale2_block0_B_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 43008
	// original weight shape = 64 x 64 x 3 x 3;
	sprintf(filename, "%s/scale2_block0_B_conv2d_weights_array_file", load_data_dir);
	scale2_block0_B_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale2_block0_B_conv2d_param->kernel);
	
	SIZE scale2_block0_B_conv2d_bias_dim = 64;
	scale2_block0_B_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale2_block0_B_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale2_block0_B_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale2_block0_B_conv2d_bias_dim,scale2_block0_B_conv2d_param->bias);
	
	SIZE scale2_block0_B_conv2d_dim = 64 * 56 * 56;
	
	
	
	/*
	 * Convolution layer
	 * IF = 64 x 56 x 56 --> OF = 64 x 56 x 56
	 * W 64 x 64 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	scale2_block1_A_conv2d_param = spatconv_create();
	scale2_block1_A_conv2d_param->pout = 64;
	scale2_block1_A_conv2d_param->pin = 64;
	scale2_block1_A_conv2d_param->kern_s[0] = 64;
	scale2_block1_A_conv2d_param->kern_s[1] = 64;
	scale2_block1_A_conv2d_param->kern_s[2] = 3;
	scale2_block1_A_conv2d_param->kern_s[3] = 3;
	
        if (scale2_block1_A_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale2_block1_A_conv2d_param->pin/minIF;
        if (scale2_block1_A_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale2_block1_A_conv2d_param->pout/minOF;
        if (scale2_block1_A_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 43008
	// original weight shape = 64 x 64 x 3 x 3;
	sprintf(filename, "%s/scale2_block1_A_conv2d_weights_array_file", load_data_dir);
	scale2_block1_A_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale2_block1_A_conv2d_param->kernel);
	
	SIZE scale2_block1_A_conv2d_bias_dim = 64;
	scale2_block1_A_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale2_block1_A_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale2_block1_A_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale2_block1_A_conv2d_bias_dim,scale2_block1_A_conv2d_param->bias);
	
	SIZE scale2_block1_A_conv2d_dim = 64 * 56 * 56;
	
	
	/*
	 * Convolution layer
	 * IF = 64 x 56 x 56 --> OF = 64 x 56 x 56
	 * W 64 x 64 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	scale2_block1_B_conv2d_param = spatconv_create();
	scale2_block1_B_conv2d_param->pout = 64;
	scale2_block1_B_conv2d_param->pin = 64;
	scale2_block1_B_conv2d_param->kern_s[0] = 64;
	scale2_block1_B_conv2d_param->kern_s[1] = 64;
	scale2_block1_B_conv2d_param->kern_s[2] = 3;
	scale2_block1_B_conv2d_param->kern_s[3] = 3;
	
        if (scale2_block1_B_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale2_block1_B_conv2d_param->pin/minIF;
        if (scale2_block1_B_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale2_block1_B_conv2d_param->pout/minOF;
        if (scale2_block1_B_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 43008
	// original weight shape = 64 x 64 x 3 x 3;
	sprintf(filename, "%s/scale2_block1_B_conv2d_weights_array_file", load_data_dir);
	scale2_block1_B_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale2_block1_B_conv2d_param->kernel);
	
	SIZE scale2_block1_B_conv2d_bias_dim = 64;
	scale2_block1_B_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale2_block1_B_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale2_block1_B_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale2_block1_B_conv2d_bias_dim,scale2_block1_B_conv2d_param->bias);
	
	SIZE scale2_block1_B_conv2d_dim = 64 * 56 * 56;
	
	
	
	/*
	 * Convolution layer
	 * IF = 64 x 56 x 56 --> OF = 128 x 28 x 28
	 * W 128 x 64 x 3 x 3
	 * Pad    1x1
	 * Stride 2x2
	 */
	scale3_block0_shortcut_conv2d_param = spatconv_create();
	scale3_block0_shortcut_conv2d_param->pout = 128;
	scale3_block0_shortcut_conv2d_param->pin = 64;
	scale3_block0_shortcut_conv2d_param->kern_s[0] = 128;
	scale3_block0_shortcut_conv2d_param->kern_s[1] = 64;
	scale3_block0_shortcut_conv2d_param->kern_s[2] = 3;
	scale3_block0_shortcut_conv2d_param->kern_s[3] = 3;
	
        if (scale3_block0_shortcut_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale3_block0_shortcut_conv2d_param->pin/minIF;
        if (scale3_block0_shortcut_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale3_block0_shortcut_conv2d_param->pout/minOF;
        if (scale3_block0_shortcut_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 86016
	// original weight shape = 128 x 64 x 3 x 3;
	sprintf(filename, "%s/scale3_block0_shortcut_conv2d_weights_array_file", load_data_dir);
	scale3_block0_shortcut_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale3_block0_shortcut_conv2d_param->kernel);
	
	SIZE scale3_block0_shortcut_conv2d_bias_dim = 128;
	scale3_block0_shortcut_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale3_block0_shortcut_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale3_block0_shortcut_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale3_block0_shortcut_conv2d_bias_dim,scale3_block0_shortcut_conv2d_param->bias);
	
	SIZE scale3_block0_shortcut_conv2d_dim = 128 * 28 * 28;
	
	
	/*
	 * Convolution layer
	 * IF = 64 x 56 x 56 --> OF = 128 x 28 x 28
	 * W 128 x 64 x 3 x 3
	 * Pad    1x1
	 * Stride 2x2
	 */
	scale3_block0_A_conv2d_param = spatconv_create();
	scale3_block0_A_conv2d_param->pout = 128;
	scale3_block0_A_conv2d_param->pin = 64;
	scale3_block0_A_conv2d_param->kern_s[0] = 128;
	scale3_block0_A_conv2d_param->kern_s[1] = 64;
	scale3_block0_A_conv2d_param->kern_s[2] = 3;
	scale3_block0_A_conv2d_param->kern_s[3] = 3;
	
        if (scale3_block0_A_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale3_block0_A_conv2d_param->pin/minIF;
        if (scale3_block0_A_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale3_block0_A_conv2d_param->pout/minOF;
        if (scale3_block0_A_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 86016
	// original weight shape = 128 x 64 x 3 x 3;
	sprintf(filename, "%s/scale3_block0_A_conv2d_weights_array_file", load_data_dir);
	scale3_block0_A_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale3_block0_A_conv2d_param->kernel);
	
	SIZE scale3_block0_A_conv2d_bias_dim = 128;
	scale3_block0_A_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale3_block0_A_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale3_block0_A_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale3_block0_A_conv2d_bias_dim,scale3_block0_A_conv2d_param->bias);
	
	SIZE scale3_block0_A_conv2d_dim = 128 * 28 * 28;
	
	
	/*
	 * Convolution layer
	 * IF = 128 x 28 x 28 --> OF = 128 x 28 x 28
	 * W 128 x 128 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	scale3_block0_B_conv2d_param = spatconv_create();
	scale3_block0_B_conv2d_param->pout = 128;
	scale3_block0_B_conv2d_param->pin = 128;
	scale3_block0_B_conv2d_param->kern_s[0] = 128;
	scale3_block0_B_conv2d_param->kern_s[1] = 128;
	scale3_block0_B_conv2d_param->kern_s[2] = 3;
	scale3_block0_B_conv2d_param->kern_s[3] = 3;
	
        if (scale3_block0_B_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale3_block0_B_conv2d_param->pin/minIF;
        if (scale3_block0_B_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale3_block0_B_conv2d_param->pout/minOF;
        if (scale3_block0_B_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 157696
	// original weight shape = 128 x 128 x 3 x 3;
	sprintf(filename, "%s/scale3_block0_B_conv2d_weights_array_file", load_data_dir);
	scale3_block0_B_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale3_block0_B_conv2d_param->kernel);
	
	SIZE scale3_block0_B_conv2d_bias_dim = 128;
	scale3_block0_B_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale3_block0_B_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale3_block0_B_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale3_block0_B_conv2d_bias_dim,scale3_block0_B_conv2d_param->bias);
	
	SIZE scale3_block0_B_conv2d_dim = 128 * 28 * 28;
	
	
	
	/*
	 * Convolution layer
	 * IF = 128 x 28 x 28 --> OF = 128 x 28 x 28
	 * W 128 x 128 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	scale3_block1_A_conv2d_param = spatconv_create();
	scale3_block1_A_conv2d_param->pout = 128;
	scale3_block1_A_conv2d_param->pin = 128;
	scale3_block1_A_conv2d_param->kern_s[0] = 128;
	scale3_block1_A_conv2d_param->kern_s[1] = 128;
	scale3_block1_A_conv2d_param->kern_s[2] = 3;
	scale3_block1_A_conv2d_param->kern_s[3] = 3;
	
        if (scale3_block1_A_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale3_block1_A_conv2d_param->pin/minIF;
        if (scale3_block1_A_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale3_block1_A_conv2d_param->pout/minOF;
        if (scale3_block1_A_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 157696
	// original weight shape = 128 x 128 x 3 x 3;
	sprintf(filename, "%s/scale3_block1_A_conv2d_weights_array_file", load_data_dir);
	scale3_block1_A_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale3_block1_A_conv2d_param->kernel);
	
	SIZE scale3_block1_A_conv2d_bias_dim = 128;
	scale3_block1_A_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale3_block1_A_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale3_block1_A_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale3_block1_A_conv2d_bias_dim,scale3_block1_A_conv2d_param->bias);
	
	SIZE scale3_block1_A_conv2d_dim = 128 * 28 * 28;
	
	
	/*
	 * Convolution layer
	 * IF = 128 x 28 x 28 --> OF = 128 x 28 x 28
	 * W 128 x 128 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	scale3_block1_B_conv2d_param = spatconv_create();
	scale3_block1_B_conv2d_param->pout = 128;
	scale3_block1_B_conv2d_param->pin = 128;
	scale3_block1_B_conv2d_param->kern_s[0] = 128;
	scale3_block1_B_conv2d_param->kern_s[1] = 128;
	scale3_block1_B_conv2d_param->kern_s[2] = 3;
	scale3_block1_B_conv2d_param->kern_s[3] = 3;
	
        if (scale3_block1_B_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale3_block1_B_conv2d_param->pin/minIF;
        if (scale3_block1_B_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale3_block1_B_conv2d_param->pout/minOF;
        if (scale3_block1_B_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 157696
	// original weight shape = 128 x 128 x 3 x 3;
	sprintf(filename, "%s/scale3_block1_B_conv2d_weights_array_file", load_data_dir);
	scale3_block1_B_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale3_block1_B_conv2d_param->kernel);
	
	SIZE scale3_block1_B_conv2d_bias_dim = 128;
	scale3_block1_B_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale3_block1_B_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale3_block1_B_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale3_block1_B_conv2d_bias_dim,scale3_block1_B_conv2d_param->bias);
	
	SIZE scale3_block1_B_conv2d_dim = 128 * 28 * 28;
	
	
	
	/*
	 * Convolution layer
	 * IF = 128 x 28 x 28 --> OF = 256 x 14 x 14
	 * W 256 x 128 x 3 x 3
	 * Pad    1x1
	 * Stride 2x2
	 */
	scale4_block0_shortcut_conv2d_param = spatconv_create();
	scale4_block0_shortcut_conv2d_param->pout = 256;
	scale4_block0_shortcut_conv2d_param->pin = 128;
	scale4_block0_shortcut_conv2d_param->kern_s[0] = 256;
	scale4_block0_shortcut_conv2d_param->kern_s[1] = 128;
	scale4_block0_shortcut_conv2d_param->kern_s[2] = 3;
	scale4_block0_shortcut_conv2d_param->kern_s[3] = 3;
	
        if (scale4_block0_shortcut_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale4_block0_shortcut_conv2d_param->pin/minIF;
        if (scale4_block0_shortcut_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale4_block0_shortcut_conv2d_param->pout/minOF;
        if (scale4_block0_shortcut_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 315392
	// original weight shape = 256 x 128 x 3 x 3;
	sprintf(filename, "%s/scale4_block0_shortcut_conv2d_weights_array_file", load_data_dir);
	scale4_block0_shortcut_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale4_block0_shortcut_conv2d_param->kernel);
	
	SIZE scale4_block0_shortcut_conv2d_bias_dim = 256;
	scale4_block0_shortcut_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale4_block0_shortcut_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale4_block0_shortcut_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale4_block0_shortcut_conv2d_bias_dim,scale4_block0_shortcut_conv2d_param->bias);
	
	SIZE scale4_block0_shortcut_conv2d_dim = 256 * 14 * 14;
	
	
	/*
	 * Convolution layer
	 * IF = 128 x 28 x 28 --> OF = 256 x 14 x 14
	 * W 256 x 128 x 3 x 3
	 * Pad    1x1
	 * Stride 2x2
	 */
	scale4_block0_A_conv2d_param = spatconv_create();
	scale4_block0_A_conv2d_param->pout = 256;
	scale4_block0_A_conv2d_param->pin = 128;
	scale4_block0_A_conv2d_param->kern_s[0] = 256;
	scale4_block0_A_conv2d_param->kern_s[1] = 128;
	scale4_block0_A_conv2d_param->kern_s[2] = 3;
	scale4_block0_A_conv2d_param->kern_s[3] = 3;
	
        if (scale4_block0_A_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale4_block0_A_conv2d_param->pin/minIF;
        if (scale4_block0_A_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale4_block0_A_conv2d_param->pout/minOF;
        if (scale4_block0_A_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 315392
	// original weight shape = 256 x 128 x 3 x 3;
	sprintf(filename, "%s/scale4_block0_A_conv2d_weights_array_file", load_data_dir);
	scale4_block0_A_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale4_block0_A_conv2d_param->kernel);
	
	SIZE scale4_block0_A_conv2d_bias_dim = 256;
	scale4_block0_A_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale4_block0_A_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale4_block0_A_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale4_block0_A_conv2d_bias_dim,scale4_block0_A_conv2d_param->bias);
	
	SIZE scale4_block0_A_conv2d_dim = 256 * 14 * 14;
	
	
	/*
	 * Convolution layer
	 * IF = 256 x 14 x 14 --> OF = 256 x 14 x 14
	 * W 256 x 256 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	scale4_block0_B_conv2d_param = spatconv_create();
	scale4_block0_B_conv2d_param->pout = 256;
	scale4_block0_B_conv2d_param->pin = 256;
	scale4_block0_B_conv2d_param->kern_s[0] = 256;
	scale4_block0_B_conv2d_param->kern_s[1] = 256;
	scale4_block0_B_conv2d_param->kern_s[2] = 3;
	scale4_block0_B_conv2d_param->kern_s[3] = 3;
	
        if (scale4_block0_B_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale4_block0_B_conv2d_param->pin/minIF;
        if (scale4_block0_B_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale4_block0_B_conv2d_param->pout/minOF;
        if (scale4_block0_B_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 630784
	// original weight shape = 256 x 256 x 3 x 3;
	sprintf(filename, "%s/scale4_block0_B_conv2d_weights_array_file", load_data_dir);
	scale4_block0_B_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale4_block0_B_conv2d_param->kernel);
	
	SIZE scale4_block0_B_conv2d_bias_dim = 256;
	scale4_block0_B_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale4_block0_B_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale4_block0_B_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale4_block0_B_conv2d_bias_dim,scale4_block0_B_conv2d_param->bias);
	
	SIZE scale4_block0_B_conv2d_dim = 256 * 14 * 14;
	
	
	
	/*
	 * Convolution layer
	 * IF = 256 x 14 x 14 --> OF = 256 x 14 x 14
	 * W 256 x 256 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	scale4_block1_A_conv2d_param = spatconv_create();
	scale4_block1_A_conv2d_param->pout = 256;
	scale4_block1_A_conv2d_param->pin = 256;
	scale4_block1_A_conv2d_param->kern_s[0] = 256;
	scale4_block1_A_conv2d_param->kern_s[1] = 256;
	scale4_block1_A_conv2d_param->kern_s[2] = 3;
	scale4_block1_A_conv2d_param->kern_s[3] = 3;
	
        if (scale4_block1_A_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale4_block1_A_conv2d_param->pin/minIF;
        if (scale4_block1_A_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale4_block1_A_conv2d_param->pout/minOF;
        if (scale4_block1_A_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 630784
	// original weight shape = 256 x 256 x 3 x 3;
	sprintf(filename, "%s/scale4_block1_A_conv2d_weights_array_file", load_data_dir);
	scale4_block1_A_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale4_block1_A_conv2d_param->kernel);
	
	SIZE scale4_block1_A_conv2d_bias_dim = 256;
	scale4_block1_A_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale4_block1_A_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale4_block1_A_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale4_block1_A_conv2d_bias_dim,scale4_block1_A_conv2d_param->bias);
	
	SIZE scale4_block1_A_conv2d_dim = 256 * 14 * 14;
	
	
	/*
	 * Convolution layer
	 * IF = 256 x 14 x 14 --> OF = 256 x 14 x 14
	 * W 256 x 256 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	scale4_block1_B_conv2d_param = spatconv_create();
	scale4_block1_B_conv2d_param->pout = 256;
	scale4_block1_B_conv2d_param->pin = 256;
	scale4_block1_B_conv2d_param->kern_s[0] = 256;
	scale4_block1_B_conv2d_param->kern_s[1] = 256;
	scale4_block1_B_conv2d_param->kern_s[2] = 3;
	scale4_block1_B_conv2d_param->kern_s[3] = 3;
	
        if (scale4_block1_B_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale4_block1_B_conv2d_param->pin/minIF;
        if (scale4_block1_B_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale4_block1_B_conv2d_param->pout/minOF;
        if (scale4_block1_B_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 630784
	// original weight shape = 256 x 256 x 3 x 3;
	sprintf(filename, "%s/scale4_block1_B_conv2d_weights_array_file", load_data_dir);
	scale4_block1_B_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale4_block1_B_conv2d_param->kernel);
	
	SIZE scale4_block1_B_conv2d_bias_dim = 256;
	scale4_block1_B_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale4_block1_B_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale4_block1_B_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale4_block1_B_conv2d_bias_dim,scale4_block1_B_conv2d_param->bias);
	
	SIZE scale4_block1_B_conv2d_dim = 256 * 14 * 14;
	
	
	
	/*
	 * Convolution layer
	 * IF = 256 x 14 x 14 --> OF = 512 x 7 x 7
	 * W 512 x 256 x 3 x 3
	 * Pad    1x1
	 * Stride 2x2
	 */
	scale5_block0_shortcut_conv2d_param = spatconv_create();
	scale5_block0_shortcut_conv2d_param->pout = 512;
	scale5_block0_shortcut_conv2d_param->pin = 256;
	scale5_block0_shortcut_conv2d_param->kern_s[0] = 512;
	scale5_block0_shortcut_conv2d_param->kern_s[1] = 256;
	scale5_block0_shortcut_conv2d_param->kern_s[2] = 3;
	scale5_block0_shortcut_conv2d_param->kern_s[3] = 3;
	
        if (scale5_block0_shortcut_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale5_block0_shortcut_conv2d_param->pin/minIF;
        if (scale5_block0_shortcut_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale5_block0_shortcut_conv2d_param->pout/minOF;
        if (scale5_block0_shortcut_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 1261568
	// original weight shape = 512 x 256 x 3 x 3;
	sprintf(filename, "%s/scale5_block0_shortcut_conv2d_weights_array_file", load_data_dir);
	scale5_block0_shortcut_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale5_block0_shortcut_conv2d_param->kernel);
	
	SIZE scale5_block0_shortcut_conv2d_bias_dim = 512;
	scale5_block0_shortcut_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale5_block0_shortcut_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale5_block0_shortcut_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale5_block0_shortcut_conv2d_bias_dim,scale5_block0_shortcut_conv2d_param->bias);
	
	SIZE scale5_block0_shortcut_conv2d_dim = 512 * 7 * 7;
	
	
	/*
	 * Convolution layer
	 * IF = 256 x 14 x 14 --> OF = 512 x 7 x 7
	 * W 512 x 256 x 3 x 3
	 * Pad    1x1
	 * Stride 2x2
	 */
	scale5_block0_A_conv2d_param = spatconv_create();
	scale5_block0_A_conv2d_param->pout = 512;
	scale5_block0_A_conv2d_param->pin = 256;
	scale5_block0_A_conv2d_param->kern_s[0] = 512;
	scale5_block0_A_conv2d_param->kern_s[1] = 256;
	scale5_block0_A_conv2d_param->kern_s[2] = 3;
	scale5_block0_A_conv2d_param->kern_s[3] = 3;
	
        if (scale5_block0_A_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale5_block0_A_conv2d_param->pin/minIF;
        if (scale5_block0_A_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale5_block0_A_conv2d_param->pout/minOF;
        if (scale5_block0_A_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 1261568
	// original weight shape = 512 x 256 x 3 x 3;
	sprintf(filename, "%s/scale5_block0_A_conv2d_weights_array_file", load_data_dir);
	scale5_block0_A_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale5_block0_A_conv2d_param->kernel);
	
	SIZE scale5_block0_A_conv2d_bias_dim = 512;
	scale5_block0_A_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale5_block0_A_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale5_block0_A_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale5_block0_A_conv2d_bias_dim,scale5_block0_A_conv2d_param->bias);
	
	SIZE scale5_block0_A_conv2d_dim = 512 * 7 * 7;
	
	
	/*
	 * Convolution layer
	 * IF = 512 x 7 x 7 --> OF = 512 x 7 x 7
	 * W 512 x 512 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	scale5_block0_B_conv2d_param = spatconv_create();
	scale5_block0_B_conv2d_param->pout = 512;
	scale5_block0_B_conv2d_param->pin = 512;
	scale5_block0_B_conv2d_param->kern_s[0] = 512;
	scale5_block0_B_conv2d_param->kern_s[1] = 512;
	scale5_block0_B_conv2d_param->kern_s[2] = 3;
	scale5_block0_B_conv2d_param->kern_s[3] = 3;
	
        if (scale5_block0_B_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale5_block0_B_conv2d_param->pin/minIF;
        if (scale5_block0_B_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale5_block0_B_conv2d_param->pout/minOF;
        if (scale5_block0_B_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 2465792
	// original weight shape = 512 x 512 x 3 x 3;
	sprintf(filename, "%s/scale5_block0_B_conv2d_weights_array_file", load_data_dir);
	scale5_block0_B_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale5_block0_B_conv2d_param->kernel);
	
	SIZE scale5_block0_B_conv2d_bias_dim = 512;
	scale5_block0_B_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale5_block0_B_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale5_block0_B_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale5_block0_B_conv2d_bias_dim,scale5_block0_B_conv2d_param->bias);
	
	SIZE scale5_block0_B_conv2d_dim = 512 * 7 * 7;
	
	
	
	/*
	 * Convolution layer
	 * IF = 512 x 7 x 7 --> OF = 512 x 7 x 7
	 * W 512 x 512 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	scale5_block1_A_conv2d_param = spatconv_create();
	scale5_block1_A_conv2d_param->pout = 512;
	scale5_block1_A_conv2d_param->pin = 512;
	scale5_block1_A_conv2d_param->kern_s[0] = 512;
	scale5_block1_A_conv2d_param->kern_s[1] = 512;
	scale5_block1_A_conv2d_param->kern_s[2] = 3;
	scale5_block1_A_conv2d_param->kern_s[3] = 3;
	
        if (scale5_block1_A_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale5_block1_A_conv2d_param->pin/minIF;
        if (scale5_block1_A_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale5_block1_A_conv2d_param->pout/minOF;
        if (scale5_block1_A_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 2465792
	// original weight shape = 512 x 512 x 3 x 3;
	sprintf(filename, "%s/scale5_block1_A_conv2d_weights_array_file", load_data_dir);
	scale5_block1_A_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale5_block1_A_conv2d_param->kernel);
	
	SIZE scale5_block1_A_conv2d_bias_dim = 512;
	scale5_block1_A_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale5_block1_A_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale5_block1_A_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale5_block1_A_conv2d_bias_dim,scale5_block1_A_conv2d_param->bias);
	
	SIZE scale5_block1_A_conv2d_dim = 512 * 7 * 7;
	
	
	/*
	 * Convolution layer
	 * IF = 512 x 7 x 7 --> OF = 512 x 7 x 7
	 * W 512 x 512 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	scale5_block1_B_conv2d_param = spatconv_create();
	scale5_block1_B_conv2d_param->pout = 512;
	scale5_block1_B_conv2d_param->pin = 512;
	scale5_block1_B_conv2d_param->kern_s[0] = 512;
	scale5_block1_B_conv2d_param->kern_s[1] = 512;
	scale5_block1_B_conv2d_param->kern_s[2] = 3;
	scale5_block1_B_conv2d_param->kern_s[3] = 3;
	
        if (scale5_block1_B_conv2d_param->kern_s[2] == 3)
          minIF=_NCOL_*3;
        else 
          minIF=_NCOL_;	

        minOF=_NROW_;
        
        IG= scale5_block1_B_conv2d_param->pin/minIF;
        if (scale5_block1_B_conv2d_param->pin%minIF)
          IG++;
        
        OG= scale5_block1_B_conv2d_param->pout/minOF;
        if (scale5_block1_B_conv2d_param->pout%minOF)
          OG++;
          
        wsize=IG*OG*_NROW_*_NCOL_*ELEM_PER_WS;  
        
        
	// preprocessed weight dim = 2465792
	// original weight shape = 512 x 512 x 3 x 3;
	sprintf(filename, "%s/scale5_block1_B_conv2d_weights_array_file", load_data_dir);
	scale5_block1_B_conv2d_param->kernel = (DATA*)neu_DDRmalloc(wsize*sizeof(DATA));
	load_fixed(filename,wsize,scale5_block1_B_conv2d_param->kernel);
	
	SIZE scale5_block1_B_conv2d_bias_dim = 512;
	scale5_block1_B_conv2d_param->bias = (DATA*)neu_DDRmalloc(scale5_block1_B_conv2d_bias_dim*sizeof(DATA));;
	sprintf(filename, "%s/scale5_block1_B_conv2d_bias_array_file", load_data_dir);
	load_fixed(filename,scale5_block1_B_conv2d_bias_dim,scale5_block1_B_conv2d_param->bias);
	
	SIZE scale5_block1_B_conv2d_dim = 512 * 7 * 7;
	
	
	SIZE avg_pool_dim = 512 * 1 * 1;
	
	
	/*
	 * Fully-connected layer
	 * num outputs = 1000
	 * W 1000 x 512
	 * X 512 x 1
	 */
	SIZE xw_plus_b_MatMul_dim = 1000;
	xw_plus_b_MatMul_param = linear_fp16_create();
	xw_plus_b_MatMul_param->out_s = 1000;
	xw_plus_b_MatMul_param->in_s = avg_pool_dim;
	static DATA xw_plus_b_MatMul_weights_array[512000];
	sprintf(filename, "%s/xw_plus_b_MatMul_weights_array_file", load_data_dir);
	load_fixed(filename,512000,xw_plus_b_MatMul_weights_array);
	xw_plus_b_MatMul_param->weights = xw_plus_b_MatMul_weights_array;
	static DATA xw_plus_b_MatMul_bias_array[1000];
	sprintf(filename, "%s/xw_plus_b_MatMul_bias_array_file", load_data_dir);
	load_fixed(filename,1000,xw_plus_b_MatMul_bias_array);
	xw_plus_b_MatMul_param->bias = xw_plus_b_MatMul_bias_array;
	
	
	
	scale1_conv2d_5x5_0_param->maxog    = 4;
	scale1_conv2d_5x5_1_param->maxog    = 4;
	scale1_conv2d_5x5_2_param->maxog    = 4;
	scale1_conv2d_5x5_3_param->maxog    = 4;
	
	scale2_block0_A_conv2d_param->maxog = 4;
	scale2_block0_B_conv2d_param->maxog = 4;
	scale2_block1_A_conv2d_param->maxog = 4;
	scale2_block1_B_conv2d_param->maxog = 4;
	
	scale3_block0_shortcut_conv2d_param->maxog = 4;
	scale3_block0_A_conv2d_param->maxog = 4;
	scale3_block0_B_conv2d_param->maxog = 4;
	scale3_block1_A_conv2d_param->maxog = 4;
	scale3_block1_B_conv2d_param->maxog = 4;
	
	scale4_block0_shortcut_conv2d_param->maxog = 4;
	scale4_block0_A_conv2d_param->maxog = 4;
	scale4_block0_B_conv2d_param->maxog = 4;
	scale4_block1_A_conv2d_param->maxog = 4;
	scale4_block1_B_conv2d_param->maxog = 4;
	
	scale5_block0_shortcut_conv2d_param->maxog = 4;
	scale5_block0_A_conv2d_param->maxog = 4;
	scale5_block0_B_conv2d_param->maxog = 4;
	scale5_block1_A_conv2d_param->maxog = 4;
	scale5_block1_B_conv2d_param->maxog = 4;
	
	
}

void round4(DATA* dest, DATA* src, int KS, int n_feat, int height, int width){
  
  int n_feat_round;
  int min_feat;
  int i;
  
  if (KS==5)
    min_feat=_NCOL_;
  else
    min_feat=_NCOL_*3;
    
  n_feat_round = n_feat/min_feat;
  if (n_feat%min_feat>0)
   n_feat_round++;
  n_feat_round= n_feat_round *min_feat;
  
   
  for (i=0; i < n_feat_round*height*width;i++)
    if (i<n_feat*height*width)
      dest[i]=src[i];
    else
      dest[i]=0;
}


RET place_zeros_nointer(uint32_t* data, SIZE out_s[3])
{
  _tcreate_(time);

  int step = 1;
  int tot_rows = out_s[1];
  int of = out_s[0];

  int int_per_row = out_s[2]/2 + 1;

  uint32_t* ptr;
  for(int row=0; row < tot_rows*of; row++){
    ptr = data + step * (row*int_per_row + int_per_row-1); 
    *(ptr)   = *(ptr)   & 0x0000FFFFU;
  }
  }
/*

 ██████╗███╗   ██╗███╗   ██╗    ███████╗██╗  ██╗███████╗ ██████╗
██╔════╝████╗  ██║████╗  ██║    ██╔════╝╚██╗██╔╝██╔════╝██╔════╝
██║     ██╔██╗ ██║██╔██╗ ██║    █████╗   ╚███╔╝ █████╗  ██║     
██║     ██║╚██╗██║██║╚██╗██║    ██╔══╝   ██╔██╗ ██╔══╝  ██║     
╚██████╗██║ ╚████║██║ ╚████║    ███████╗██╔╝ ██╗███████╗╚██████╗
 ╚═════╝╚═╝  ╚═══╝╚═╝  ╚═══╝    ╚══════╝╚═╝  ╚═╝╚══════╝ ╚═════╝
                                                                
*/

void down_sampling(int16_t* output, int16_t* input, SIZE out_s[3], SIZE in_s[3], SIZE stride[2])
{
  int xi, yi, xo, yo, feat;
  xo=0;
  yo=0;
  for (feat=0; feat < in_s[0];feat++){
    yo=0;
    for (yi=0; yi<in_s[2];yi+=stride[2]){
      xo=0;
      for (xi=0; xi<in_s[1];xi+=stride[1]){
        output[feat*out_s[1]*out_s[2] + yo*out_s[1] + xo] = input [feat*in_s[1]*in_s[2] + yi*in_s[1] + xi];
        xo++;
      }
      yo++;
    }
  }
      
    


}


void cnnMain(DATA* image, float* results)
{

        SOCMAP soc = socs[0];

	double time;
	SIZE batch_join_size[] = { 3, 224, 224 };
	SIZE batch_join_dim = 3 * 224 * 224;
	DATA* batch_join_output = image;

	int job_id = 0;
	int job_id_sc = 0;

	SIZE scale1_conv2d_padding_size[] = { 3, 226, 226 };
	SIZE scale1_conv2d_padding_dim = 3 * 226 * 226;
	static DATA scale1_conv2d_padding_output[scale1_conv2d_padding_dim];
	SIZE scale1_conv2d_padding_pad[] = { 1, 1 };
	
	zero_pad(batch_join_output, scale1_conv2d_padding_output, batch_join_size, scale1_conv2d_padding_pad);
     
   /*
██████╗          ██╗       ██████╗ ██╗  ██╗            ███████╗██╗  ██╗███████╗
╚════██╗         ╚██╗     ██╔════╝ ██║  ██║            ╚════██║╚██╗██╔╝╚════██║
 █████╔╝    █████╗╚██╗    ███████╗ ███████║                ██╔╝ ╚███╔╝     ██╔╝
 ╚═══██╗    ╚════╝██╔╝    ██╔═══██╗╚════██║               ██╔╝  ██╔██╗    ██╔╝ 
██████╔╝         ██╔╝     ╚██████╔╝     ██║               ██║  ██╔╝ ██╗   ██║  
╚═════╝          ╚═╝       ╚═════╝      ╚═╝               ╚═╝  ╚═╝  ╚═╝   ╚═╝  
                                                                               
*/  
     
	/*
	 * Convolution layer
	 * IF = 3 x 226 x 226 --> OF = 64 x 113 x 113
	 * W 64 x 3 x 7 x 7
	 * Pad    2x2
	 * Stride 2x2
	 */
	
	SIZE scale1_conv2d_merge_size[] = { 64, 112, 112 };
	SIZE scale1_conv2d_merge_stride[] = { 2, 2 };
	SIZE scale1_conv2d_merge_pad[] = { 2, 2 };
	SIZE scale1_conv2d_merge_dim = 64 * 112 * 112;

	SIZE scale1_conv2d_5x5_out[] = { 64, 113, 114 };
	SIZE scale1_conv2d_5x5_outo[] = { 64, 226, 226 };
	SIZE scale1_conv2d_5x5_out_dim = 64 * 113 * 114;
	SIZE _stride[2] = {1,1};
	int conv_id[4] = {0};

	static DATA scale1_conv2d_5x5_0_tmp[scale1_conv2d_5x5_out_dim];
	static DATA scale1_conv2d_5x5_1_tmp[scale1_conv2d_5x5_out_dim];
	static DATA scale1_conv2d_5x5_2_tmp[scale1_conv2d_5x5_out_dim];
	static DATA scale1_conv2d_5x5_3_tmp[scale1_conv2d_5x5_out_dim];

	static DATA scale1_conv2d_5x5_0_output[scale1_conv2d_5x5_out_dim];
	static DATA scale1_conv2d_5x5_1_output[scale1_conv2d_5x5_out_dim];
	static DATA scale1_conv2d_5x5_2_output[scale1_conv2d_5x5_out_dim];
	static DATA scale1_conv2d_5x5_3_output[scale1_conv2d_5x5_out_dim];

	static DATA scale1_conv2d_merge_output[scale1_conv2d_merge_dim];

  	//SPATCONV scale1_conv2d_7x7as5x5[4] = {
    //	scale1_conv2d_5x5_0_param,
    //	scale1_conv2d_5x5_1_param,
    //	scale1_conv2d_5x5_2_param,
    //	scale1_conv2d_5x5_3_param,
  	//};

	
  	//spatconv_forward_big_hw(scale1_conv2d_7x7as5x5, 5,
    //                      soc->in, scale1_conv2d_merge_output, soc,
    //                      scale1_conv2d_padding_size,
    //                      scale1_conv2d_merge_size,
    //                      scale1_conv2d_merge_stride,
    //                      scale1_conv2d_merge_pad,
    //                      true);

	
	printf ("round4\n");
	round4 (soc->in, scale1_conv2d_padding_output, 5, 3, 226, 226);
  printf ("round4 done\n");
  
  _tprintf_("CHECKSUM round4: %lld \n", checksum(soc->in, 226*226*3));   
	
	time = get_wall_time();
	
       // print_data(scale1_conv2d_5x5_0_param->kernel, 1000, "./w.txt");
       
       // print_data(scale1_conv2d_5x5_0_param->kernel, 32, "./wc0_16bit.txt");
	conv_id[0] = spatconv_forward_hw(scale1_conv2d_5x5_0_param, soc->in, scale1_conv2d_5x5_0_out, soc, scale1_conv2d_padding_size, scale1_conv2d_5x5_out, _stride, scale1_conv2d_merge_pad, false, _QF_, PRECISION8);        
	conv_id[1] = spatconv_forward_hw(scale1_conv2d_5x5_1_param, soc->in, scale1_conv2d_5x5_1_out, soc, scale1_conv2d_padding_size, scale1_conv2d_5x5_out, _stride, scale1_conv2d_merge_pad, false, _QF_, PRECISION8);
	conv_id[2] = spatconv_forward_hw(scale1_conv2d_5x5_2_param, soc->in, scale1_conv2d_5x5_2_out, soc, scale1_conv2d_padding_size, scale1_conv2d_5x5_out, _stride, scale1_conv2d_merge_pad, false, _QF_, PRECISION8);
	conv_id[3] = spatconv_forward_hw(scale1_conv2d_5x5_3_param, soc->in, scale1_conv2d_5x5_3_out, soc, scale1_conv2d_padding_size, scale1_conv2d_5x5_out, _stride, scale1_conv2d_merge_pad, false, _QF_, PRECISION8);
  
   
    #pragma omp parallel shared(conv_id)
    {
    	#pragma omp single
    	{
	    	#pragma omp task
	    	{
		    	spatconv_wait(soc, conv_id[0]);
		    	down_sampling(scale1_conv2d_5x5_0_out, scale1_conv2d_5x5_0_out,scale1_conv2d_5x5_out , scale1_conv2d_5x5_outo, scale1_conv2d_merge_stride);
printf ("wwww");
	    //	        memcpy(scale1_conv2d_5x5_0_output, scale1_conv2d_5x5_0_out, scale1_conv2d_5x5_out_dim*sizeof(DATA));
	    
  _tprintf_("CHECKSUM scale1_conv2d_5x5_0_out: %lld \n", checksum(scale1_conv2d_5x5_0_out, scale1_conv2d_5x5_out_dim)); 
	    	}

	    	#pragma omp task
	    	{
	    		spatconv_wait(soc, conv_id[1]);
		    	down_sampling(scale1_conv2d_5x5_1_out, scale1_conv2d_5x5_1_out,  scale1_conv2d_5x5_out,scale1_conv2d_5x5_outo, scale1_conv2d_merge_stride);
printf ("eee");
	  //  		memcpy(scale1_conv2d_5x5_1_output, scale1_conv2d_5x5_1_out, scale1_conv2d_5x5_out_dim*sizeof(DATA));
	    _tprintf_("CHECKSUM scale1_conv2d_5x5_1_out: %lld \n", checksum(scale1_conv2d_5x5_1_out, scale1_conv2d_5x5_out_dim));
			}

			#pragma omp task
			{
	    		spatconv_wait(soc, conv_id[2]);
		    	down_sampling(scale1_conv2d_5x5_2_out, scale1_conv2d_5x5_2_out,  scale1_conv2d_5x5_out,scale1_conv2d_5x5_outo, scale1_conv2d_merge_stride);
printf ("rrr");
	  //  		memcpy(scale1_conv2d_5x5_2_output, scale1_conv2d_5x5_2_out, scale1_conv2d_5x5_out_dim*sizeof(DATA));
	    		_tprintf_("CHECKSUM scale1_conv2d_5x5_2_out: %lld \n", checksum(scale1_conv2d_5x5_2_out, scale1_conv2d_5x5_out_dim));
			}

			#pragma omp task
			{
	    		spatconv_wait(soc, conv_id[3]);
		    	down_sampling(scale1_conv2d_5x5_3_out, scale1_conv2d_5x5_3_out, scale1_conv2d_5x5_out,scale1_conv2d_5x5_outo,  scale1_conv2d_merge_stride);
printf ("fff");
	 //   		memcpy(scale1_conv2d_5x5_3_output, scale1_conv2d_5x5_3_out, scale1_conv2d_5x5_out_dim*sizeof(DATA));
	  _tprintf_("CHECKSUM scale1_conv2d_5x5_3_out: %lld \n", checksum(scale1_conv2d_5x5_3_out, scale1_conv2d_5x5_out_dim));
			}
		}
	}
	
	
	
	/*
███╗   ███╗███████╗██████╗  ██████╗ ███████╗
████╗ ████║██╔════╝██╔══██╗██╔════╝ ██╔════╝
██╔████╔██║█████╗  ██████╔╝██║  ███╗█████╗  
██║╚██╔╝██║██╔══╝  ██╔══██╗██║   ██║██╔══╝  
██║ ╚═╝ ██║███████╗██║  ██║╚██████╔╝███████╗
╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
                                            
*/


printf ("aaaaaaaaaaaaaa");

	DATA* scale1_conv2d_merge_inputs[4] = { scale1_conv2d_5x5_0_out, scale1_conv2d_5x5_1_out, scale1_conv2d_5x5_2_out, scale1_conv2d_5x5_3_out };
	spatconv_merge_hw(scale1_conv2d_merge_output, scale1_conv2d_merge_inputs, scale1_conv2d_merge_size, 5, scale1_conv2d_merge_stride, true, _QF_);
	
	
	
	_tprintf_("7x7 Conv time: %5.3f ms\n", (get_wall_time()-time)/1000);

  	// printf("CHECK: %lld \n", checksum(scale1_conv2d_merge_output, scale1_conv2d_merge_dim));
_tprintf_("CHECKSUM scale1_conv2d_merge_inputs: %lld \n", checksum(scale1_conv2d_merge_output, scale1_conv2d_merge_dim));


	//DATA* scale1_Relu_output = (DATA *) calloc(scale1_conv2d_merge_dim, sizeof(DATA));
	//relu_forward(scale1_conv2d_merge_output, scale1_Relu_output, scale1_conv2d_merge_size);
	
	
	//relu_forward(scale1_conv2d_merge_output, scale1_Relu_output, scale1_conv2d_merge_size);
	SIZE scale2_max_pool_size[]   = { 64, 56, 56 };
	SIZE scale2_max_pool_dim      = 64 * 56 * 56;
	SIZE scale2_max_pool_filter[] = { 3, 3 };
	SIZE scale2_max_pool_stride[] = { 2, 2 };
	SIZE scale2_max_pool_pad[]    = { 1, 1 };
	
	
	/*
███╗   ███╗ █████╗ ██╗  ██╗██████╗  ██████╗  ██████╗ ██╗     
████╗ ████║██╔══██╗╚██╗██╔╝██╔══██╗██╔═══██╗██╔═══██╗██║     
██╔████╔██║███████║ ╚███╔╝ ██████╔╝██║   ██║██║   ██║██║     
██║╚██╔╝██║██╔══██║ ██╔██╗ ██╔═══╝ ██║   ██║██║   ██║██║     
██║ ╚═╝ ██║██║  ██║██╔╝ ██╗██║     ╚██████╔╝╚██████╔╝███████╗
╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝      ╚═════╝  ╚═════╝ ╚══════╝
                                                             
*/
	maxpool_fp16_forward(scale1_conv2d_merge_output, soc->in, scale1_conv2d_merge_size, scale2_max_pool_size, scale2_max_pool_filter, scale2_max_pool_stride, scale2_max_pool_pad);
	
	printf ("pooling done\n");
	
	//printf("CHECK: %lld \n", checksum(scale2_max_pool_output, scale2_max_pool_dim));
_tprintf_("CHECKSUM scale1_conv2d_merge_inputs: %lld \n", checksum(soc->in, scale2_max_pool_dim));
	
	printf ("aaaaaaaaaaaaaa");
	/*
	 * Convolution layer
	 * IF = 64 x 56 x 56 --> OF = 64 x 56 x 56
	 * W 64 x 64 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	SIZE scale2_block0_A_conv2d_size[] = { 64, 56, 56 };
	SIZE scale2_block0_A_conv2d_dim = 64 * 56 * 56;
	// scale2_block0_A_conv2d_dim = 200704
	SIZE scale2_block0_A_conv2d_stride[] = { 1, 1 };
	SIZE scale2_block0_A_conv2d_pad[] = { 1, 1 };
	
	
	spatconv_forward_hw(scale2_block0_A_conv2d_param, soc->in, soc->out, soc, scale2_max_pool_size, scale2_block0_A_conv2d_size, scale2_block0_A_conv2d_stride, scale2_block0_A_conv2d_pad, true, _QF_, PRECISION8);
	SIZE scale2_block0_A_conv2d_output_scale2_block0_A_conv2d_output_dstride[] = { 1, 1 };
	
	memcpy(scale2_block0_Shortcut, soc->in, scale2_block0_A_conv2d_dim*sizeof(DATA));
	
	/*
	 * Convolution layer
	 * IF = 64 x 56 x 56 --> OF = 64 x 56 x 56
	 * W 64 x 64 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	SIZE scale2_block0_B_conv2d_size[] = { 64, 56, 56 };
	SIZE scale2_block0_B_conv2d_dim = 64 * 56 * 56;
	// scale2_block0_B_conv2d_dim = 200704
	SIZE scale2_block0_B_conv2d_stride[] = { 1, 1 };
	SIZE scale2_block0_B_conv2d_pad[] = { 1, 1 };
	
	soc->in = (DATA*)((uintptr_t)soc->in ^ (uintptr_t)soc->out);
	soc->out = (DATA*)((uintptr_t)soc->out ^ (uintptr_t)soc->in);
	soc->in = (DATA*)((uintptr_t)soc->in ^ (uintptr_t)soc->out);
	SIZE scale2_block0_B_conv2d_scale2_max_pool_output_dstride[] = { 1, 1 };
	
	job_id = spatconv_forward_hw(scale2_block0_B_conv2d_param, soc->in, soc->out, soc, scale2_block0_A_conv2d_size, scale2_block0_B_conv2d_size, scale2_block0_B_conv2d_stride, scale2_block0_B_conv2d_pad,false, _QF_, PRECISION8);
	
	SIZE scale2_block0_B_conv2d_output_scale2_block0_B_conv2d_output_dstride[] = { 1, 1 };
	
	spatconv_wait(soc, job_id);

	 
   // memcpy(scale2_block0_B_conv2d_output, soc->out, scale2_block0_B_conv2d_dim*sizeof(DATA));
    add_fp16_forward_wR(scale2_block0_Shortcut, soc->out, soc->in, scale2_max_pool_size);
    //add_fp16_forward_wR(scale2_block0_Shortcut, soc->out, soc->in, scale2_max_pool_size);
   // memcpy(soc->in, scale2_block0_Residual_Add_Add_output, scale2_block0_A_conv2d_dim*sizeof(DATA));
	
	
_tprintf_("CHECKSUM add_fp16_forward_wR: %lld \n", checksum(soc->in, scale2_max_pool_dim));
	
	
	
	/*
	 * Convolution layer
	 * IF = 64 x 56 x 56 --> OF = 64 x 56 x 56
	 * W 64 x 64 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	SIZE scale2_block1_A_conv2d_size[] = { 64, 56, 56 };
	SIZE scale2_block1_A_conv2d_dim = 64 * 56 * 56;
	// scale2_block1_A_conv2d_dim = 200704
	SIZE scale2_block1_A_conv2d_stride[] = { 1, 1 };
	SIZE scale2_block1_A_conv2d_pad[] = { 1, 1 };
	
	
	//time = get_wall_time();
	//memcpy(scale2_block1_Shortcut, soc->in, scale2_block0_B_conv2d_dim*sizeof(DATA));
	//_tprintf_("\tmemcpy: %5.3f ms\n", (get_wall_time()-time)/1000);

	spatconv_forward_hw(scale2_block1_A_conv2d_param, soc->in, soc->out, soc, scale2_block0_B_conv2d_size, scale2_block1_A_conv2d_size, scale2_block1_A_conv2d_stride, scale2_block1_A_conv2d_pad, true, _QF_, PRECISION8);
	SIZE scale2_block1_A_conv2d_output_scale2_block1_A_conv2d_output_dstride[] = { 1, 1 };
	
	
	/*
	 * Convolution layer
	 * IF = 64 x 56 x 56 --> OF = 64 x 56 x 56
	 * W 64 x 64 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	SIZE scale2_block1_B_conv2d_size[] = { 64, 56, 56 };
	SIZE scale2_block1_B_conv2d_dim = 64 * 56 * 56;
	// scale2_block1_B_conv2d_dim = 200704
	SIZE scale2_block1_B_conv2d_stride[] = { 1, 1 };
	SIZE scale2_block1_B_conv2d_pad[] = { 1, 1 };
	
	soc->in = (DATA*)((uintptr_t)soc->in ^ (uintptr_t)soc->out);
	soc->out = (DATA*)((uintptr_t)soc->out ^ (uintptr_t)soc->in);
	soc->in = (DATA*)((uintptr_t)soc->in ^ (uintptr_t)soc->out);
	SIZE scale2_block1_B_conv2d_scale2_block0_Residual_Add_Add_output_dstride[] = { 1, 1 };
	memcpy(scale2_block0_Residual_Add_Add_output, soc->out, scale2_block1_B_conv2d_dim*sizeof(DATA));
	      
	job_id = spatconv_forward_hw(scale2_block1_B_conv2d_param, soc->in, soc->out, soc, scale2_block1_A_conv2d_size, scale2_block1_B_conv2d_size, scale2_block1_B_conv2d_stride, scale2_block1_B_conv2d_pad, false, _QF_, PRECISION8);
  
	SIZE scale2_block1_B_conv2d_output_scale2_block1_B_conv2d_output_dstride[] = { 1, 1 };
	
	spatconv_wait(soc, job_id);
		
	
	memcpy(scale2_block1_B_conv2d_output, soc->out, scale2_block1_B_conv2d_dim*sizeof(DATA));	
	add_fp16_forward_wR(scale2_block0_Residual_Add_Add_output, scale2_block1_B_conv2d_output, scale2_block1_Residual_Add_Add_output, scale2_block1_B_conv2d_size);
	memcpy(soc->in, scale2_block1_Residual_Add_Add_output, scale2_block0_B_conv2d_dim*sizeof(DATA));
	
	_tprintf_("CHECKSUM scale2_block0_Residual_Add_Add_output: %lld \n", checksum(scale2_block1_Residual_Add_Add_output, scale2_block1_B_conv2d_dim));

	
	/*
 ██████╗ ██╗  ██╗         ██╗       ██╗██████╗  █████╗ 
██╔════╝ ██║  ██║         ╚██╗     ███║╚════██╗██╔══██╗
███████╗ ███████║    █████╗╚██╗    ╚██║ █████╔╝╚█████╔╝
██╔═══██╗╚════██║    ╚════╝██╔╝     ██║██╔═══╝ ██╔══██╗
╚██████╔╝     ██║         ██╔╝      ██║███████╗╚█████╔╝
 ╚═════╝      ╚═╝         ╚═╝       ╚═╝╚══════╝ ╚════╝ 
                                                       
*/
    
	/*
	 * Convolution layer
	 * IF = 64 x 56 x 56 --> OF = 128 x 28 x 28
	 * W 128 x 64 x 3 x 3
	 * Pad    1x1
	 * Stride 2x2
	 */
	SIZE scale3_block0_shortcut_conv2d_size[] = { 128, 28, 28 };
	SIZE scale3_block0_shortcut_conv2d_sizeo[] = { 128, 56, 56 };
	SIZE scale3_block0_shortcut_conv2d_dim = 128 * 28 * 28;
	// scale3_block0_shortcut_conv2d_dim = 100352
	//SIZE scale3_block0_shortcut_conv2d_stride[] = { 2, 2 }; 
	SIZE scale3_block0_shortcut_conv2d_stride[] = { 1, 1 }; // HW pooling is disabled
	SIZE scale3_block0_shortcut_conv2d_pad[] = { 1, 1 };
	
	job_id_sc = spatconv_forward_hw(scale3_block0_shortcut_conv2d_param, soc->in, tmp_out, soc, scale2_block0_B_conv2d_size, scale3_block0_shortcut_conv2d_sizeo, _stride, scale3_block0_shortcut_conv2d_pad, false, _QF_, PRECISION8);
	SIZE scale3_block0_shortcut_conv2d_output_scale3_block0_shortcut_conv2d_output_dstride[] = { 1, 1 };
  spatconv_wait(soc, job_id_sc);
	down_sampling(tmp_out, tmp_out, scale3_block0_shortcut_conv2d_size,scale3_block0_shortcut_conv2d_sizeo,  scale1_conv2d_merge_stride);

	
    _tprintf_("CHECKSUM scale3_block0_shortcut_conv2d_param: %lld \n", checksum(tmp_out, scale3_block0_shortcut_conv2d_dim));

    
    
    
	/*
	 * Convolution layer
	 * IF = 64 x 56 x 56 --> OF = 128 x 28 x 28
	 * W 128 x 64 x 3 x 3
	 * Pad    1x1
	 * Stride 2x2
	 */
	SIZE scale3_block0_A_conv2d_size[] = { 128, 28, 28 };
	SIZE scale3_block0_A_conv2d_sizeo[] = { 128, 56, 56 };
	SIZE scale3_block0_A_conv2d_dim = 128 * 28 * 28;
	// scale3_block0_A_conv2d_dim = 100352
	//SIZE scale3_block0_A_conv2d_stride[] = { 2, 2 };
	SIZE scale3_block0_A_conv2d_stride[] = { 1, 1 };
	SIZE scale3_block0_A_conv2d_pad[] = { 1, 1 };
	
	job_id_sc=spatconv_forward_hw(scale3_block0_A_conv2d_param, soc->in, soc->out, soc, scale2_block0_B_conv2d_size, scale3_block0_A_conv2d_size, scale3_block0_A_conv2d_stride, scale3_block0_A_conv2d_pad, true, _QF_, PRECISION8);
	SIZE scale3_block0_A_conv2d_output_scale3_block0_A_conv2d_output_dstride[] = { 1, 1 };

	
	spatconv_wait(soc, job_id_sc);
	down_sampling(soc->out, soc->out, scale3_block0_A_conv2d_size,scale3_block0_A_conv2d_sizeo,  scale1_conv2d_merge_stride);

	/*
	 * Convolution layer
	 * IF = 128 x 28 x 28 --> OF = 128 x 28 x 28
	 * W 128 x 128 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	SIZE scale3_block0_B_conv2d_size[] = { 128, 28, 28 };
	SIZE scale3_block0_B_conv2d_dim = 128 * 28 * 28;
	// scale3_block0_B_conv2d_dim = 100352
	SIZE scale3_block0_B_conv2d_stride[] = { 1, 1 };
	SIZE scale3_block0_B_conv2d_pad[] = { 1, 1 };
	
	soc->in = (DATA*)((uintptr_t)soc->in ^ (uintptr_t)soc->out);
	soc->out = (DATA*)((uintptr_t)soc->out ^ (uintptr_t)soc->in);
	soc->in = (DATA*)((uintptr_t)soc->in ^ (uintptr_t)soc->out);
	job_id = spatconv_forward_hw(scale3_block0_B_conv2d_param, soc->in, soc->out, soc, scale3_block0_A_conv2d_size, scale3_block0_B_conv2d_size, scale3_block0_B_conv2d_stride, scale3_block0_B_conv2d_pad, false, _QF_, PRECISION8);
	SIZE scale3_block0_B_conv2d_output_scale3_block0_B_conv2d_output_dstride[] = { 1, 1 };
	
	spatconv_wait(soc, job_id_sc);
        memcpy(scale3_block0_Shortcut, tmp_out, scale3_block0_shortcut_conv2d_dim*sizeof(DATA));
	//memcpy(scale3_block0_Shortcut, tmp_out, scale3_block0_shortcut_conv2d_dim*sizeof(DATA));

	spatconv_wait(soc, job_id);

	memcpy(scale3_block0_B_conv2d_output, soc->out, scale3_block0_B_conv2d_dim*sizeof(DATA));
	add_fp16_forward_wR(scale3_block0_Shortcut, scale3_block0_B_conv2d_output, scale3_block0_Residual_Add_Add_output, scale3_block0_B_conv2d_size);

  memcpy(soc->in, scale3_block0_Residual_Add_Add_output, scale3_block0_B_conv2d_dim*sizeof(DATA));

	
	/*
	 * Convolution layer
	 * IF = 128 x 28 x 28 --> OF = 128 x 28 x 28
	 * W 128 x 128 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	SIZE scale3_block1_A_conv2d_size[] = { 128, 28, 28 };
	SIZE scale3_block1_A_conv2d_dim = 128 * 28 * 28;
	// scale3_block1_A_conv2d_dim = 100352
	SIZE scale3_block1_A_conv2d_stride[] = { 1, 1 };
	SIZE scale3_block1_A_conv2d_pad[] = { 1, 1 };
	
	
	//time = get_wall_time();
	//memcpy(scale3_block1_Shortcut, soc->in, scale3_block0_shortcut_conv2d_dim*sizeof(DATA));
	//_tprintf_("\tmemcpy: %5.3f ms\n", (get_wall_time()-time)/1000);

	spatconv_forward_hw(scale3_block1_A_conv2d_param, soc->in, soc->out, soc, scale3_block0_B_conv2d_size, scale3_block1_A_conv2d_size, scale3_block1_A_conv2d_stride, scale3_block1_A_conv2d_pad, true, _QF_, PRECISION8);
	SIZE scale3_block1_A_conv2d_output_scale3_block1_A_conv2d_output_dstride[] = { 1, 1 };
		
	
	
	/*
	 * Convolution layer
	 * IF = 128 x 28 x 28 --> OF = 128 x 28 x 28
	 * W 128 x 128 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	SIZE scale3_block1_B_conv2d_size[] = { 128, 28, 28 };
	SIZE scale3_block1_B_conv2d_dim = 128 * 28 * 28;
	// scale3_block1_B_conv2d_dim = 100352
	SIZE scale3_block1_B_conv2d_stride[] = { 1, 1 };
	SIZE scale3_block1_B_conv2d_pad[] = { 1, 1 };
	
	soc->in = (DATA*)((uintptr_t)soc->in ^ (uintptr_t)soc->out);
	soc->out = (DATA*)((uintptr_t)soc->out ^ (uintptr_t)soc->in);
	soc->in = (DATA*)((uintptr_t)soc->in ^ (uintptr_t)soc->out);
	SIZE scale3_block1_B_conv2d_scale3_block0_Residual_Add_Add_output_dstride[] = { 1, 1 };
	
	
	//print_data(scale3_block1_B_conv2d_param->kernel, 157696, "./w.txt");
	//print_data(soc->in, 128*28*28, "./x.txt");
	
	
	job_id = spatconv_forward_hw(scale3_block1_B_conv2d_param, soc->in, soc->out, soc, scale3_block1_A_conv2d_size, scale3_block1_B_conv2d_size, scale3_block1_B_conv2d_stride, scale3_block1_B_conv2d_pad, false, _QF_, PRECISION8);
	SIZE scale3_block1_B_conv2d_output_scale3_block1_B_conv2d_output_dstride[] = { 1, 1 };

	spatconv_wait(soc, job_id);
	
	


	memcpy(scale3_block1_B_conv2d_output, soc->out, scale3_block1_B_conv2d_dim*sizeof(DATA));	
	add_fp16_forward_wR(scale3_block0_Residual_Add_Add_output, scale3_block1_B_conv2d_output, scale3_block1_Residual_Add_Add_output, scale3_block1_B_conv2d_size);

  memcpy(soc->in, scale3_block1_Residual_Add_Add_output, scale3_block1_B_conv2d_dim*sizeof(DATA));

	
    
    
   /*
 ██╗██████╗  █████╗          ██╗      ██████╗ ███████╗ ██████╗ 
███║╚════██╗██╔══██╗         ╚██╗     ╚════██╗██╔════╝██╔════╝ 
╚██║ █████╔╝╚█████╔╝    █████╗╚██╗     █████╔╝███████╗███████╗ 
 ██║██╔═══╝ ██╔══██╗    ╚════╝██╔╝    ██╔═══╝ ╚════██║██╔═══██╗
 ██║███████╗╚█████╔╝         ██╔╝     ███████╗███████║╚██████╔╝
 ╚═╝╚══════╝ ╚════╝          ╚═╝      ╚══════╝╚══════╝ ╚═════╝ 
                                                               
*/ 
    
	/*
	 * Convolution layer
	 * IF = 128 x 28 x 28 --> OF = 256 x 14 x 14
	 * W 256 x 128 x 3 x 3
	 * Pad    1x1
	 * Stride 2x2
	 */
	SIZE scale4_block0_shortcut_conv2d_size[] = { 256, 14, 14 };
	SIZE scale4_block0_shortcut_conv2d_sizeo[] = { 256, 28, 28 };
	SIZE scale4_block0_shortcut_conv2d_dim = 256 * 14 * 14;
	// scale4_block0_shortcut_conv2d_dim = 50176
	static DATA scale4_block0_shortcut_conv2d_output[50176];
	//SIZE scale4_block0_shortcut_conv2d_stride[] = { 2, 2 };
	SIZE scale4_block0_shortcut_conv2d_stride[] = { 1, 1 };
	SIZE scale4_block0_shortcut_conv2d_pad[] = { 1, 1 };
	
	job_id_sc = spatconv_forward_hw(scale4_block0_shortcut_conv2d_param, soc->in, tmp_out, soc, scale3_block0_B_conv2d_size, scale4_block0_shortcut_conv2d_sizeo, _stride, scale4_block0_shortcut_conv2d_pad, false, _QF_, PRECISION8);
	SIZE scale4_block0_shortcut_conv2d_output_scale4_block0_shortcut_conv2d_output_dstride[] = { 1, 1 };
	
	spatconv_wait(soc, job_id_sc);
	down_sampling(tmp_out, tmp_out, scale4_block0_shortcut_conv2d_size, scale4_block0_shortcut_conv2d_sizeo, scale1_conv2d_merge_stride);

	
	
	
	/*
	 * Convolution layer
	 * IF = 128 x 28 x 28 --> OF = 256 x 14 x 14
	 * W 256 x 128 x 3 x 3
	 * Pad    1x1
	 * Stride 2x2
	 */
	SIZE scale4_block0_A_conv2d_size[] = { 256, 14, 14 };
	SIZE scale4_block0_A_conv2d_sizeo[] = { 256, 28, 28 };
	SIZE scale4_block0_A_conv2d_dim = 256 * 14 * 14;
	// scale4_block0_A_conv2d_dim = 50176
	//SIZE scale4_block0_A_conv2d_stride[] = { 2, 2 };
	SIZE scale4_block0_A_conv2d_stride[] = { 1, 1 };
	SIZE scale4_block0_A_conv2d_pad[] = { 1, 1 };
	
	job_id_sc=spatconv_forward_hw(scale4_block0_A_conv2d_param, soc->in, soc->out, soc, scale3_block0_B_conv2d_size, scale4_block0_A_conv2d_sizeo, _stride, scale4_block0_A_conv2d_pad, true, _QF_, PRECISION8);
	SIZE scale4_block0_A_conv2d_output_scale4_block0_A_conv2d_output_dstride[] = { 1, 1 };
	
	spatconv_wait(soc, job_id_sc);	
	down_sampling(soc->out, soc->out, scale4_block0_A_conv2d_size,scale4_block0_A_conv2d_sizeo,  scale1_conv2d_merge_stride);

    
    
	/*
	 * Convolution layer
	 * IF = 256 x 14 x 14 --> OF = 256 x 14 x 14
	 * W 256 x 256 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	SIZE scale4_block0_B_conv2d_size[] = { 256, 14, 14 };
	SIZE scale4_block0_B_conv2d_dim = 256 * 14 * 14;
	// scale4_block0_B_conv2d_dim = 50176
	SIZE scale4_block0_B_conv2d_stride[] = { 1, 1 };
	SIZE scale4_block0_B_conv2d_pad[] = { 1, 1 };
	
	soc->in = (DATA*)((uintptr_t)soc->in ^ (uintptr_t)soc->out);
	soc->out = (DATA*)((uintptr_t)soc->out ^ (uintptr_t)soc->in);
	soc->in = (DATA*)((uintptr_t)soc->in ^ (uintptr_t)soc->out);
	job_id = spatconv_forward_hw(scale4_block0_B_conv2d_param, soc->in, soc->out, soc, scale4_block0_A_conv2d_size, scale4_block0_B_conv2d_size, scale4_block0_B_conv2d_stride, scale4_block0_B_conv2d_pad, false, _QF_, PRECISION8);
	SIZE scale4_block0_B_conv2d_output_scale4_block0_B_conv2d_output_dstride[] = { 1, 1 };

	spatconv_wait(soc, job_id_sc);
	

	memcpy(scale4_block0_Shortcut, tmp_out, scale4_block0_shortcut_conv2d_dim*sizeof(DATA));

	spatconv_wait(soc, job_id);
	
	memcpy(scale4_block0_B_conv2d_output, soc->out, scale4_block0_B_conv2d_dim*sizeof(DATA));
	add_fp16_forward_wR(scale4_block0_Shortcut, scale4_block0_B_conv2d_output, scale4_block0_Residual_Add_Add_output, scale4_block0_shortcut_conv2d_size);
	memcpy(soc->in, scale4_block0_Residual_Add_Add_output, scale4_block0_B_conv2d_dim*sizeof(DATA));

		

	/*
	 * Convolution layer
	 * IF = 256 x 14 x 14 --> OF = 256 x 14 x 14
	 * W 256 x 256 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	SIZE scale4_block1_A_conv2d_size[] = { 256, 14, 14 };
	SIZE scale4_block1_A_conv2d_dim = 256 * 14 * 14;
	// scale4_block1_A_conv2d_dim = 50176
	SIZE scale4_block1_A_conv2d_stride[] = { 1, 1 };
	SIZE scale4_block1_A_conv2d_pad[] = { 1, 1 };

	
	//memcpy(scale4_block1_Shortcut, soc->in, scale4_block0_shortcut_conv2d_dim*sizeof(DATA));

	spatconv_forward_hw(scale4_block1_A_conv2d_param, soc->in, soc->out, soc, scale4_block0_B_conv2d_size, scale4_block1_A_conv2d_size, scale4_block1_A_conv2d_stride, scale4_block1_A_conv2d_pad, true, _QF_, PRECISION8);
	SIZE scale4_block1_A_conv2d_output_scale4_block1_A_conv2d_output_dstride[] = { 1, 1 };
	

	
	
	/*
	 * Convolution layer
	 * IF = 256 x 14 x 14 --> OF = 256 x 14 x 14
	 * W 256 x 256 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	SIZE scale4_block1_B_conv2d_size[] = { 256, 14, 14 };
	SIZE scale4_block1_B_conv2d_dim = 256 * 14 * 14;
	// scale4_block1_B_conv2d_dim = 50176
	SIZE scale4_block1_B_conv2d_stride[] = { 1, 1 };
	SIZE scale4_block1_B_conv2d_pad[] = { 1, 1 };
	
	soc->in = (DATA*)((uintptr_t)soc->in ^ (uintptr_t)soc->out);
	soc->out = (DATA*)((uintptr_t)soc->out ^ (uintptr_t)soc->in);
	soc->in = (DATA*)((uintptr_t)soc->in ^ (uintptr_t)soc->out);
	SIZE scale4_block1_B_conv2d_scale4_block0_Residual_Add_Add_output_dstride[] = { 1, 1 };
	job_id = spatconv_forward_hw(scale4_block1_B_conv2d_param, soc->in, soc->out, soc, scale4_block1_A_conv2d_size, scale4_block1_B_conv2d_size, scale4_block1_B_conv2d_stride, scale4_block1_B_conv2d_pad, false, _QF_, PRECISION8);
	SIZE scale4_block1_B_conv2d_output_scale4_block1_B_conv2d_output_dstride[] = { 1, 1 };
	
	spatconv_wait(soc, job_id);

	
  memcpy(scale4_block1_B_conv2d_output, soc->out, scale4_block1_B_conv2d_dim*sizeof(DATA));
  add_fp16_forward_wR(scale4_block0_Residual_Add_Add_output, scale4_block1_B_conv2d_output, scale4_block1_Residual_Add_Add_output, scale4_block1_B_conv2d_size);

   memcpy(soc->in, scale4_block1_Residual_Add_Add_output, scale4_block1_B_conv2d_dim*sizeof(DATA));

/*
██████╗ ███████╗ ██████╗          ██╗      ███████╗ ██╗██████╗ 
╚════██╗██╔════╝██╔════╝          ╚██╗     ██╔════╝███║╚════██╗
 █████╔╝███████╗███████╗     █████╗╚██╗    ███████╗╚██║ █████╔╝
██╔═══╝ ╚════██║██╔═══██╗    ╚════╝██╔╝    ╚════██║ ██║██╔═══╝ 
███████╗███████║╚██████╔╝         ██╔╝     ███████║ ██║███████╗
╚══════╝╚══════╝ ╚═════╝          ╚═╝      ╚══════╝ ╚═╝╚══════╝                                                            
*/
	
	/*
	 * Convolution layer
	 * IF = 256 x 14 x 14 --> OF = 512 x 7 x 7
	 * W 512 x 256 x 3 x 3
	 * Pad    1x1
	 * Stride 2x2
	 */
	SIZE scale5_block0_shortcut_conv2d_size[] = { 512, 7, 7 };
	SIZE scale5_block0_shortcut_conv2d_sizeo[] = { 512, 14, 14 };
	SIZE scale5_block0_shortcut_conv2d_dim = 512 * 7 * 7;
	SIZE scale5_block0_shortcut_hw = 512 * 8 * 7;
	// scale5_block0_shortcut_conv2d_dim = 25088
//	SIZE scale5_block0_shortcut_conv2d_stride[] = { 2, 2 };
	SIZE scale5_block0_shortcut_conv2d_stride[] = { 1, 1 };
	SIZE scale5_block0_shortcut_conv2d_pad[] = { 1, 1 };
	
	job_id_sc = spatconv_forward_hw(scale5_block0_shortcut_conv2d_param, soc->in, tmp_out, soc, scale4_block0_B_conv2d_size, scale5_block0_shortcut_conv2d_sizeo, _stride, scale5_block0_shortcut_conv2d_pad, false, _QF_, PRECISION8);
	SIZE scale5_block0_shortcut_conv2d_output_scale5_block0_shortcut_conv2d_output_dstride[] = { 1, 1 };
	
	spatconv_wait(soc, job_id_sc);
	
	down_sampling(tmp_out, tmp_out, scale5_block0_shortcut_conv2d_size, scale5_block0_shortcut_conv2d_sizeo, scale1_conv2d_merge_stride);

	
	/////////////////////////////////////////////////////////////////////////
	
	
	
	
    
	
	/*
	 * Convolution layer
	 * IF = 256 x 14 x 14 --> OF = 512 x 7 x 7
	 * W 512 x 256 x 3 x 3
	 * Pad    1x1
	 * Stride 2x2
	 */
	SIZE scale5_block0_A_conv2d_size[] = { 512, 7, 7 };
	SIZE scale5_block0_A_conv2d_sizeo[] = { 512, 14, 14 };
	SIZE scale5_block0_A_conv2d_dim = 512 * 7 * 7;
	// scale5_block0_A_conv2d_dim = 25088
	SIZE scale5_block0_A_conv2d_stride[] = { 2, 2 };
	SIZE scale5_block0_A_conv2d_pad[] = { 1, 1 };

	job_id_sc = spatconv_forward_hw(scale5_block0_A_conv2d_param, soc->in, soc->out, soc, scale4_block0_B_conv2d_size, scale5_block0_A_conv2d_sizeo, _stride, scale5_block0_A_conv2d_pad, true, _QF_, PRECISION8);
	SIZE scale5_block0_A_conv2d_output_scale5_block0_A_conv2d_output_dstride[] = { 1, 1 };
	
	
	
	spatconv_wait(soc, job_id_sc);
	down_sampling(soc->out, soc->out, scale5_block0_shortcut_conv2d_size, scale5_block0_A_conv2d_sizeo, scale1_conv2d_merge_stride);

	
	/*
	 * Convolution layer
	 * IF = 512 x 7 x 7 --> OF = 512 x 7 x 7
	 * W 512 x 512 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	SIZE scale5_block0_B_conv2d_size[] = { 512, 7, 7 };
	SIZE scale5_add_size[] = { 512, 8, 7 };
	SIZE scale5_block0_B_conv2d_dim = 512 * 7 * 7;
	// scale5_block0_B_conv2d_dim = 25088
	SIZE scale5_block0_B_conv2d_stride[] = { 1, 1 };
	SIZE scale5_block0_B_conv2d_pad[] = { 1, 1 };

	soc->in  = (DATA*)((uintptr_t)soc->in  ^ (uintptr_t)soc->out);
	soc->out = (DATA*)((uintptr_t)soc->out ^ (uintptr_t)soc->in);
	soc->in  = (DATA*)((uintptr_t)soc->in  ^ (uintptr_t)soc->out);	
	job_id = spatconv_forward_hw(scale5_block0_B_conv2d_param, soc->in, soc->out, soc, scale5_block0_A_conv2d_size, scale5_block0_B_conv2d_size, scale5_block0_B_conv2d_stride, scale5_block0_B_conv2d_pad, false, _QF_, PRECISION8);
	SIZE scale5_block0_B_conv2d_output_scale5_block0_B_conv2d_output_dstride[] = { 1, 1 };

	spatconv_wait(soc, job_id_sc);

	memcpy(scale5_block0_Shortcut, tmp_out, scale5_block0_shortcut_hw*sizeof(DATA));

	spatconv_wait(soc, job_id);	 
	
	memcpy(scale5_block0_B_conv2d_output_hw, soc->out, scale5_block0_shortcut_hw*sizeof(DATA));
	
	add_fp16_forward_wR(scale5_block0_Shortcut, scale5_block0_B_conv2d_output_hw, scale5_block0_Residual_Add_Add_output_hw, scale5_add_size);
	
	place_zeros_nointer((uint32_t*)scale5_block0_Residual_Add_Add_output_hw, scale5_add_size);
	memcpy(soc->in, scale5_block0_Residual_Add_Add_output_hw, scale5_block0_shortcut_hw*sizeof(DATA));
	


	/*
	 * Convolution layer
	 * IF = 512 x 7 x 7 --> OF = 512 x 7 x 7
	 * W 512 x 512 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	SIZE scale5_block1_A_conv2d_size[] = { 512, 7, 7 };
	SIZE scale5_block1_A_conv2d_dim = 512 * 7 * 7;
	SIZE scale5_block1_A_conv2d_dim_hw = 512 * 8 * 7;
	// scale5_block1_A_conv2d_dim = 25088
	SIZE scale5_block1_A_conv2d_stride[] = { 1, 1 };
	SIZE scale5_block1_A_conv2d_pad[] = { 1, 1 };
	
	job_id = spatconv_forward_hw(scale5_block1_A_conv2d_param, soc->in, soc->out, soc, scale5_block0_B_conv2d_size, scale5_block1_A_conv2d_size, scale5_block1_A_conv2d_stride, scale5_block1_A_conv2d_pad, true, _QF_, PRECISION8);
	SIZE scale5_block1_A_conv2d_output_scale5_block1_A_conv2d_output_dstride[] = { 1, 1 };

	spatconv_wait(soc, job_id);

	place_zeros_nointer((uint32_t*)soc->out, scale5_add_size);

	//time = get_wall_time();
	//memcpy(scale5_block1_Shortcut, soc->in, scale5_block1_A_conv2d_dim_hw*sizeof(DATA));
	//_tprintf_("\tmemcpy: %5.3f ms\n", (get_wall_time()-time)/1000);
	
	/*
	 * Convolution layer
	 * IF = 512 x 7 x 7 --> OF = 512 x 7 x 7
	 * W 512 x 512 x 3 x 3
	 * Pad    1x1
	 * Stride 1x1
	 */
	SIZE scale5_block1_B_conv2d_size[] = { 512, 7, 7 };
	SIZE scale5_block1_B_conv2d_dim = 512 * 7 * 7;
	// scale5_block1_B_conv2d_dim = 25088
	SIZE scale5_block1_B_conv2d_stride[] = { 1, 1 };
	SIZE scale5_block1_B_conv2d_pad[] = { 1, 1 };
	
	SIZE scale5_block1_B_conv2d_scale5_block0_Residual_Add_Add_output_dstride[] = { 1, 1 };
	
	soc->in = (DATA*)((uintptr_t)soc->in ^ (uintptr_t)soc->out);
	soc->out = (DATA*)((uintptr_t)soc->out ^ (uintptr_t)soc->in);
	soc->in = (DATA*)((uintptr_t)soc->in ^ (uintptr_t)soc->out);
	job_id = spatconv_forward_hw(scale5_block1_B_conv2d_param, soc->in, soc->out, soc, scale5_block1_A_conv2d_size, scale5_block1_B_conv2d_size, scale5_block1_B_conv2d_stride, scale5_block1_B_conv2d_pad, false, _QF_, PRECISION8);
	SIZE scale5_block1_B_conv2d_output_scale5_block1_B_conv2d_output_dstride[] = { 1, 1 };

	spatconv_wait(soc, job_id);
	//printf("CHECK: %lld \n", checksum(soc->out, scale5_block1_B_conv2d_dim));
	
	
	
   
  memcpy(scale5_block1_B_conv2d_output_hw, soc->out, scale5_block1_A_conv2d_dim_hw*sizeof(DATA));
  add_fp16_forward_wR(scale5_block0_Residual_Add_Add_output_hw, scale5_block1_B_conv2d_output_hw, scale5_block1_Residual_Add_Add_output, scale5_add_size);
 
        
        
  int i;	
	for (i=0; i<512 * 7 * 7;i++){ //delete spurious column
    scale5_block1_Residual_Add_Add_output[i]=scale5_block1_Residual_Add_Add_output[i+i/7];
            
           
        
          }


	
	
	/*
 █████╗ ██╗   ██╗ ██████╗     ██████╗  ██████╗  ██████╗ ██╗     
██╔══██╗██║   ██║██╔════╝     ██╔══██╗██╔═══██╗██╔═══██╗██║     
███████║██║   ██║██║  ███╗    ██████╔╝██║   ██║██║   ██║██║     
██╔══██║╚██╗ ██╔╝██║   ██║    ██╔═══╝ ██║   ██║██║   ██║██║     
██║  ██║ ╚████╔╝ ╚██████╔╝    ██║     ╚██████╔╝╚██████╔╝███████╗
╚═╝  ╚═╝  ╚═══╝   ╚═════╝     ╚═╝      ╚═════╝  ╚═════╝ ╚══════╝
                                                                
*/
	

	SIZE avg_pool_size[] = { 512, 1, 1 };
	SIZE avg_pool_dim = 512 * 1 * 1;
	SIZE avg_pool_filter[] = { 7, 7 };
	SIZE avg_pool_stride[] = { 1, 1 };
	SIZE avg_pool_pad[] = { 0, 0 };
	avgpool_forward(scale5_block1_Residual_Add_Add_output, avg_pool_output, scale5_block0_B_conv2d_size, avg_pool_size, avg_pool_filter, avg_pool_stride, avg_pool_pad, _QF_);

	_tprintf_("CHECKSUM: %lld \n", checksum(avg_pool_output, avg_pool_dim));
	
	           
           
  /*
███████╗ ██████╗
██╔════╝██╔════╝
█████╗  ██║     
██╔══╝  ██║     
██║     ╚██████╗
╚═╝      ╚═════╝
                
*/         
           
           
	/*
	 * Fully-connected layer
	 * num outputs = 1000
	 * W 1000 x 512
	 * X 512 x 1
	 */
	SIZE xw_plus_b_MatMul_size[] = { 1000, 1, 1 };
	SIZE xw_plus_b_MatMul_dim = 1000;
	static DATA xw_plus_b_MatMul_output[xw_plus_b_MatMul_dim];
	linear_fp16_forward(xw_plus_b_MatMul_param, avg_pool_output, xw_plus_b_MatMul_output, avg_pool_dim, xw_plus_b_MatMul_dim);
	

	// Convert output
	for(unsigned int i = 0; i < xw_plus_b_MatMul_dim; i++)
		results[i] = (float) FIXED2FLOAT(xw_plus_b_MatMul_output[i], _QF_);

	
}

void free_platform(){
	munmap_soc(socs);
	free(socs[0]);
	free(socs[1]);
}

