/*
 * soc_drivers.c
 *
 *  Created on: 17/mag/2016
 *      Author: Gianfranco
 */
#include <stdio.h>
#include "soc_drivers.h"
#include "conv_hwce_l2.h"
//#include "helloworld_l2.h"
//#include "stdout_l2.h"
//#include "dma_transfert_l2.h"
//#include "power_test_l2.h"

#define DISABLE_PRINT

void conv_setup (int in_f, int out_f, int ih, int iw, int fs){

	*((volatile int*)(CONV_SETUP_ADDR + NUM_BANKS*4*0)) = 0xA00AB11B; // control code
	*((volatile int*)(CONV_SETUP_ADDR + NUM_BANKS*4*1)) = in_f; //# input features
	*((volatile int*)(CONV_SETUP_ADDR + NUM_BANKS*4*2)) = out_f;//# input features
	*((volatile int*)(CONV_SETUP_ADDR + NUM_BANKS*4*3)) = ih;//features height
	*((volatile int*)(CONV_SETUP_ADDR + NUM_BANKS*4*4)) = iw;//features width
	*((volatile int*)(CONV_SETUP_ADDR + NUM_BANKS*4*5)) = fs;//filter size


}

void print_clk(){

	int reg = *((volatile int*)0xF8000170);

	int div0=(reg & 0x00003F00)>>8;
	int div1=(reg & 0x03F00000)>>20;

	int freq= (1000/div0)/div1;
#ifndef DISABLE_PRINT
	printf ("FPGA0_clk_reg: 0x%08x\n", reg);
	printf ("\tDiv0: 0x%03x\n", div0);
	printf ("\tDiv1: 0x%03x\n", div1);
	printf ("\tFPGA0_clk_freq: %d MHz\n", freq);

	printf ("\tclk0_freq:      %d MHz\n", freq/2);
	printf ("\tclkfast_freq:   %d MHz\n", freq);
#endif
}

void set_fclk_div(int div0, int div1){

	int val = 0x00000000;

	val = val | div0<<8 | div1<<20;

	unlock_ps_regs ();

	*((int*)0xF8000170) = val;

	lock_ps_regs ();
#ifndef DISABLE_PRINT
	printf ("FPGA0_clk new: 0x%08x\n", *((volatile int*)0xF8000170));
#endif
}

void stop_fclk(){

	int val = 0x00000001;

	unlock_ps_regs ();

	*((int*)0xF8000178) = val;

	lock_ps_regs ();
#ifndef DISABLE_PRINT
	printf ("FPGA0_clk stopped: %08x\n", *((volatile int*)0xF800017C));
#endif
}

void start_fclk(){

	int val = 0x00000000;

	unlock_ps_regs ();

	*((int*)0xF8000178) = val;

	lock_ps_regs ();
#ifndef DISABLE_PRINT
	printf ("FPGA0_clk started\n");
#endif
}

void load_code (){
    int i;
	volatile int * l2_ptr = (volatile int *)L2_BASE_ADDRESS;
#ifndef DISABLE_PRINT
	printf ("Loading code in L2...\n");
#endif
	for(i=0;i<CODE_SIZE;i++){
		l2_ptr[i]=l2_code[i];
    }
#ifndef DISABLE_PRINT
	printf ("Loading complete!\n");
#endif
}

void fetch_enable (){

	*((volatile int*)FETCH_ENABLE_ADDR)=0x1;
#ifndef DISABLE_PRINT
	printf ("Fetch is enabled.\n");
#endif
}

void fetch_disable (){
	*((volatile int*)FETCH_ENABLE_ADDR)=0x0;
#ifndef DISABLE_PRINT
	printf ("Fetch is disabled.\n");
#endif
}

void wait_eoc () {
#ifndef DISABLE_PRINT
	printf ("Waiting for EOC...\n");
#endif
	while(*((volatile int*)EOC_ADDR)==0);
	fetch_disable ();
#ifndef DISABLE_PRINT
	printf ("EOC caught!\n");
#endif
}

void wait_for (long int num){

	for (;num>0;num--);
}

void read_tcdm (volatile int *from, int nrow){
	int i;
	volatile int * from_int = (volatile int *) (((int)from) & 0xFFFFFFFC0);

	int len=nrow*NUM_BANKS;

	printf ("\nRow          \tBank_0               \tBank_1               \tBank_2               \tBank_3               \tBank_4               \tBank_5               \tBank_6                \tBank_7               \tBank_8               \tBank_9               \tBank_A               \tBank_B               \tBank_C               \tBank_D               \tBank_E               \tBank_F");
	printf ("          \tBank_10               \tBank_11               \tBank_12               \tBank_13               \tBank_14               \tBank_15               \tBank_16                \tBank_17               \tBank_18               \tBank_19               \tBank_1A               \tBank_1B               \tBank_1C               \tBank_1D               \tBank_1E               \tBank_1F");


	for (i=0;i<len;i++){
	  if (i%NUM_BANKS == 0)
		  printf ("\n[0x%04x]  \t",(((int)(&from_int[i]))&0x7FFFF)>>7);
	  printf ("0x%08x      \t", from_int[i]);
	}
	printf ("\n");
}

void read_mem (volatile int *from, int len, int stride) {

	int i;
	for (i=0;i<len;i++){
		if ((int)&from[i*stride]>=0x50000000 && (int)&from[i*stride]<0x50040000)
		  printf ("TCDM_%d[0x%08x]: 0x%08x\n", ((int)&from[i*stride]>>2)%NUM_BANKS, (int)&from[i*stride], from[i*stride]); //bank, address, data

		if ((int)&from[i*stride]>=0x5C000000 && (int)&from[i*stride]<0x5C040000)
		  printf ("L2[0x%08x]: 0x%08x\n",(int)&from[i*stride],from[i*stride]); // address, data

		if ((int)&from[i*stride]>=0x00100000 && (int)&from[i*stride]<0x40000000)
		  printf ("DDR[0x%08x]: 0x%08x\n",(int)&from[i*stride],from[i*stride]); // address, data
	}

}

void unlock_ps_regs (){
	 *((int*)0XF8000008) = 0xDF0D; // unlock
}

void lock_ps_regs(){
	*((int*)0XF8000004) = 0x767B; //lock
}