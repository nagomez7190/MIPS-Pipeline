`timescale 1ns / 1ps

module IF_ID(
    input clk, 
    input reset,
    input [31:0] npc_in, 
    input [31:0] instruction_in,
    output reg [31:0] npc_out, instruction_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            npc_out <= 32'b0;
            instruction_out <= 32'b0;
        end else begin
            npc_out <= npc_in;
            instruction_out <= instruction_in;
        end
    end
endmodule
