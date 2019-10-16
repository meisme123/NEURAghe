#ifndef __SOC_DRIVERS_H_
#define __SOC_DRIVERS_H_


#include "xparameters.h"

#define NUM_BANKS 32

#define DDR_REMAP 0x30000000

#define SOC_CTRL_BASE_ADDR XPAR_SOC_AXI_CTRL_V1_0_0_BASEADDR

#define TCDM_BASE_ADDRESS XPAR_ULPSOC_0_BASEADDR
#define L2_BASE_ADDRESS (XPAR_ULPSOC_0_BASEADDR + 0xC000000)

#define EOC_ADDR (SOC_CTRL_BASE_ADDR + 0x4)
#define FETCH_ENABLE_ADDR (SOC_CTRL_BASE_ADDR)

#define CONV_DONE DDR_REMAP
#define CONV_SETUP_ADDR (TCDM_BASE_ADDRESS + 0x3FA00) // this address must be the same chosen in PL code
#define OFFLOAD_READY (CONV_SETUP_ADDR + NUM_BANKS*4*11)

#define TCDM_BANK(n) (TCDM_BASE_ADDRESS + 4*n)

#define INTRA_BANK_STRIDE NUM_BANKS  //in words

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
//#include <byteswap.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <errno.h>
//#include <sys/mman.h>
#define PAGE_SIZE ((size_t)getpagesize())
#define PAGE_MASK ((uint64_t)(long)~(PAGE_SIZE - 1))
int * addr_linux(int addr, int size, int fd);

void conv_setup (volatile int * soc_addr,int in_f, int out_f, int ih, int iw, int fs, int max_og, int max_stores, int rectifier_activ, int w_addr, int x_addr, int y_addr);
void load_code (volatile int * soc_addr);
void fetch_enable (volatile int * soc_cntr_addr);
void fetch_disable (volatile int * soc_cntr_addr);
void wait_eoc (volatile int * soc_cntr_addr);
void wait_for (long int num);
void read_mem (volatile int *from, int len, int stride);
void lock_ps_regs();
void unlock_ps_regs ();
void read_tcdm (volatile int *from, int nrow);
void set_fclk_div(int div1, int div2);
void print_clk();
void start_fclk();
void stop_fclk();
void use_default_conv_test();
void wait_for_conv(volatile int * ddr_addr);
void trigger_conv (volatile int * ddr_addr, volatile int * soc_addr);

#endif
