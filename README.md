# Fomu Tests
Simple tests to get started on Fomu, and to ensure the hardware functions.

## blink

The canonical `Hello, world!` program for FPGAs is blinking an LED.  The `blink/` directory contains an implementation of this simple blinker that tests the following features:

1. **48 MHz Oscillator** The oscillator drives the main timer.  There are options to use the internal RC oscillator within `blink.v`
1. **RGB LED** The oscillator is divided down and sent to the green LED.  The Blue and Red LEDs are connected to switches
1. **Switches 5 and 6** These switches have pullups enabled.  You can activate the Blue and Red LEDs by pressing buttons 5 and 6 respectively.

## Building

You can check this repository out on your Raspberry Pi and build it by simply typing `make`.  This will generate `blink.bin`, which you can load by running `fomu-flash -f blink.bin`
