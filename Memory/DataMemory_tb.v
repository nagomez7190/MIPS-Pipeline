`timescale 1ns / 1ps

module DataMemory_tb;

    reg clk;
    reg MemWrite;
    reg MemRead;
    reg [31:0] address;
    reg [31:0] write_data;
    wire [31:0] read_data;

    DataMemory NAG (
        .clk(clk),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        MemWrite = 0;
        MemRead = 0;
        address = 32'b0;
        write_data = 32'b0;

        #10;

        // Test case 1: Write data to memory
        MemWrite = 1;
        address = 32'h00000010;
        write_data = 32'hA5A5A5A5;
        #10 MemWrite = 0; // Disable write

        // Test case 2: Read data from memory
        MemRead = 1;
        address = 32'h00000010;
        #10 MemRead = 0; // Disable read

        // Test case 3: Write and read at different addresses
        MemWrite = 1;
        address = 32'h00000020;
        write_data = 32'h12345678;
        #10 MemWrite = 0;

        MemRead = 1;
        address = 32'h00000020;
        #10 MemRead = 0;

        // Test case 4: Read uninitialized memory
        MemRead = 1;
        address = 32'h00000030;
        #10 MemRead = 0;

        #20;
        $stop;
    end

endmodule
