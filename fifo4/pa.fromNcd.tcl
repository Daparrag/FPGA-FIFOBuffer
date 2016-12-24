
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name fifo4 -dir "C:/FistState/Projects/FIFObuffer/fifo4/planAhead_run_4" -part xc3s200ft256-4
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "C:/FistState/Projects/FIFObuffer/fifo4/fifo.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/FistState/Projects/FIFObuffer/fifo4} }
set_property target_constrs_file "s2.ucf" [current_fileset -constrset]
add_files [list {s2.ucf}] -fileset [get_property constrset [current_run]]
link_design
read_xdl -file "C:/FistState/Projects/FIFObuffer/fifo4/fifo.xdl"
if {[catch {read_twx -name results_1 -file "C:/FistState/Projects/FIFObuffer/fifo4/fifo.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"C:/FistState/Projects/FIFObuffer/fifo4/fifo.twx\": $eInfo"
}
