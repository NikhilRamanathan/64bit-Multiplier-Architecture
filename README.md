# 64-bit Multiplier Architecture Comparison

This repository compares three 64-bit multiplier architectures using an open-source ASIC-style flow:

- Array multiplier
- Radix-4 Booth multiplier
- Dadda multiplier

The goal is to compare architectural trade-offs in mapped area, cell count, timing, and post-synthesis power under the same SKY130-based evaluation flow.

## Final Evidence-Backed PPA Results

| Architecture | Mapped Cells | Mapped Area | Critical Path Delay (ns) | Estimated Fmax (MHz) | Slack @ 10 ns (ns) | Total Power (mW) |
|---|---:|---:|---:|---:|---:|---:|
| Array | 14,670 | 170,235.769600 | 89.8478 | 11.13 | -79.8478 | 4.03 |
| Radix-4 Booth | 14,029 | 122,304.800000 | 62.6285 | 15.97 | -52.6285 | 3.34 |
| Dadda | 12,744 | 149,170.566400 | 71.4395 | 14.00 | -61.4395 | 3.49 |

## Key Observations

- The Radix-4 Booth multiplier achieved the smallest mapped area, shortest critical path delay, highest estimated maximum frequency, and lowest regenerated post-synthesis power estimate.
- The Dadda multiplier achieved the lowest mapped cell count.
- The Array multiplier had the largest mapped area, longest critical path delay, and highest regenerated post-synthesis power estimate.
- All three designs violate the 10 ns timing constraint in the current combinational implementation.
- Power values are post-synthesis OpenROAD estimates generated from the final SKY130-mapped netlists using uniform global activity assumptions. They are not post-layout signoff power values.

## Evidence Traceability

| Metric | Array | Radix-4 Booth | Dadda |
|---|---|---|---|
| Area | `results/area/raw/array_area_raw.txt` | `results/area/raw/booth_area_raw.txt` | `results/area/raw/dadda_area_raw.txt` |
| Timing | `results/timing/raw/array_sta_raw.txt` | `results/timing/raw/booth_sta_raw.txt` | `results/timing/raw/dadda_sta_raw.txt` |
| Power | `results/power/array_power_report.txt` | `results/power/booth_power_report.txt` | `results/power/dadda_power_report.txt` |
| Netlist | `results/netlists/array_sky130_netlist.v` | `results/netlists/booth_sky130_netlist.v` | `results/netlists/dadda_sky130_netlist.v` |

## Tool Flow

- RTL design: Verilog/SystemVerilog
- Functional simulation: Icarus Verilog
- Area synthesis: Yosys + ABC using SKY130 HD Liberty
- Timing analysis: OpenSTA using SKY130-mapped netlists
- Power estimation: OpenROAD using final SKY130-mapped netlists
- Figures: Python/matplotlib

## Repository Structure

```text
designs/
  array/
  booth/
  dadda/

results/
  area/raw/
  timing/raw/
  power/
  netlists/
  final_comparison_table.md

figures/
scripts/
Notes

The designs/booth/rtl/ folder contains archived modular Booth RTL retained for reference. The final Booth implementation used for the reported comparison is designs/booth/design.sv.

The reported power values are generated under a uniform activity assumption and should be interpreted comparatively, not as silicon signoff measurements.
