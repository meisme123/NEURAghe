set partNumber $::env(XILINX_PART)
set boardName  $::env(XILINX_BOARD)

create_project xilinx_tcdm_bank_1024x64_16_asym . -part $partNumber
set_property board_part $boardName [current_project]
create_ip -name blk_mem_gen -vendor xilinx.com -library ip -module_name xilinx_tcdm_bank_1024x64_16_asym
set_property -dict [list CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Use_Byte_Write_Enable {true} CONFIG.Byte_Size {8} CONFIG.Write_Width_A {64} CONFIG.Write_Depth_A {1024} CONFIG.Register_PortA_Output_of_Memory_Primitives {false} CONFIG.Write_Width_B {16} CONFIG.Register_PortB_Output_of_Memory_Primitives {false} CONFIG.Use_RSTA_Pin {true}] [get_ips xilinx_tcdm_bank_1024x64_16_asym]
generate_target all [get_files ./xilinx_tcdm_bank_1024x64_16_asym.srcs/sources_1/ip/xilinx_tcdm_bank_1024x64_16_asym/xilinx_tcdm_bank_1024x64_16_asym.xci]
create_ip_run [get_files -of_objects [get_fileset sources_1] ./xilinx_tcdm_bank_1024x64_16_asym.srcs/sources_1/ip/xilinx_tcdm_bank_1024x64_16_asym/xilinx_tcdm_bank_1024x64_16_asym.xci]
launch_run -jobs 8 xilinx_tcdm_bank_1024x64_16_asym_synth_1
wait_on_run xilinx_tcdm_bank_1024x64_16_asym_synth_1
