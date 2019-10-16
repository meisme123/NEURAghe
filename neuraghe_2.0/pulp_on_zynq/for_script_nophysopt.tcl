############## for_script.tcl ##################
set numIters 10
set enablePhysOpt 0

for {set i 0} {$i < $numIters} {incr i} {

  if {[get_property SLACK [get_timing_paths ]] >= 0} {break}; #stop if timing is met

  place_design -post_place_opt
  if {$enablePhysOpt != 0} {
    phys_opt_design -directive AggressiveExplore

    report_phys_opt -file report_phys_opt_$i.rpt 
  }
  route_design -directive Explore
  report_timing_summary -file timing_pre_post_place_design_$i.rpt
}

#report_timing_summary -file timing_pre_post_place_design.rpt
#write_checkpoint -force pre_post_route_design_script.dcp
#place_design -post_place_opt
#phys_opt_design -directive Explore
#route_design -directive Explore

#phys_opt_design -directive AggressiveFanoutOpt

#-directive Explore - Increased placer effort in detail placement and post-placement optimization.
#-directive ExtraPostPlacementOpt - Increased placer effort in post-placement optimization.