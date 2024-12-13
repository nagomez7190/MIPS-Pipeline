`timescale 1ns / 1ps

module Adder_tb;

    reg [31:0] add_in1;
    reg [31:0] add_in2;
    wire [31:0] add_out;

    Adder NAG (
        .add_in1(add_in1),
        .add_in2(add_in2),
        .add_out(add_out)
    );

    initial begin
        // Test Case 1: Add two positive numbers
        add_in1 = 32'd10;
        add_in2 = 32'd20;
        #10;
        // Test Case 2: Add a positive and a negative number
        add_in1 = 32'd15;
        add_in2 = -32'd5;
        #10;
        // Test Case 3: Add two negative numbers
        add_in1 = -32'd8;
        add_in2 = -32'd12;
        #10;
        // Test Case 4: Add zero
        add_in1 = 32'd0;
        add_in2 = 32'd25;
        #10;
        // Test Case 5: Add large numbers
        add_in1 = 32'h7FFFFFFF; // Maximum positive value for 32 bits
        add_in2 = 32'd1;
        #10;
        #10 $stop;
    end
endmodule
