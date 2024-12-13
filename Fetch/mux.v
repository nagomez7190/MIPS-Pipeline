`timescale 1ns / 1ps

module mux(
    input [31:0] a,
    input [31:0] b,
    input sel,
    output reg [31:0] y
  );  
  always @(*) begin
    if(sel)
        y = b;
    else
        y = a;
  end
endmodule
