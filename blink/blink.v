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
// 1st LED colour - Blue  - controlled by pressing Button 5
// 2nd LED colour - Red   - controlled by pressing Button 6
// 3rd LED colour - Green - controlled by clock (blinking)
//
// On DVT / Hacker / Production Fomu boards:
//
// 1st LED colour - Blue  - controlled by pressing Button 5
// 2nd LED colour - Green - controlled by clock (blinking)
// 3rd LED colour - Red   - controlled by pressing Button 6
//
// We use `defines to handle these two cases, because the SB_RGBA_DRV
// iCE40UP5K hard macro is unable to do RGBn to output pin mapping internally
// (the RGB0 / RGB1 / RGB2 parameters to SB_RGBA_DRV *must* be mapped
// to the same named RGB0 / RGB1 / RGB2 physical pins; arachne-pnr
// errors if they are not, and currently nextpnr just ignores mismapped
// pins and enforces this mapping)
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

module blink (
    output led_r,      // Red LED
    output led_g,      // Green LED
    output led_b,      // Blue LED
`ifdef HAVE_PMOD
    output pmod_1,     // PMOD ouput connector (on EVT boards)
    output pmod_2,
    output pmod_3,
    output pmod_4,
`endif
    input user_5,      // Button 5
    input user_6,      // Button 6
    input clki         // Clock
);

    // Connect to system clock (with buffering)
    wire clkosc;
    SB_GB clk_gb (
        .USER_SIGNAL_TO_GLOBAL_BUFFER(clki),
        .GLOBAL_BUFFER_OUTPUT(clkosc)
    );

    assign clk = clkosc;

    // Latch button 5 state
    wire user_5_pulled;
    SB_IO #(
        .PIN_TYPE(6'b 000001),
        .PULLUP(1'b 1)
    ) user_5_io (
        .PACKAGE_PIN(user_5),
        .OUTPUT_ENABLE(1'b0),
        .INPUT_CLK(clk),
        .D_IN_0(user_5_pulled),
    );

    // Latch button 6 state
    wire user_6_pulled;
    SB_IO #(
        .PIN_TYPE(6'b 000000),
        .PULLUP(1'b 1)
    ) user_6_io (
        .PACKAGE_PIN(user_6),
        .OUTPUT_ENABLE(1'b0),
        .INPUT_CLK(clk),
        .D_IN_0(user_6_pulled),
    );

    // Use system PLL module to divide system clock
    // (connected to pmod output below)
    wire pll_out;
    SB_PLL40_CORE #(
        .FEEDBACK_PATH("SIMPLE"),
        .DIVR(4'b0010),		// DIVR =  2
        .DIVF(7'b0110001),	// DIVF = 49
        .DIVQ(3'b010),		// DIVQ =  2
        .FILTER_RANGE(3'b001)	// FILTER_RANGE = 1
    ) mypll (
        .RESETB(1'b1),
        .BYPASS(1'b0),
        .REFERENCECLK(clk),
        .PLLOUTCORE(pll_out),
    );

    // Use counter logic to divide system clock
    // (for blinking LED state)
    //
    // BITS controls LED state
    // LOG2DELAY controls divisor
    // -- requires counting to 2**LOG2DELAY before spilling onto LED state BITS
    //
    localparam BITS = 5;
    localparam LOG2DELAY = 21;

    reg [BITS+LOG2DELAY-1:0] counter = 0;
    reg [BITS-1:0] outcnt;

    always @(posedge clk) begin
        counter <= counter + 1;
        outcnt <= counter >> LOG2DELAY;
    end

    // Make signals available on PMOD header output for scope
    // (or to inspect during simulation)
`ifdef HAVE_PMOD
    assign pmod_1 = clk;
    assign pmod_2 = outcnt ^ (outcnt >> 1);
    assign pmod_3 = counter[0];
    assign pmod_4 = pll_out;
`endif

    // Instantiate iCE40 LED driver hard logic, connecting up
    // latched button state, counter state, and LEDs.
    //
    SB_RGBA_DRV RGBA_DRIVER (
        .CURREN(1'b1),
        .RGBLEDEN(1'b1),
        .`BLUEPWM(~user_5_pulled),     // Blue
        .`REDPWM(~user_6_pulled),      // Red
        .`GREENPWM(outcnt[4]),         // Green
        .RGB0(led_b),
        .RGB1(led_r),
        .RGB2(led_g)
    );

    // Parameters from iCE40 UltraPlus LED Driver Usage Guide, pages 19-20
    //
    // https://www.latticesemi.com/-/media/LatticeSemi/Documents/ApplicationNotes/IK/ICE40LEDDriverUsageGuide.ashx?document_id=50668
    //
    localparam RGBA_CURRENT_MODE_FULL = "0b0";
    localparam RGBA_CURRENT_MODE_HALF = "0b1";

    // Current levels in Full / Half mode
    localparam RGBA_CURRENT_04MA_02MA = "0b000001";
    localparam RGBA_CURRENT_08MA_04MA = "0b000011";
    localparam RGBA_CURRENT_12MA_06MA = "0b000111";
    localparam RGBA_CURRENT_16MA_08MA = "0b001111";
    localparam RGBA_CURRENT_20MA_10MA = "0b011111";
    localparam RGBA_CURRENT_24MA_12MA = "0b111111";

    // Set parameters of RGBA_DRIVER (output current)
    //
    // Mapping of RGBn to LED colours determined experimentally
    //
    defparam RGBA_DRIVER.CURRENT_MODE = RGBA_CURRENT_MODE_HALF;
    defparam RGBA_DRIVER.RGB0_CURRENT = RGBA_CURRENT_08MA_04MA;  // Blue
    defparam RGBA_DRIVER.RGB1_CURRENT = RGBA_CURRENT_04MA_02MA;  // Red
    defparam RGBA_DRIVER.RGB2_CURRENT = RGBA_CURRENT_04MA_02MA;  // Green

endmodule
