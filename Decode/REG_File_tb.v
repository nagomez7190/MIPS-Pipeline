`timescale 1ns / 1ps

module REG_File_tb;

    reg clk;
    reg reg_write;
    reg [4:0] rs;
    reg [4:0] rt;
    reg [4:0] rd;
    reg [31:0] write_data;
    
    wire [31:0] read_data1;
    wire [31:0] read_data2;

    REG_File NAG (.clk(clk),.reg_write(reg_write),.rs(rs),.rt(rt),.rd(rd), .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    initial begin
        reg_write = 0;
        rs = 5'b0;
        rt = 5'b0;
        rd = 5'b0;
        write_data = 32'b0;

        $monitor("Time: %0dns | rs: %d | rt: %d | rd: %d | write_data: %h | read_data1: %h | read_data2: %h", 
                  $time, rs, rt, rd, write_data, read_data1, read_data2);

        // Test Case 1: Write to Register 5
        #10;
        reg_write = 1;
        rd = 5'b00101;       // Register 5
        write_data = 32'hA5A5A5A5; // Data to write
        #10;
        // Test Case 2: Read from Register 5 and 10
        reg_write = 0;
        rs = 5'b00101;       // Read from Register 5
        rt = 5'b01010;       // Read from Register 10
        #10;
        // Test Case 3: Write to Register 10
        reg_write = 1;
        rd = 5'b01010;       // Register 10
        write_data = 32'h5A5A5A5A; // Data to write
        #10;
        // Test Case 4: Read from Register 10
        reg_write = 0;
        rs = 5'b01010;       // Read from Register 10
        rt = 5'b0;           // Read from Register 0
        #10;
        // Test Case 5: Read from unmodified Register 15
        rs = 5'b01111;       // Read from Register 15
        #10;
        // Test Case 6: Write to Register 15 and verify
        reg_write = 1;
        rd = 5'b01111;       // Register 15
        write_data = 32'h12345678; // Data to write
        #10;
        reg_write = 0;
        rs = 5'b01111;       // Read from Register 15
        #10;
        $finish;
    end
endmodule
