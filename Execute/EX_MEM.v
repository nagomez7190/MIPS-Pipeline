`timescale 1ns / 1ps

module EX_MEM (
    input clk,
    input reset,                        // Reset signal to initialize outputs
    input [70:0] ex_mem_bundle_in,      // Reduced bundled input
    output reg [70:0] ex_mem_bundle_out // Reduced bundled output
);

    // Always block for updating output registers
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ex_mem_bundle_out <= 71'b0; // Initialize output to zero on reset
        end else begin
            ex_mem_bundle_out <= ex_mem_bundle_in; // Latch input on rising clock edge
        end
    end
endmodule
