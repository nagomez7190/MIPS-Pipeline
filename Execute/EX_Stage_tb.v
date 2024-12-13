`timescale 1ns / 1ps

module EX_Stage_tb;

    reg clk;
    reg reset;
    reg [143:0] id_ex_bundle;
    wire [70:0] ex_mem_bundle;

    EX_Stage NAG (
        .clk(clk),
        .reset(reset),
        .id_ex_bundle(id_ex_bundle),
        .ex_mem_bundle(ex_mem_bundle)
    );

    initial begin
    clk = 0;
        reset = 1;
        #20 reset = 0; // Release reset after 20ns
    end
    
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // 20ns clock period
    end

    initial begin
        reset = 1;
        id_ex_bundle = 144'b0;


        #20 reset = 0;

        // Test Case 1: Simple Addition
        id_ex_bundle = {
            9'b010000010,     // Control signals (ALU Add)
            32'h00000008,     // Branch target
            32'h00000010,     // ALU input 1
            32'h00000020,     // ALU input 2
            32'h00000000,     // Read data 2 (not used in this stage)
            5'b00001          // Register destination
        };
        #40;

        // Test Case 2: Subtraction
        id_ex_bundle = {
            9'b010001110,     // Control signals (ALU Subtract)
            32'h00000010,     // Branch target
            32'h00000030,     // ALU input 1
            32'h00000010,     // ALU input 2
            32'h00000000,     // Read data 2
            5'b00010          // Register destination
        };
        #40;

        // Test Case 3: Set Less Than
        id_ex_bundle = {
            9'b010011111,     // Control signals (ALU Set Less Than)
            32'h00000020,     // Branch target
            32'h00000005,     // ALU input 1
            32'h00000010,     // ALU input 2
            32'h00000000,     // Read data 2
            5'b00011          // Register destination
        };
        #40;

        // Test Case 4: Logical AND
        id_ex_bundle = {
            9'b010000000,     // Control signals (ALU AND)
            32'h00000030,     // Branch target
            32'h0000FFFF,     // ALU input 1
            32'h0000AAAA,     // ALU input 2
            32'h00000000,     // Read data 2
            5'b00100          // Register destination
        };
        #40;

        // Test Case 5: Logical OR
        id_ex_bundle = {
            9'b010000001,     // Control signals (ALU OR)
            32'h00000040,     // Branch target
            32'h0000FFFF,     // ALU input 1
            32'h0000AAAA,     // ALU input 2
            32'h00000000,     // Read data 2
            5'b00101          // Register destination
        };
        #40;

        $stop; 
    end

endmodule
