`timescale 1ns / 1ps

module Sign_Extend (
    input [15:0] imm,
    output [31:0] sign_ext
);
    assign sign_ext = {{16{imm[15]}}, imm}; // Sign-extend 16 bits to 32 bits
endmodule

