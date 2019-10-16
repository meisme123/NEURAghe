`ifndef HWPE_SM_PARAMS
`define HWPE_SM_PARAMS

`ifndef log2
  `define log2(N) ((N)<=(1) ? 0 : (N)<=(2) ? 1 : (N)<=(4) ? 2 : (N)<=(8) ? 3 : (N)<=(16) ? 4 : (N)<=(32) ? 5 : (N)<=(64) ? 6 : (N)<=(128) ? 7 : (N)<=(256) ? 8 : (N)<=(512) ? 9 : (N)<=(1024) ? 10 : -1)
`endif

// sets clock phase for latch-based implementation
`define LATCH_CLK_PHASE 1'b0

`define NS_INTERLEAVED     '{4,4,4,4}
`define IDS_INTERLEAVED    '{3,2,1,0}
`define PORT_SHARING_RATIO 1
`define IDS_PORTSHARED     '{'{3},'{2},'{1},'{0}}

`define N_MANDATORY_REGS    8
`define N_MAX_IO_REGS       32
`define N_MAX_GENERIC_REGS  4
`define N_RESERVED_REGS     1
`define N_REGISTERS         `N_RESERVED_REGS + `N_MANDATORY_REGS + `N_MAX_GENERIC_REGS + `N_MAX_IO_REGS

`define STRUCT_DATA_WIDTH      32
`define STRUCT_ADDR_WIDTH      `log2(`N_REGISTERS)+2 // max size of LOG_REGS_MC

typedef struct packed {
  logic [`N_MAX_IO_REGS-1:0]      [`STRUCT_DATA_WIDTH-1:0] hwpe_params;
  logic [`N_MAX_GENERIC_REGS-1:0] [`STRUCT_DATA_WIDTH-1:0] generic_params;
} regfile_t;

typedef struct packed {
  logic [`STRUCT_ADDR_WIDTH-1:0] addr;
  logic                          rden;
  logic                          wren;
  logic [`STRUCT_DATA_WIDTH-1:0] wdata;
  logic [`STRUCT_DATA_WIDTH-1:0] src;
} regfile_in_t;

typedef struct packed {
  logic [`STRUCT_DATA_WIDTH-1:0] rdata;
  logic                          evt_sync;
} regfile_out_t;

typedef struct packed {
  logic true_done;
  logic full_context;
  logic is_mandatory;
  logic is_read;
  logic is_contexted;
  logic is_critical;
  logic is_testset;
  logic is_trigger;
} slave_flags_t;

`endif

