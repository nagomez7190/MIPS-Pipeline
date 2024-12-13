`timescale 1ns / 1ps

module REG_File (
    input clk,
    input reg_write,               // Control signal for write enable
    input [4:0] rs,                // Source register 1
    input [4:0] rt,                // Source register 2
    input [4:0] rd,                // Destination register
    input [31:0] write_data,       // Data to write into destination register
    output [31:0] read_data1,      // Data read from source register 1
    output [31:0] read_data2       // Data read from source register 2
);
    reg [31:0] registers [0:31];   // 32 registers, 32 bits each
    integer i;

    // Initialize all registers to 0 during simulation
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'b0;
        end
    end

    // Read operations (combinational logic)
    assign read_data1 = registers[rs];
    assign read_data2 = registers[rt];

    // Write operation (synchronous logic)
    always @(posedge clk) begin
        if (reg_write && rd != 5'b00000) begin
            // Prevent writing to register 0 (hardwired to 0 in MIPS)
            registers[rd] <= write_data;
        end
    end
endmodule
