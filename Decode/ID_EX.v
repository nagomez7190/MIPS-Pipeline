This code will be implemented in the final Pipeline module as separate in order to control the amount of ports neccessary for my specific fpga

`timescale 1ns / 1ps

module ID_EX (
    input clk,
    input reset,
    input [143:0] bundled_in,  // Combined control signals and data inputs
    output reg [143:0] bundled_out // Combined control signals and data outputs
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            bundled_out <= 144'b0;
        else
            bundled_out <= bundled_in;
    end
endmodule
