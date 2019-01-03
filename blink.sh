#!/bin/sh
set -e

# synthesize into blinky.json
yosys -p 'synth_ice40 -top blink -json blink.json' blink.v

# run place and route
nextpnr-ice40 --up5k --package sg48 --json blink.json --pcf fomu-48.pcf --asc blink.asc

# generate binary bitstream file
icepack blink.asc blink.bin