# Power Summary

Power was regenerated using OpenROAD from the final SKY130-mapped Verilog netlists stored under `results/netlists/`.

The power estimates use a uniform global activity assumption:

- Activity factor: 0.10
- Duty cycle: 0.50
- Clock period: 10 ns
- Input transition: 0.10 ns
- Output load: 0.05 pF

These values should be interpreted as post-synthesis power estimates, not post-layout signoff power, because placed-and-routed DEF parasitics were not used.

| Architecture | Internal Power (mW) | Switching Power (mW) | Leakage Power (mW) | Total Power (mW) |
|---|---:|---:|---:|---:|
| Array | 2.30 | 1.74 | 0.0000835 | 4.03 |
| Radix-4 Booth | 1.66 | 1.68 | 0.0000569 | 3.34 |
| Dadda | 2.03 | 1.46 | 0.0000758 | 3.49 |

Under the same activity assumptions, the Radix-4 Booth multiplier has the lowest estimated total power.
