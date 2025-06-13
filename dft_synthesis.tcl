## the search paths for libraries, scripts and RTL

set_db init_lib_search_path {/DIG_DESIGN/STUDENTS/PHD/anandraj/mod10counter/lib/}
set_db init_hdl_search_path {/DIG_DESIGN/STUDENTS/PHD/anandraj/mod10counter/rtl/}
set_db script_search_path {/DIG_DESIGN/STUDENTS/PHD/anandraj/mod10counter/constraint/}

#libraray ,scrpt and RTL
set_db library slow_vdd1v0_basicCells.lib


read_hdl mod10counter.v
set top_design mod10counter
######elaborate
elaborate mod10counter

##########read_sdc
read_sdc  constraint.sdc

#########scan_ff_Setup
check_dft_rules
set_db dft_scan_style muxed_scan 
define_shift_enable -name SE -active high -create_port SE -default



######compile/synthesis
syn_generic
syn_map
syn_opt


set_db design:mod10counter .dft_min_number_of_scan_chains 1 
define_scan_chain -name top_chain -sdi scan_ff_in -sdo scan_ff_out -create_ports 
connect_scan_chains -auto_create_chains

report_scan_chains



###########export the design
write_hdl > mod10counter_dft_net.v
write_sdc >constraint_out_dft.sdc
write_scandef > mod10counter_scandef.scandef



########reports
report_area > area.rpt
report_power > power.rpt
report_timing > timing.rpt
report_gates > gates.rpt


