set partNumber $::env(XILINX_PART)
set boardName  $::env(XILINX_BOARD)

create_project xilinx_l2_mem_32768x64 . -part $partNumber
set_property board_part $boardName [current_project]
create_ip -name blk_mem_gen -vendor xilinx.com -library ip -module_name xilinx_l2_mem_32768x64
set_property -dict [list CONFIG.Memory_Type {Single_Port_RAM} CONFIG.Use_Byte_Write_Enable {true} CONFIG.Byte_Size {8} CONFIG.Write_Width_A {64} CONFIG.Write_Depth_A {32768} CONFIG.Register_PortA_Output_of_Memory_Primitives {false} CONFIG.Use_RSTA_Pin {true} ] [get_ips xilinx_l2_mem_32768x64]
generate_target all [get_files ./xilinx_l2_mem_32768x64.srcs/sources_1/ip/xilinx_l2_mem_32768x64/xilinx_l2_mem_32768x64.xci]
create_ip_run [get_files -of_objects [get_fileset sources_1] ./xilinx_l2_mem_32768x64.srcs/sources_1/ip/xilinx_l2_mem_32768x64/xilinx_l2_mem_32768x64.xci]
launch_run -jobs 8 xilinx_l2_mem_32768x64_synth_1
wait_on_run xilinx_l2_mem_32768x64_synth_1
