I am instantiating IF_Stage module from folder Fetch within this code and will not post the code in this folder again as it is redundant. 
Hopefully there is no confusion and also Pipeline top module was neccessary in order to control the amount of ports neccessary for my specific fpga.

`timescale 1ns / 1ps

module Pipeline (
    input clk,
    input reset,
    input pcsrc,                  // PC source control signal
    output [31:0] pc_out,         // Current PC value
    output [143:0] id_ex_bundle   // Output from ID/EX pipeline register
);
    // Internal wires
    wire [31:0] if_id_ir;         // Instruction fetched
    wire [31:0] if_id_npc;        // Next sequential PC
    wire [63:0] if_id_bundle;     // Bundled NPC and instruction
    wire [143:0] id_stage_out;    // Bundled output from ID_Stage

    // Instantiate the IF_Stage from Lab 1
    IF_Stage Nunna (
        .clk(clk),
        .reset(reset),
        .pcsrc(pcsrc),
        .pc_out(pc_out),
        .if_id_ir(if_id_ir),
        .if_id_npc(if_id_npc)
    );

    // Bundle the IF_Stage outputs
    assign if_id_bundle = {if_id_npc, if_id_ir};

    // Instantiate the ID_Stage
    ID_Stage Arazate (
        .clk(clk),
        .reset(reset),
        .if_id_bundle(if_id_bundle),
        .id_ex_bundle(id_stage_out)
    );

    // Instantiate the ID_EX pipeline register
    ID_EX Kevbo (
        .clk(clk),
        .reset(reset),
        .bundled_in(id_stage_out),
        .bundled_out(id_ex_bundle)
    );

endmodule
  
