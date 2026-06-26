# Final Evidence-Backed PPA Comparison

| Architecture | Mapped Cells | Mapped Area | Critical Path Delay (ns) | Estimated Fmax (MHz) | Slack @ 10 ns (ns) | Total Power (mW) |
|---|---:|---:|---:|---:|---:|---:|
| Array | 14,670 | 170,235.769600 | 89.8478 | 11.13 | -79.8478 | 4.03 |
| Radix-4 Booth | 14,029 | 122,304.800000 | 62.6285 | 15.97 | -52.6285 | 3.34 |
| Dadda | 12,744 | 149,170.566400 | 71.4395 | 14.00 | -61.4395 | 3.49 |

## Key Observations

- The Radix-4 Booth multiplier gives the lowest mapped area, shortest critical path delay, highest estimated maximum frequency, and lowest regenerated post-synthesis power estimate.
- The Dadda multiplier gives the lowest mapped cell count.
- The Array multiplier has the largest mapped area, longest critical path delay, and highest estimated power.
- All three designs violate the 10 ns timing constraint in the current combinational implementation.
- Power values are post-synthesis OpenROAD estimates using uniform global activity assumptions, not post-layout signoff power.
