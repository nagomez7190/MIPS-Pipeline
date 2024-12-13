`timescale 1ns / 1ps

module Sign_Extend_tb;

    reg [15:0] imm;
    wire [31:0] sign_ext;

    Sign_Extend NAG (.imm(imm),.sign_ext(sign_ext) );

    initial begin
        $monitor("Time: %0dns | Immediate: %h | Sign-Extended: %h", $time, imm, sign_ext);

        // Test Case 1: Positive immediate
        imm = 16'h1234; // No sign extension required
        #10;
        // Test Case 2: Negative immediate
        imm = 16'hF234; // Sign bit (MSB) = 1; should extend with 1's
        #10;
        // Test Case 3: Small positive number
        imm = 16'h0007; // Sign bit (MSB) = 0; should extend with 0's
        #10;
        // Test Case 4: Small negative number
        imm = 16'hFFF8; // Sign bit (MSB) = 1; should extend with 1's
        #10;
        // Test Case 5: Zero
        imm = 16'h0000; // All bits 0; should extend with 0's
        #10;
        $finish;
    end
endmodule
