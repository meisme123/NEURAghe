#ifndef EXACONV_PULP_H
#define EXACONV_PULP_H

#if !defined(PULP_CHIP) || PULP_CHIP != CHIP_EXACONV
#error This file must be included only for exaconv chip
#endif

#include "events.h"

#define PULP_BASE_ADDR                0x00000000
#define PULP_BASE_REMOTE_ADDR         0x10000000
#define PULP_CLUSTER_BASE             0x00000000
#define PULP_CLUSTER_SIZE             0x00400000
#define PULP_CLUSTER_BASE_ADDR(cid)   (PULP_BASE_REMOTE_ADDR + (cid)*PULP_CLUSTER_SIZE)
#define PULP_HAS_ALIAS                1
#define PULP_HAS_L1_ALIAS             1

/* TCDM */
#define TCDM_BASE_ADDR                ( PULP_BASE_ADDR )
#define TCDM_SRAM_BASE_ADDR           ( TCDM_BASE_ADDR + 0x0 )
#define TCDM_SCM_BASE_ADDR            ( TCDM_BASE_ADDR + 0x10000 )
#define TEST_AND_SET_OFFSET           0x00100000
#define TEST_AND_SET_BASE_ADDR        ( PULP_BASE_ADDR + TEST_AND_SET_OFFSET )
#define LIBGOMP_BASE_ADDR             ( TCDM_BASE_ADDR + 0x0 )
/* IMPORTANT!!! all the TCDM #define MUST be aligned with the related sections in the linker script */

/* CLUSTER PERIPHERALS OFFSETS */
#define CLUSTER_PERIPHERALS_OFFSET    ( 0x200000 )
#define EOC_UNIT_OFFSET               ( CLUSTER_PERIPHERALS_OFFSET + 0x0000 )
#define BBMUX_CLKGATE_OFFSET          ( CLUSTER_PERIPHERALS_OFFSET + 0x0800 )

/* CLUSTER PERIPHERALS */
#define CLUSTER_PERIPHERALS_BASE_ADDR ( PULP_BASE_ADDR + CLUSTER_PERIPHERALS_OFFSET )
#define CLUSTER_PERIPHERALS_BASE_REMOTE_ADDR ( PULP_BASE_REMOTE_ADDR + CLUSTER_PERIPHERALS_OFFSET )
#define EOC_UNIT_BASE_ADDR            ( PULP_BASE_ADDR + EOC_UNIT_OFFSET )
#define FETCH_EN_UNIT_BASE_ADDR       ( CLUSTER_PERIPHERALS_BASE_ADDR + 0x0008 )
#define FETCH_EN_UNIT_BASE_REMOTE_ADDR       ( CLUSTER_PERIPHERALS_BASE_REMOTE_ADDR + 0x0008 )
#define DVS_DVSE_UNIT_BASE_ADDR       ( CLUSTER_PERIPHERALS_BASE_ADDR + 0x0018 )

#define TIMER_BASE_ADDR               ( CLUSTER_PERIPHERALS_BASE_ADDR + 0x0400 )
#define BBMUX_CLKGATE_BASE_ADDR       ( PULP_BASE_ADDR + BBMUX_CLKGATE_OFFSET )
#define HWCE_BASE_ADDR                ( CLUSTER_PERIPHERALS_BASE_ADDR + 0x1000 )
#define ICACHE_CTRL_BASE_ADDR         ( CLUSTER_PERIPHERALS_BASE_ADDR + 0x1400 )

#define CLKGATE_REG_BASE              ( BBMUX_CLKGATE_BASE_ADDR + 0x100)

/* DEMUX MAPPED PERIPHERALS  */
#define DEMUX_PERIPHERALS_BASE_ADDR   ( PULP_BASE_ADDR + 0x204000 )
#define EVENT_UNIT_DEMUX_BASE_ADDR    ( DEMUX_PERIPHERALS_BASE_ADDR + 0x00000 )
#define MCHAN_BASE_OFFSET             ( 0x00400 )
#define MCHAN_BASE_ADDR               ( DEMUX_PERIPHERALS_BASE_ADDR + MCHAN_BASE_OFFSET )
//#define PERF_BASE_ADDR                ( DEMUX_PERIPHERALS_BASE_ADDR + 0x00800 )

// use these defines if you want to place the DMEUX_PERIPH just before the test and set region
//#define DEMUX_PERIPHERALS_BASE_ADDR   ( TEST_AND_SET_BASE_ADDR )
//#define EVENT_UNIT_DEMUX_BASE_ADDR    ( DEMUX_PERIPHERALS_BASE_ADDR - 0x00400 )
//#define MCHAN_BASE_ADDR               ( DEMUX_PERIPHERALS_BASE_ADDR - 0x00800 )
//#define PERF_BASE_ADDR                ( DEMUX_PERIPHERALS_BASE_ADDR - 0x00C00 )



/* L2 MEMORY */
#define L2_MEM_BASE_ADDR              ( 0x1C000000 )

#define MCHAN_NB_COUNTERS             4

#define PLP_EU_HAS_HW_MUTEX    1
#define PLP_EU_HAS_DISPATCH    1


#define PLP_DMA_NB_COUNTERS 4

#endif