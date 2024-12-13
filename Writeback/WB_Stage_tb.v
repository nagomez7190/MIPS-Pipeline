`timescale 1ns / 1ps

module WB_Stage_tb;

    reg [1:0] mem_control_wb;
    reg [31:0] mem_read_data;
    reg [31:0] mem_alu_result;
    wire [31:0] wb_data;

    WB_Stage NAG (
        .mem_control_wb(mem_control_wb),
        .mem_read_data(mem_read_data),
        .mem_alu_result(mem_alu_result),
        .wb_data(wb_data)
    );

    initial begin
        mem_control_wb = 2'b00;
        mem_read_data = 32'hAAAAAAAA;
        mem_alu_result = 32'h55555555;

        #10 mem_control_wb = 2'b10; // Select mem_read_data
        #10 mem_control_wb = 2'b00; // Select mem_alu_result
        #10 $finish; 
    end

endmodule
