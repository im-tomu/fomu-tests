module myblinky (
    output led_r,
    output led_g,
    output led_b,
    output pmod_1,
    output pmod_2,
    output pmod_3,
    output pmod_4,
    input user_5,
    input user_6,
    input clki
);

    wire clkhf;
    SB_HFOSC #(
        .CLKHF_DIV("0b00")
    ) hfosc (
        .CLKHFPU(1),
        .CLKHFEN(1),
        .CLKHF(clk)
    );
    assign clk = clkhf;

    // wire clklf;
    // SB_LFOSC clk_lf (
    //     .CLKLFEN(1),
    //     .CLKLFPU(1),
    //     .CLKLF(clklf)
    // );

    // SB_GB clk_gb (
    //     .USER_SIGNAL_TO_GLOBAL_BUFFER(clki),
    //     .GLOBAL_BUFFER_OUTPUT(clk)
    // );

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

    localparam BITS = 5;
    localparam LOG2DELAY = 21;

    reg [BITS+LOG2DELAY-1:0] counter = 0;
    reg [BITS-1:0] outcnt;

    always @(posedge clk) begin
        counter <= counter + 1;
        outcnt <= counter >> LOG2DELAY;
    end

    assign pmod_1 = clk;
    assign pmod_2 = outcnt ^ (outcnt >> 1);
    assign pmod_3 = counter[0];
    assign pmod_4 = pll_out;

    SB_RGBA_DRV RGBA_DRIVER (
        .CURREN(1'b1),
        .RGBLEDEN(1'b1),
        .RGB0PWM(~user_5_pulled),
        .RGB1PWM(~user_6_pulled),
        .RGB2PWM(counter[0] & counter[1] & counter[2] & outcnt[0]),
        .RGB0(led_r),
        .RGB1(led_g),
        .RGB2(led_b)
    );

    defparam RGBA_DRIVER.CURRENT_MODE = "0b0"; // Full-current mode (set to 1 for half-current)
    defparam RGBA_DRIVER.RGB0_CURRENT = "0b001111"; // 8 mA
    defparam RGBA_DRIVER.RGB1_CURRENT = "0b001111"; // 16 mA
    defparam RGBA_DRIVER.RGB2_CURRENT = "0b001111"; // 24 mA

endmodule