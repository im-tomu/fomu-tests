# MulInfer

This project simply demonstrates that yosys is able to infer some MAC16 blocks but not all.

It contains the MulDiv plugin as manually extracted from VexRiscv.

## Usage

To generate a vcd file, run:

```sh
make test
```

To generate a bitstream, run:

```sh
make
```

## Output

Notice how there are a lot of LC usages, and only one DSP block:

```
== MulInfer ===

   Number of wires:               2377
   Number of wire bits:           3684
   Number of public wires:          50
   Number of public wire bits:    1115
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:               2880
     SB_CARRY                      141
     SB_DFF                        219
     SB_DFFE                         1
     SB_DFFSR                        1
     SB_LUT4                      2517
     SB_MAC16                        1
```

Nextpnr output:

```
nfo: Device utilisation:
Info:            ICESTORM_LC:  2577/ 5280    48%
Info:           ICESTORM_RAM:     0/   30     0%
Info:                  SB_IO:   102/   96   106%
Info:                  SB_GB:     1/    8    12%
Info:           ICESTORM_PLL:     0/    1     0%
Info:            SB_WARMBOOT:     0/    1     0%
Info:           ICESTORM_DSP:     1/    8    12%
Info:         ICESTORM_HFOSC:     0/    1     0%
Info:         ICESTORM_LFOSC:     0/    1     0%
Info:                 SB_I2C:     0/    2     0%
Info:                 SB_SPI:     0/    2     0%
Info:                 IO_I3C:     0/    2     0%
Info:            SB_LEDDA_IP:     0/    1     0%
Info:            SB_RGBA_DRV:     0/    1     0%
Info:         ICESTORM_SPRAM:     0/    4     0%
```