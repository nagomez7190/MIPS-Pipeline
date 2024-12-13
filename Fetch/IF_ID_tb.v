`timescale 1ns / 1ps

module IF_ID_tb;

    reg clk;
    reg reset;
    reg [31:0] npc_in;
    reg [31:0] instruction_in;
    wire [31:0] npc_out;
    wire [31:0] instruction_out;

   
    IF_ID JAG (
        .clk(clk),
        .reset(reset),
        .npc_in(npc_in),
        .instruction_in(instruction_in),
        .npc_out(npc_out),
        .instruction_out(instruction_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    // Test sequence
    initial begin
        reset = 1;
        npc_in = 0;
        instruction_in = 0;

      
        #10;
        reset = 0;

        // Test Case 1: Normal operation
        npc_in = 32'h00000004;         
        instruction_in = 32'h8C090004; 
        #10; 

        // Test Case 2: Update values
        npc_in = 32'h00000008;          
        instruction_in = 32'h01094020; 
        #10; 

        // Test Case 3: Reset operation
        reset = 1;
        #10; 
        reset = 0;

        // Test Case 4: Apply new values after reset
        npc_in = 32'h0000000C;        
        instruction_in = 32'hAC080008; 
        #10; // Wait for clock edge

        // Finish simulation
        $finish;
    end
endmodule
