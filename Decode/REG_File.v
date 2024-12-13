`timescale 1ns / 1ps

module REG_File (
    input clk,
    input reg_write,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);
    reg [31:0] registers [0:31]; // 32 registers, 32 bits each

    // Read operations
    assign read_data1 = registers[rs];
    assign read_data2 = registers[rt];

    // Write operation
    always @(posedge clk) begin
        if (reg_write)
            registers[rd] <= write_data;
    end
endmodule
