`timescale 1ns / 1ps

module Incrementor_by_4(
    input [31:0] pc_in,
    output reg [31:0] pc_out
    );
    always @(*) begin
        pc_out = pc_in + 4;
    end
endmodule
