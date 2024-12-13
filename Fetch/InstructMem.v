`timescale 1ns / 1ps

module InstructMem(
    input [6:0] add,
    output reg [31:0] instruc
    );
     reg [31:0] mem [0:127]; 
     integer i;
    initial begin
        // Initialize the first 10 instructions in hex
        mem[0]  = 32'h20080001; // Address 0x00000000
        mem[1]  = 32'h8C090004; // Address 0x00000004
        mem[2]  = 32'h01094020; // Address 0x00000008
        mem[3]  = 32'hAC080008; // Address 0x0000000C
        mem[4]  = 32'h08000003; // Address 0x00000010
        mem[5]  = 32'h20080002; // Address 0x00000014
        mem[6]  = 32'h8C090008; // Address 0x00000018
        mem[7]  = 32'h01094820; // Address 0x0000001C
        mem[8]  = 32'hAC08000C; // Address 0x00000020
        mem[9]  = 32'h08000006; // Address 0x00000024

        // Initialize the remaining memory to 0
        for (i = 10; i < 128; i = i + 1) begin
            mem[i] = 32'b0;
        end
    end

    
    always @(add) begin
        instruc = mem[add >> 2]; 
    end
endmodule
