`timescale 1ns / 1ps

module Control_tb;

    reg [5:0] opcode;
    wire [8:0] control_bits;

    Control NAG (
        .opcode(opcode),
        .control_bits(control_bits)
    );

    initial begin
        $monitor("Time: %0dns | Opcode: %b | Control Bits: %b", $time, opcode, control_bits);

        // Test Case 1: R-format (opcode = 6'b000000)
        opcode = 6'b000000;
        #10;
        // Test Case 2: lw (opcode = 6'b100011)
        opcode = 6'b100011;
        #10;
        // Test Case 3: sw (opcode = 6'b101011)
        opcode = 6'b101011;
        #10;
        // Test Case 4: beq (opcode = 6'b000100)
        opcode = 6'b000100;
        #10;
        // Test Case 5: Invalid opcode (default case)
        opcode = 6'b111111; // Invalid opcode
        #10;
        // Test Case 6: Another invalid opcode
        opcode = 6'b010101; // Invalid opcode
        #10;
        $finish;
    end
endmodule
