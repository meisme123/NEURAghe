#ifndef PULP4Z_PULP_H
#define PULP4Z_PULP_H

#if PULP_CHIP != CHIP_PULP4Z
#error This file must be included only for pulp4z chip
#endif

#define PULP_BASE_ADDR                0x10000000
#define PULP_BASE_REMOTE_ADDR         0x10000000
#define PULP_CLUSTER_BASE             PULP_BASE_ADDR
#define PULP_CLUSTER_SIZE             0x00400000

/* TCDM */
#define TCDM_BASE_ADDR                ( PULP_BASE_ADDR )
#define TCDM_SRAM_BASE_ADDR           ( TCDM_BASE_ADDR + 0x0 )
#define TCDM_SCM_BASE_ADDR            ( TCDM_BASE_ADDR + 0x10000 )
#define TEST_AND_SET_OFFSET           0x00100000
#define TEST_AND_SET_BASE_ADDR        ( PULP_BASE_ADDR + TEST_AND_SET_OFFSET )
#define LIBGOMP_BASE_ADDR             ( TCDM_BASE_ADDR + 0x0 )
/* IMPORTANT!!! all the TCDM #define MUST be aligned with the related sections in the linker script */

/* CLUSTER PERIPHERALS */
#define CLUSTER_PERIPHERALS_BASE_ADDR ( PULP_BASE_ADDR + 0x200000 )
#define EOC_UNIT_BASE_ADDR            ( CLUSTER_PERIPHERALS_BASE_ADDR + 0x0000 )
#define FETCH_EN_UNIT_BASE_ADDR       ( CLUSTER_PERIPHERALS_BASE_ADDR + 0x0008 )
#define DVS_DVSE_UNIT_BASE_ADDR       ( CLUSTER_PERIPHERALS_BASE_ADDR + 0x0018 )

#define TIMER_BASE_ADDR               ( CLUSTER_PERIPHERALS_BASE_ADDR + 0x0400 )
#define BBMUX_CLKGATE_BASE_ADDR       ( CLUSTER_PERIPHERALS_BASE_ADDR + 0x0800 )
#define REC_PIPE_STARGE_BASE_ADDR     ( CLUSTER_PERIPHERALS_BASE_ADDR + 0x0C00 )
#define MMU_BASE_ADDR                 ( CLUSTER_PERIPHERALS_BASE_ADDR + 0x1000 )
#define ICACHE_CTRL_BASE_ADDR         ( CLUSTER_PERIPHERALS_BASE_ADDR + 0x1400 )
#define HWCE_BASE_ADDR                ( CLUSTER_PERIPHERALS_BASE_ADDR + 0x1800 )

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



/* SOC PERIPHERALS */
#define SOC_PERIPHERALS_BASE_ADDR     ( PULP_BASE_ADDR + 0xA100000 )

#define CVP_BASE_ADDR                 ( SOC_PERIPHERALS_BASE_ADDR + 0x0000 )
#define GPIO_BASE_ADDR                ( SOC_PERIPHERALS_BASE_ADDR + 0x1000 )
#define SPI_BASE_ADDR                 ( SOC_PERIPHERALS_BASE_ADDR + 0x2000 )
#define UART_BASE_ADDR                ( SOC_PERIPHERALS_BASE_ADDR + 0x3000 )
#define APB_SOC_CTRL_ADDR             ( SOC_PERIPHERALS_BASE_ADDR + 0x4000 )
#define I2C_BASE_ADDR                 ( SOC_PERIPHERALS_BASE_ADDR + 0x5000 )
#define I2S_AUDIO_BASE_ADDR           ( SOC_PERIPHERALS_BASE_ADDR + 0x6000 )
#define I2S_CAM_BASE_ADDR             ( SOC_PERIPHERALS_BASE_ADDR + 0x7000 )
#define CP_BASE_ADDR                  ( SOC_PERIPHERALS_BASE_ADDR + 0x8000 )
#define PMB_BASE_ADDR                 ( SOC_PERIPHERALS_BASE_ADDR + 0x9000 )

/* STDOUT */
#define STDOUT_BASE_ADDR              ( SOC_PERIPHERALS_BASE_ADDR + 0x10000 )
#define FPUTCHAR_BASE_ADDR            ( STDOUT_BASE_ADDR + 0x1000 )
#define FILE_CMD_BASE_ADDR            ( STDOUT_BASE_ADDR + 0x2000 )
#define STREAM_BASE_ADDR              ( STDOUT_BASE_ADDR + 0x3000 )

/* HW traces */
#define TRACE_BASE_ADDR               ( SOC_PERIPHERALS_BASE_ADDR + 0x20000 )

/* L2 MEMORY */
#define L2_MEM_BASE_ADDR              ( PULP_BASE_ADDR + 0xC000000 )
/* ROM */
#define ROM_BASE_ADDR                 ( PULP_BASE_ADDR + 0xA000000 )

#define PULP_DMA_EVT   8
#endif
