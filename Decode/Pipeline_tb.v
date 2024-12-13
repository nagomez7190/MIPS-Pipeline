`timescale 1ns / 1ps

module Pipeline_tb;

    reg clk;
    reg reset;
    reg pcsrc;
    wire [31:0] pc_out;
    wire [143:0] id_ex_bundle;

    Pipeline NAG (
        .clk(clk),
        .reset(reset),
        .pcsrc(pcsrc),
        .pc_out(pc_out),
        .id_ex_bundle(id_ex_bundle)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        reset = 1;
        pcsrc = 0;

        #10 reset = 0;

        // Test PC source control signal (branch taken scenario)
        #50 pcsrc = 1;
        #20 pcsrc = 0;

        // Allow simulation to run for some cycles
        #100;

        // Stop the simulation
        $stop;
    end


endmodule
