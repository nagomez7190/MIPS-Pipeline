`timescale 1ns / 1ps

module Pipeline (
    input clk,
    input reset,
    output [31:0] wb_data // Final write-back data
);
    // Internal Wires
    wire [31:0] pc_out; // Current PC value
    wire [31:0] if_id_ir, if_id_npc; // IF/ID outputs
    wire [63:0] if_id_bundle; // Bundled IF/ID outputs
    wire [143:0] id_ex_bundle; // ID/EX bundled outputs
    wire [70:0] ex_mem_bundle; // EX/MEM bundled outputs
    wire [69:0] mem_wb_bundle; // MEM/WB bundled outputs
    wire pcsrc; // Branch decision signal

    // Instantiate IF Stage
    IF_Stage Dwight (
        .clk(clk),
        .reset(reset),
        .pcsrc(pcsrc),
        .pc_out(pc_out),
        .if_id_ir(if_id_ir),
        .if_id_npc(if_id_npc)
    );

    // Bundle IF/ID outputs
    assign if_id_bundle = {if_id_npc, if_id_ir};

    // Instantiate ID Stage
    ID_Stage Micheal (
        .clk(clk),
        .reset(reset),
        .if_id_bundle(if_id_bundle),
        .id_ex_bundle(id_ex_bundle)
    );

    // Instantiate ID/EX Pipeline Register
    ID_EX Jim (
        .clk(clk),
        .reset(reset),
        .bundled_in(id_ex_bundle),
        .bundled_out(id_ex_bundle)
    );

    // Instantiate EX Stage
    EX_Stage Pam (
        .clk(clk),
        .reset(reset),
        .id_ex_bundle(id_ex_bundle),
        .ex_mem_bundle(ex_mem_bundle)
    );

    // Instantiate MEM Stage
    MEM_Stage Angela (
        .clk(clk),
        .reset(reset),
        .ex_mem_bundle(ex_mem_bundle),
        .mem_wb_bundle(mem_wb_bundle),
        .PCSrc(pcsrc)
    );

    // Instantiate WB Stage
    WB_Stage Kevin (
        .mem_control_wb(mem_wb_bundle[69:68]),
        .mem_read_data(mem_wb_bundle[67:36]),
        .mem_alu_result(mem_wb_bundle[35:4]),
        .wb_data(wb_data)
    );

endmodule
