read_liberty ../../lib/sky130_fd_sc_hd__ss_n40C_1v60_ccsnoise.lib
read_verilog bidcounter_ss_n40C_1v60_ccsnoise.v
link_design bidcounter
read_sdc ../../contraint.tcl
report_checks -verbose -path_delay min_max -fields {nets cap slew input_pins} -digits 4 > sta_report/bidcounter_gen_rep.rpt
report_wns -digits 4 > sta_report/wns
report_tns -digits 4 > sta_report/tns
report_worst_slack -digits 4 > sta_report/worst_slack
report_check_types -all_violators > sta_report/violations 
