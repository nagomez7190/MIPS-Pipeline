`timescale 1ns / 1ps

module MEM_Stage_tb;

    reg clk;
    reg reset;
    reg [70:0] ex_mem_bundle;
    wire [69:0] mem_wb_bundle;
    wire PCSrc;

    MEM_Stage NAG (
        .clk(clk),
        .reset(reset),
        .ex_mem_bundle(ex_mem_bundle),
        .mem_wb_bundle(mem_wb_bundle),
        .PCSrc(PCSrc)
    );


    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        reset = 1;
        ex_mem_bundle = 71'b0;

        #10 reset = 0;

        // Test case 1: No branch, no memory access
        #10 ex_mem_bundle = {2'b10, 3'b000, 32'h00000010, 32'h00000020, 1'b0, 5'b00001};

        // Test case 2: Branch taken
        #10 ex_mem_bundle = {2'b10, 3'b100, 32'h00000030, 32'h00000040, 1'b1, 5'b00010};

        // Test case 3: Memory write
        #10 ex_mem_bundle = {2'b10, 3'b010, 32'h00000050, 32'h00000060, 1'b0, 5'b00011};

        // Test case 4: Memory read
        #10 ex_mem_bundle = {2'b10, 3'b001, 32'h00000070, 32'h00000080, 1'b0, 5'b00100};

        // Assert reset again
        #10 reset = 1;
        #10 reset = 0;

        // Test case 5: Branch not taken
        #10 ex_mem_bundle = {2'b10, 3'b100, 32'h00000090, 32'h000000A0, 1'b0, 5'b00101};

        // Stop the simulation after all test cases
        #50;
        $stop;
    end

   
endmodule
