`timescale 1ns / 1ps

module ALU (
    input [31:0] A,
    input [31:0] B,
    input [2:0] control,
    output reg [31:0] result,
    output reg zero
);
    always @(*) begin
        case (control)
            3'b000: result = A & B; // AND
            3'b001: result = A | B; // OR
            3'b010: result = A + B; // Add
            3'b110: result = A - B; // Subtract
            3'b111: result = (A < B) ? 32'b1 : 32'b0; // Set less than
            default: result = 32'b0; // Default to zero
        endcase
        zero = (result == 32'b0) ? 1'b1 : 1'b0; // Set zero flag
    end
endmodule
