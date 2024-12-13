`timescale 1ns / 1ps

module IF_Stage_tb;
    reg clk;               
    reg reset;              // Reset signal
    reg pcsrc;              // PC source control signal
    wire [31:0] pc_out;     // Current PC value
    wire [31:0] if_id_ir;   // Instruction fetched
    wire [31:0] if_id_npc;  // Next PC value

    IF_Stage MOON (.clk(clk),.reset(reset),.pcsrc(pcsrc), .pc_out(pc_out),.if_id_ir(if_id_ir),.if_id_npc(if_id_npc));


    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        // Monitor the key signals
        $monitor("Time: %0dns | Reset: %b | PCSrc: %b | PC Out: %h | NPC: %h | IR: %h",
                 $time, reset, pcsrc, pc_out, if_id_npc, if_id_ir);
      
        reset = 1;
        pcsrc = 0;
        #10; // Wait for one clock cycle
        // Release reset
        reset = 0;
        #10; // Observe sequential operation
        // Test Case 1: Normal operation, PC increment
        #20; // Allow PC to increment normally
        // Test Case 2: Apply PCSrc 
        pcsrc = 1; // Force MUX to select branch target 
        #10;
        pcsrc = 0; // Return to normal sequential increment
        #20;
        // Test Case 3: Reset in the middle of execution
        reset = 1; // Reset PC and pipeline registers
        #10;
        reset = 0; // Resume operation
        #20;
        // Test Case 4: Continue normal operation
        #40;

        $finish;
    end

endmodule
