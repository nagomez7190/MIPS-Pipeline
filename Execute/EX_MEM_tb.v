`timescale 1ns / 1ps

module EX_MEM_tb;
    reg clk;
    reg reset;
    reg [70:0] ex_mem_bundle_in;
    wire [70:0] ex_mem_bundle_out;

    EX_MEM NAG ( 
.clk(clk),
.reset(reset),
.ex_mem_bundle_in(ex_mem_bundle_in),
.ex_mem_bundle_out(ex_mem_bundle_out) 
 );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end
    initial begin
        reset = 1;
        ex_mem_bundle_in = 71'b0;
        #10;
        reset = 0;
        // Test Case 1: Apply a new input bundle
        #10;
        ex_mem_bundle_in = 71'b1010101010101010101010101010101010101010101010101010101010101010101;
        #10;
        // Test Case 2: Apply another input bundle
        #10;
        ex_mem_bundle_in = 71'b0101010101010101010101010101010101010101010101010101010101010101010;
        #10;
        // Test Case 3: Reset the module
        #10;
        reset = 1;
        #10;
        reset = 0;

        // Test Case 4: Check latching behavior with constant input
        #10;
        ex_mem_bundle_in = 71'b1111111111111111111111111111111111111111111111111111111111111111111;
        #10;
        ex_mem_bundle_in = 71'b0000000000000000000000000000000000000000000000000000000000000000000;
        #10;
        #20 $stop;
    end
endmodule
