`timescale 1ns / 1ps

module mux_tb;

    
    reg [31:0] a, b;     
    reg sel;             
    wire [31:0] y;       

    mux mui (  .a(a), .b(b), .sel(sel), .y(y) );
    initial begin
        $monitor("Time: %0dns | a: %h | b: %h | sel: %b | y: %h", $time, a, b, sel, y);

        // Test Case 1: sel = 0, output should be a
        a = 32'h12345678; // Input a
        b = 32'h87654321; // Input b
        sel = 0;
        #10;

        // Test Case 2: sel = 1, output should be b
        sel = 1;
        #10;

        // Test Case 3: Update inputs, sel = 0
        a = 32'hDEADBEEF; // New input a
        b = 32'hCAFEBABE; // New input b
        sel = 0;
        #10;

        // Test Case 4: Update inputs, sel = 1
        sel = 1;
        #10;

        // Test Case 5: All inputs are zero
        a = 32'h00000000;
        b = 32'h00000000;
        sel = 0;
        #10;

        // Test Case 6: sel toggling between a and b
        sel = 1;
        #10;
        sel = 0;
        #10;
        $finish;
    end

endmodule
