`timescale 1ns / 1ps

module ID_EX_tb;

    reg clk;
    reg reset;
    reg [143:0] bundled_in;
    wire [143:0] bundled_out;

    ID_EX NAG (
        .clk(clk),
        .reset(reset),
        .bundled_in(bundled_in),
        .bundled_out(bundled_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        reset = 1;
        bundled_in = 144'b0;

        #10 reset = 0;

        #10 bundled_in = 144'h123456789ABCDEF123456789ABCDEF123456789ABCDEF;
        #10 bundled_in = 144'h0;
        #10 bundled_in = 144'hFEDCBA987654321FEDCBA987654321FEDCBA987654321;

        // Assert reset again
        #10 reset = 1;
        #10 reset = 0;

        // Apply new inputs after reset
        #10 bundled_in = 144'h111122223333444411112222333344441111222233334444;

        // Allow simulation to run for some cycles
        #50;

        $stop;
    end
endmodule
