#!/usr/bin/env bash
set -e

export PATH=$HOME/OpenROAD-flow-scripts/tools/install/OpenROAD/bin:$PATH

LIBERTY=$(find "$HOME/OpenROAD-flow-scripts" -name "sky130_fd_sc_hd__tt_025C_1v80.lib" | head -1)
TECH_LEF=$(find "$HOME/OpenROAD-flow-scripts" -name "*.tlef" | grep -i sky130 | head -1)
CELL_LEF=$(find "$HOME/OpenROAD-flow-scripts" \( -name "sky130_fd_sc_hd.lef" -o -name "*sky130_fd_sc_hd*.lef" \) | grep -v magic | head -1)

if [ -z "$LIBERTY" ]; then
  echo "ERROR: SKY130 Liberty file not found."
  exit 1
fi

if [ -z "$TECH_LEF" ]; then
  echo "ERROR: SKY130 technology LEF file not found."
  exit 1
fi

if [ -z "$CELL_LEF" ]; then
  echo "ERROR: SKY130 standard-cell LEF file not found."
  exit 1
fi

echo "Using Liberty: $LIBERTY"
echo "Using Tech LEF: $TECH_LEF"
echo "Using Cell LEF: $CELL_LEF"

mkdir -p results/power_new scripts/power

run_power () {
  ARCH=$1
  TOP=$2
  NETLIST=$3

  TCL="scripts/power/${ARCH}_power.tcl"
  REPORT="results/power_new/${ARCH}_power_report.txt"

  cat > "$TCL" << TCL_EOF
read_lef $TECH_LEF
read_lef $CELL_LEF
read_liberty $LIBERTY
read_verilog $NETLIST
link_design $TOP

create_clock -name clk -period 10

set_input_transition 0.10 [all_inputs]
set_load 0.05 [all_outputs]

set_power_activity -global -activity 0.10 -duty 0.50

report_power > $REPORT
TCL_EOF

  echo "Running OpenROAD power for $ARCH..."
  openroad -exit "$TCL"
}

run_power array array_multiplier_64bit results/netlists/array_sky130_netlist.v
run_power booth booth_multiplier_64bit results/netlists/booth_sky130_netlist.v
run_power dadda dadda_multiplier_64bit results/netlists/dadda_sky130_netlist.v

echo "Done. New power reports are in results/power_new/"
