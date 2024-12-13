`timescale 1ns / 1ps

module InstructMem_tb;

    // Testbench variables
    reg [6:0] add;            // Input address
    wire [31:0] instruc;      // Output instruction

    // Instantiate the InstructMem module
    InstructMem Inst (
        .add(add),
        .instruc(instruc)
    );

    // Test sequence
    initial begin
        // Monitor the input and output signals
        $monitor("Time: %0dns | Address: %h | Instruction: %h", $time, add, instruc);
        // Test Case 1: Fetch instruction at address 0
        add = 7'b0000000; // Address 0x00000000
        #10;
        // Test Case 2: Fetch instruction at address 4
        add = 7'b0000100; // Address 0x00000004
        #10;
        // Test Case 3: Fetch instruction at address 8
        add = 7'b0001000; // Address 0x00000008
        #10;
        // Test Case 4: Fetch instruction at address 12
        add = 7'b0001100; // Address 0x0000000C
        #10;
        // Test Case 5: Fetch instruction at address 20 (after first 10 initialized instructions)
        add = 7'b0010100; // Address 0x00000014
        #10;
        // Test Case 6: Fetch instruction at an uninitialized address
        add = 7'b1000000; // Address 0x00000080
        #10;
        // Finish simulation
        $finish;
    end

endmodule
