`timescale 1ns / 1ps

module DataMemory (
    input clk,
    input MemWrite,
    input MemRead,
    input [31:0] address,
    input [31:0] write_data,
    output reg [31:0] read_data
);

    reg [31:0] memory [0:255]; // 256 words of memory

    // Initial memory content
    initial begin
        $readmemh("memory_init.mem", memory); // Load memory from file
    end

    always @(posedge clk) begin
        if (MemWrite)
            memory[address[7:0]] <= write_data; // Write data to memory
    end

    always @(*) begin
        if (MemRead)
            read_data = memory[address[7:0]]; // Read data from memory
        else
            read_data = 32'b0;
    end

endmodule
