`timescale 1ns / 1ps

module ID_Stage_tb;

    reg clk;
    reg reset;
    reg [63:0] if_id_bundle; // Bundled input: NPC and instruction
    wire [143:0] id_ex_bundle; // Bundled output: control signals, NPC, read data, sign-ext, etc.

    ID_Stage NAG (
        .clk(clk),
        .reset(reset),
        .if_id_bundle(if_id_bundle),
        .id_ex_bundle(id_ex_bundle)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    initial begin
        $monitor("Time: %0dns | if_id_bundle: %h | id_ex_bundle: %h", $time, if_id_bundle, id_ex_bundle);

        reset = 1;
        if_id_bundle = 64'b0;
        #10;
        reset = 0;
        // Test Case 1: R-format instruction (add)
        if_id_bundle = {32'h00000000, 32'b000000_00101_01010_01111_00000_100000}; // NPC = 0x00000000
        #10;
        // Test Case 2: lw instruction
        if_id_bundle = {32'h00000010, 32'b100011_00101_01010_0000000000100000}; // NPC = 0x00000010
        #10;
        // Test Case 3: sw instruction
        if_id_bundle = {32'h00000020, 32'b101011_00101_01010_0000000000110000}; // NPC = 0x00000020
        #10;
        // Test Case 4: beq instruction
        if_id_bundle = {32'h00000030, 32'b000100_00101_01010_0000000001000000}; // NPC = 0x00000030
        #10;
        // Test Case 5: Invalid instruction
        if_id_bundle = {32'h00000040, 32'b111111_00000_00000_0000000000000000}; // NPC = 0x00000040
        #10;
        // Test Case 6: Write to and read from registers in REG_File
        // Simulate some register write and read operations indirectly via ID_Stage
        if_id_bundle = {32'h00000050, 32'b000000_00101_00110_00111_00000_100000}; // R-format (rs=5, rt=6, rd=7)
        #10;
        $finish;
    end

endmodule
