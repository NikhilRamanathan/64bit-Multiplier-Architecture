read_lef /home/ubuntu/OpenROAD-flow-scripts/tools/OpenROAD/test/sky130hd/sky130hd_vt.tlef
read_lef /home/ubuntu/OpenROAD-flow-scripts/tools/OpenROAD/test/sky130hd/sky130_fd_sc_hd_merged.lef
read_liberty /home/ubuntu/OpenROAD-flow-scripts/tools/OpenROAD/test/sky130hd/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog results/netlists/booth_sky130_netlist.v
link_design booth_multiplier_64bit

create_clock -name clk -period 10

set_input_transition 0.10 [all_inputs]
set_load 0.05 [all_outputs]

set_power_activity -global -activity 0.10 -duty 0.50

report_power > results/power_new/booth_power_report.txt
