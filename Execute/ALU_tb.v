`timescale 1ns / 1ps

module ALU_tb;

    reg [31:0] A;
    reg [31:0] B;
    reg [2:0] control;
    wire [31:0] result;
    wire zero;

    ALU NAG (
        .A(A),
        .B(B),
        .control(control),
        .result(result),
        .zero(zero)
    );

    initial begin
        A = 32'b0;
        B = 32'b0;
        control = 3'b000;

        // Test AND operation
        #10 A = 32'h0F0F0F0F; B = 32'h00FF00FF; control = 3'b000; // A & B
        #10 $display("AND: A = %h, B = %h, Result = %h, Zero = %b", A, B, result, zero);
        // Test OR operation
        #10 A = 32'h0F0F0F0F; B = 32'h00FF00FF; control = 3'b001; // A | B
        #10 $display("OR: A = %h, B = %h, Result = %h, Zero = %b", A, B, result, zero);
        // Test Add operation
        #10 A = 32'd10; B = 32'd20; control = 3'b010; // A + B
        #10 $display("ADD: A = %d, B = %d, Result = %d, Zero = %b", A, B, result, zero);
        // Test Subtract operation (result is non-zero)
        #10 A = 32'd50; B = 32'd20; control = 3'b110; // A - B
        #10 $display("SUB: A = %d, B = %d, Result = %d, Zero = %b", A, B, result, zero);
        // Test Subtract operation (result is zero)
        #10 A = 32'd30; B = 32'd30; control = 3'b110; // A - B
        #10 $display("SUB (Zero): A = %d, B = %d, Result = %d, Zero = %b", A, B, result, zero);
        // Test Set Less Than (A < B)
        #10 A = 32'd15; B = 32'd30; control = 3'b111; // A < B
        #10 $display("SLT: A = %d, B = %d, Result = %d, Zero = %b", A, B, result, zero);
        // Test Set Less Than (A >= B)
        #10 A = 32'd40; B = 32'd30; control = 3'b111; // A >= B
        #10 $display("SLT (False): A = %d, B = %d, Result = %d, Zero = %b", A, B, result, zero);
        // Test Default case
        #10 control = 3'b011; // Undefined control code
        #10 $display("Default: A = %h, B = %h, Result = %h, Zero = %b", A, B, result, zero);

        #10 $stop;
    end
endmodule
