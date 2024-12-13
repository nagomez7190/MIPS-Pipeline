`timescale 1ns / 1ps

module MEM_WB_tb;

    reg clk;
    reg reset;
    reg [1:0] control_wb_in;
    reg [31:0] read_data_in;
    reg [31:0] alu_result_in;
    reg [4:0] write_reg_in;
    wire [1:0] control_wb_out;
    wire [31:0] read_data_out;
    wire [31:0] alu_result_out;
    wire [4:0] write_reg_out;

    MEM_WB NAG (
        .clk(clk),
        .reset(reset),
        .control_wb_in(control_wb_in),
        .read_data_in(read_data_in),
        .alu_result_in(alu_result_in),
        .write_reg_in(write_reg_in),
        .control_wb_out(control_wb_out),
        .read_data_out(read_data_out),
        .alu_result_out(alu_result_out),
        .write_reg_out(write_reg_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end


    initial begin
        reset = 1;
        control_wb_in = 2'b0;
        read_data_in = 32'b0;
        alu_result_in = 32'b0;
        write_reg_in = 5'b0;

        #10 reset = 0;

        // Test case 1: Write to the MEM/WB register
        control_wb_in = 2'b11;
        read_data_in = 32'hA5A5A5A5;
        alu_result_in = 32'h12345678;
        write_reg_in = 5'b10101;
        #10;

        // Test case 2: Update with new values
        control_wb_in = 2'b10;
        read_data_in = 32'h55555555;
        alu_result_in = 32'h87654321;
        write_reg_in = 5'b01010;
        #10;

        // Test case 3: Assert reset
        reset = 1;
        #10 reset = 0;

        // Test case 4: Write again after reset
        control_wb_in = 2'b01;
        read_data_in = 32'hFFFFFFFF;
        alu_result_in = 32'h00000000;
        write_reg_in = 5'b11111;
        #10;

        $stop;
    end
endmodule
