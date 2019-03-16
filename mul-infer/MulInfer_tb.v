
`default_nettype none
`timescale 1ns/100ps

module mulinfer_tb;

	// Signals
	reg rst = 1;
	reg clk_12m  = 0;	// CPU clock
    reg clk_samp = 0; // Capture samplerate
    reg [31:0] numA = 32'd16384;
    reg [31:0] numB = 32'd4;
    wire [31:0] result;
    wire done;

    
	// Setup recording
	initial begin
		$dumpfile("mulinfer_tb.vcd");
		$dumpvars(0,mulinfer_tb);
    end


	// Reset pulse
	initial begin
		# 200 rst = 0;
		# 500 $finish;
    end

    
	// Clocks
	always #40.416 clk_12m  = !clk_12m;
    always #10.416 clk_samp = !clk_samp;

    
	// DUT
	MulInfer dut_I (
        .inpA(numA),
        .inpB(numB),
        .out(result),
        .i_done(done),
        .a_signed(1'b1),
        .b_signed(1'b1),
        .clk(clk_12m),
        .mul_type(1'b0),
        .reset(rst)
    );

    always @ (posedge clk_12m) begin
        if (done) begin
            $display("Done.  Result of %d x %d: %d", numA, numB, result);
        end
    end
endmodule //mulinfer_tb