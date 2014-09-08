
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name maincodev6 -dir "D:/maincodev6/planAhead_run_1" -part xc3s400tq144-5
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/maincodev6/maincodev6.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/maincodev6} }
set_property target_constrs_file "initialize.ucf" [current_fileset -constrset]
add_files [list {initialize.ucf}] -fileset [get_property constrset [current_run]]
link_design
