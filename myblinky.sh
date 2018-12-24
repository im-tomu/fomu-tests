#!/bin/sh
set -e
yosys -p 'synth_ice40 -top myblinky -json myblinky.json' myblinky.v               # synthesize into blinky.json
nextpnr-ice40 --up5k --package sg48 --json myblinky.json --pcf myblinky.pcf --asc myblinky.asc   # run place and route
icepack myblinky.asc myblinky.bin                                               # generate binary bitstream file
scp myblinky.bin root@10.0.245.55:/tmp
ssh root@10.0.245.55 "/root/Code/bitbang-program-ice40"