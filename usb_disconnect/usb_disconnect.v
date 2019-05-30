// Simple tri-colour LED blink example, with button control
//
// Green LED blinks forever.  Blue LED turned on when Button 5 is pressed.
// Red LED turned on when Button 6 is pressed.
//
// LOG2DELAY controls the division of the module clock to the bit interval
// (by requiring count to 2 ** LOG2DELAY before changing LED state bits)
//
// On EVT Fomu boards:
//
// 1st LED colour - Blue  - controlled by pressing Button 5, or connect 1 to 2
// 2nd LED colour - Red   - controlled by pressing Button 6, or connect 3 to 4
// 3rd LED colour - Green - controlled by clock (blinking)
//
// On DVT / Hacker / Production Fomu boards:
//
// 1st LED colour - Blue  - turn on by connecting pin 1 to pin 2
// 2nd LED colour - Green - controlled by clock (blinking)
// 3rd LED colour - Red   - turn on by connecting pin 3 to pin 4
//
// We use `defines to handle these two cases, because the SB_RGBA_DRV
// iCE40UP5K hard macro is unable to do RGBn to output pin mapping internally
// (the RGB0 / RGB1 / RGB2 parameters to SB_RGBA_DRV *must* be mapped
// to the same named RGB0 / RGB1 / RGB2 physical pins; arachne-pnr
// errors if they are not, and currently nextpnr just ignores mismapped
// pins and enforces this mapping)
//
// This is all kludged into a single file to make a standalone simple test;
// a better design would wrap SB_RGBA_DRV into a Fomu specific module and
// hide the LED colour mapping; and also set the appropriate pins for
// the buttons at instantiation time.
//
`ifdef EVT
`define BLUEPWM  RGB0PWM
`define REDPWM   RGB1PWM
`define GREENPWM RGB2PWM
`else
`define BLUEPWM  RGB0PWM
`define GREENPWM RGB1PWM
`define REDPWM   RGB2PWM
`endif

module usb_disconnect (
    output usb_dn,       // SB_RGBA_DRV external pins
    output usb_dp,
    output usb_dp_pu
);
    assign usb_dn = 1'b0;
    assign usb_dp = 1'b0;
    assign usb_dp_pu = 1'b0;
endmodule
