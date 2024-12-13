`timescale 1ns / 1ps

module Pipeline_tb;

    reg clk;
    reg reset;
    wire [31:0] wb_data;


    Pipeline NAG (
        .clk(clk),
        .reset(reset),
        .wb_data(wb_data)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        #10;
        reset = 0;
        #100;
        $display("Write-back data: %h", wb_data);
        #100;

        $stop;
    end

endmodule
