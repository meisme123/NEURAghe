// PERIPH BUS PARAMETRES

`define NB_SLAVE  3
`define NB_MASTER 6

`define NB_REGION 2

// MASTER PORT TO SOC
// REGION 0 - CLUSTER (TCDM + PERIPHERALS)
`define MASTER_0_REGION_0_START_ADDR 32'h1000_0000
`define MASTER_0_REGION_0_END_ADDR   32'h102F_FFFF

// REGION 1 - L2
`define MASTER_0_REGION_1_START_ADDR 32'h1C00_0000
`define MASTER_0_REGION_1_END_ADDR   32'h1FFF_FFFF

// MASTER PORT TO ROM
`define MASTER_1_START_ADDR 32'h1A00_0000
`define MASTER_1_END_ADDR   32'h1A00_FFFF

// MASTER PORT TO SPI
`define MASTER_2_START_ADDR 32'h1A01_0000
`define MASTER_2_END_ADDR   32'h1A01_FFFF

// MASTER PORT TO CVP/FLL
`define MASTER_3_START_ADDR 32'h1A02_0000
`define MASTER_3_END_ADDR   32'h1A02_FFFF

// MASTER PORT TO CLK MANAGER
`define MASTER_4_START_ADDR 32'h1A03_0000
`define MASTER_4_END_ADDR   32'h1A03_FFFF

// MASTER PORT TO STDOUT (DUMMY)
`define MASTER_5_START_ADDR 32'h1A04_0000
`define MASTER_5_END_ADDR   32'h1A04_FFFF
