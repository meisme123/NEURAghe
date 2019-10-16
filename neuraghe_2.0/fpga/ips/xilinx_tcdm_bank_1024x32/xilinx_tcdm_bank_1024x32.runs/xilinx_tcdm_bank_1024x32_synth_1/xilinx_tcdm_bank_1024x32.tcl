# 
# Synthesis run script generated by Vivado
# 

create_project -in_memory -part xc7z045ffg900-2

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/gderiu/neuraghe_wei2ddr/fpga/ips/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.cache/wt [current_project]
set_property parent.project_path /home/gderiu/neuraghe_wei2ddr/fpga/ips/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part xilinx.com:zc706:part0:1.0 [current_project]
read_ip -quiet /home/gderiu/neuraghe_wei2ddr/fpga/ips/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.srcs/sources_1/ip/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.xci
set_property is_locked true [get_files /home/gderiu/neuraghe_wei2ddr/fpga/ips/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.srcs/sources_1/ip/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.xci]

foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top xilinx_tcdm_bank_1024x32 -part xc7z045ffg900-2 -mode out_of_context

rename_ref -prefix_all xilinx_tcdm_bank_1024x32_

write_checkpoint -force -noxdef xilinx_tcdm_bank_1024x32.dcp

catch { report_utilization -file xilinx_tcdm_bank_1024x32_utilization_synth.rpt -pb xilinx_tcdm_bank_1024x32_utilization_synth.pb }

if { [catch {
  file copy -force /home/gderiu/neuraghe_wei2ddr/fpga/ips/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.runs/xilinx_tcdm_bank_1024x32_synth_1/xilinx_tcdm_bank_1024x32.dcp /home/gderiu/neuraghe_wei2ddr/fpga/ips/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.srcs/sources_1/ip/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub /home/gderiu/neuraghe_wei2ddr/fpga/ips/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.srcs/sources_1/ip/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub /home/gderiu/neuraghe_wei2ddr/fpga/ips/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.srcs/sources_1/ip/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim /home/gderiu/neuraghe_wei2ddr/fpga/ips/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.srcs/sources_1/ip/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim /home/gderiu/neuraghe_wei2ddr/fpga/ips/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.srcs/sources_1/ip/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if {[file isdir /home/gderiu/neuraghe_wei2ddr/fpga/ips/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.ip_user_files/ip/xilinx_tcdm_bank_1024x32]} {
  catch { 
    file copy -force /home/gderiu/neuraghe_wei2ddr/fpga/ips/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.srcs/sources_1/ip/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32_stub.v /home/gderiu/neuraghe_wei2ddr/fpga/ips/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.ip_user_files/ip/xilinx_tcdm_bank_1024x32
  }
}

if {[file isdir /home/gderiu/neuraghe_wei2ddr/fpga/ips/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.ip_user_files/ip/xilinx_tcdm_bank_1024x32]} {
  catch { 
    file copy -force /home/gderiu/neuraghe_wei2ddr/fpga/ips/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.srcs/sources_1/ip/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32_stub.vhdl /home/gderiu/neuraghe_wei2ddr/fpga/ips/xilinx_tcdm_bank_1024x32/xilinx_tcdm_bank_1024x32.ip_user_files/ip/xilinx_tcdm_bank_1024x32
  }
}