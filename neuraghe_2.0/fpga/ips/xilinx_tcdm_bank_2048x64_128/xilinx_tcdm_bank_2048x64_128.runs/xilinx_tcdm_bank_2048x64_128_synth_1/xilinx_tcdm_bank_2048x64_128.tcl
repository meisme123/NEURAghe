# 
# Synthesis run script generated by Vivado
# 

set_msg_config -msgmgr_mode ooc_run
create_project -in_memory -part xc7z045ffg900-2

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.cache/wt [current_project]
set_property parent.project_path /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.xpr [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part xilinx.com:zc706:part0:1.0 [current_project]
set_property ip_output_repo /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_ip -quiet /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.srcs/sources_1/ip/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.xci
set_property is_locked true [get_files /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.srcs/sources_1/ip/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.xci]

foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

set cached_ip [config_ip_cache -export -no_bom -use_project_ipc -dir /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.runs/xilinx_tcdm_bank_2048x64_128_synth_1 -new_name xilinx_tcdm_bank_2048x64_128 -ip [get_ips xilinx_tcdm_bank_2048x64_128]]

if { $cached_ip eq {} } {

synth_design -top xilinx_tcdm_bank_2048x64_128 -part xc7z045ffg900-2 -mode out_of_context

#---------------------------------------------------------
# Generate Checkpoint/Stub/Simulation Files For IP Cache
#---------------------------------------------------------
catch {
 write_checkpoint -force -noxdef -rename_prefix xilinx_tcdm_bank_2048x64_128_ xilinx_tcdm_bank_2048x64_128.dcp

 set ipCachedFiles {}
 write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ xilinx_tcdm_bank_2048x64_128_stub.v
 lappend ipCachedFiles xilinx_tcdm_bank_2048x64_128_stub.v

 write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ xilinx_tcdm_bank_2048x64_128_stub.vhdl
 lappend ipCachedFiles xilinx_tcdm_bank_2048x64_128_stub.vhdl

 write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ xilinx_tcdm_bank_2048x64_128_sim_netlist.v
 lappend ipCachedFiles xilinx_tcdm_bank_2048x64_128_sim_netlist.v

 write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ xilinx_tcdm_bank_2048x64_128_sim_netlist.vhdl
 lappend ipCachedFiles xilinx_tcdm_bank_2048x64_128_sim_netlist.vhdl

 config_ip_cache -add -dcp xilinx_tcdm_bank_2048x64_128.dcp -move_files $ipCachedFiles -use_project_ipc -ip [get_ips xilinx_tcdm_bank_2048x64_128]
}

rename_ref -prefix_all xilinx_tcdm_bank_2048x64_128_

write_checkpoint -force -noxdef xilinx_tcdm_bank_2048x64_128.dcp

catch { report_utilization -file xilinx_tcdm_bank_2048x64_128_utilization_synth.rpt -pb xilinx_tcdm_bank_2048x64_128_utilization_synth.pb }

if { [catch {
  file copy -force /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.runs/xilinx_tcdm_bank_2048x64_128_synth_1/xilinx_tcdm_bank_2048x64_128.dcp /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.srcs/sources_1/ip/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.srcs/sources_1/ip/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.srcs/sources_1/ip/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.srcs/sources_1/ip/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.srcs/sources_1/ip/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}


} else {


if { [catch {
  file copy -force /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.runs/xilinx_tcdm_bank_2048x64_128_synth_1/xilinx_tcdm_bank_2048x64_128.dcp /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.srcs/sources_1/ip/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  file rename -force /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.runs/xilinx_tcdm_bank_2048x64_128_synth_1/xilinx_tcdm_bank_2048x64_128_stub.v /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.srcs/sources_1/ip/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.runs/xilinx_tcdm_bank_2048x64_128_synth_1/xilinx_tcdm_bank_2048x64_128_stub.vhdl /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.srcs/sources_1/ip/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.runs/xilinx_tcdm_bank_2048x64_128_synth_1/xilinx_tcdm_bank_2048x64_128_sim_netlist.v /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.srcs/sources_1/ip/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  file rename -force /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.runs/xilinx_tcdm_bank_2048x64_128_synth_1/xilinx_tcdm_bank_2048x64_128_sim_netlist.vhdl /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.srcs/sources_1/ip/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

}; # end if cached_ip 

if {[file isdir /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.ip_user_files/ip/xilinx_tcdm_bank_2048x64_128]} {
  catch { 
    file copy -force /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.srcs/sources_1/ip/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128_stub.v /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.ip_user_files/ip/xilinx_tcdm_bank_2048x64_128
  }
}

if {[file isdir /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.ip_user_files/ip/xilinx_tcdm_bank_2048x64_128]} {
  catch { 
    file copy -force /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.srcs/sources_1/ip/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128_stub.vhdl /home/gderiu/marco/neuraghe_zc706_tcn/fpga/ips/xilinx_tcdm_bank_2048x64_128/xilinx_tcdm_bank_2048x64_128.ip_user_files/ip/xilinx_tcdm_bank_2048x64_128
  }
}
