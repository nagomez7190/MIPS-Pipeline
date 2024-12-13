`timescale 1ns / 1ps

module Incrementor_by_4_tb;

    reg [31:0] pc_in;    
    wire [31:0] pc_out;   
      
    Incrementor_by_4 JOE (
        .pc_in(pc_in),
        .pc_out(pc_out)
    );
    initial begin
        // Monitor the input and output signals
        $monitor("Time: %0dns | PC In: %h | PC Out: %h", $time, pc_in, pc_out);
        // Test Case 1: Initial PC value
        pc_in = 32'h00000000; // Set PC to 0
        #10;
        // Test Case 2: Increment PC
        pc_in = 32'h00000004; // Set PC to 4
        #10;
        // Test Case 3: Higher PC value
        pc_in = 32'h00000010; // Set PC to 16
        #10;
        // Test Case 4: Large PC value
        pc_in = 32'hFFFFFFFC; // Set PC near maximum value
        #10;
        // Test Case 5: PC wrap-around (theoretical case)
        pc_in = 32'hFFFFFFFE; // Set PC near maximum to observe increment behavior
        #10;
        // Test Case 6: Random PC value
        pc_in = 32'h12345678; // Random PC value
        #10;

        $finish;
    end

endmodule
