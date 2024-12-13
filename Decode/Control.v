`timescale 1ns / 1ps

module Control (
    input [5:0] opcode,
    output reg [8:0] control_bits // WB: 2, M: 3, EX: 4
);
    always @(*) begin
        case (opcode)
            6'b000000: control_bits = 9'b110000010; // R-format
            6'b100011: control_bits = 9'b011001000; // lw
            6'b101011: control_bits = 9'bX1X010000; // sw
            6'b000100: control_bits = 9'bX0X100001; // beq
            default:   control_bits = 9'b000000000; // Default: No operation
        endcase
    end
endmodule
