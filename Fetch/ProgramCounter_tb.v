`timescale 1ns / 1ps

module ProgramCounter_tb;

    reg clk;                
    reg reset;            
    reg [31:0] pc_in;       
    wire [31:0] pc_out;   
    ProgramCounter PC (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end
    initial begin
        $monitor("Time: %0dns | Reset: %b | PC In: %h | PC Out: %h", $time, reset, pc_in, pc_out);
        reset = 1; 
        pc_in = 32'h00000000; // Set PC input to 0
        #10;
        reset = 0;
        pc_in = 32'h00000004; // Set PC input to 4
        #10;
        // Test Case 1: Update PC
        pc_in = 32'h00000008; // Set PC input to 8
        #10;
        // Test Case 2: Apply reset
        reset = 1; // Assert reset
        #10;
        reset = 0; // Release reset
        pc_in = 32'h0000000C; // Set PC input to 12
        #10;
        // Test Case 3: Normal operation
        pc_in = 32'h00000010; // Set PC input to 16
        #10;
        $finish;
    end

endmodule
