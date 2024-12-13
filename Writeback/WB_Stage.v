`timescale 1ns / 1ps

module WB_Stage (
    input [1:0] mem_control_wb, // Control signals from MEM/WB
    input [31:0] mem_read_data, // Data read from memory
    input [31:0] mem_alu_result, // ALU result from MEM/WB
    output [31:0] wb_data // Data to be written back to registers
);

    // Multiplexer for selecting between memory data and ALU result
    assign wb_data = (mem_control_wb[1]) ? mem_read_data : mem_alu_result;

endmodule
