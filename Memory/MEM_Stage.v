`timescale 1ns / 1ps

module MEM_Stage (
    input clk,
    input reset,
    input [70:0] ex_mem_bundle,        // Input from EX/MEM latch
    output [69:0] mem_wb_bundle,       // Output to MEM/WB latch
    output PCSrc                       // Output for branch decision
);

    wire [1:0] control_wb = ex_mem_bundle[70:69];
    wire [2:0] control_m = ex_mem_bundle[68:66];
    wire [31:0] branch_target = ex_mem_bundle[65:34];
    wire [31:0] alu_result = ex_mem_bundle[33:2];
    wire zero = ex_mem_bundle[1];
    wire [4:0] write_reg = ex_mem_bundle[0];

    wire [31:0] read_data;

    // Branch decision AND gate
    assign PCSrc = control_m[2] & zero;

    // Data Memory Module
    DataMemory dmem (
        .clk(clk),
        .MemWrite(control_m[1]),
        .MemRead(control_m[0]),
        .address(alu_result),
        .write_data(branch_target), // Assuming write_data comes from branch_target
        .read_data(read_data)
    );

    // MEM/WB Latch
    MEM_WB mem_wb (
        .clk(clk),
        .reset(reset),
        .control_wb_in(control_wb),
        .read_data_in(read_data),
        .alu_result_in(alu_result),
        .write_reg_in(write_reg),
        .control_wb_out(mem_wb_bundle[69:68]),
        .read_data_out(mem_wb_bundle[67:36]),
        .alu_result_out(mem_wb_bundle[35:4]),
        .write_reg_out(mem_wb_bundle[3:0])
    );

endmodule
