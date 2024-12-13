`timescale 1ns / 1ps

module ID_Stage (
    input clk,
    input reset,
    input [63:0] if_id_bundle,   // Bundled input: NPC and instruction
    output reg [143:0] id_ex_bundle // Bundled output: control signals, NPC, read data, sign-ext, etc.
);
    wire [8:0] control_signals;
    wire [31:0] npc, read_data1, read_data2, sign_ext;
    wire [4:0] instr_2016, instr_1511;

    assign npc = if_id_bundle[63:32];
    assign instr_2016 = if_id_bundle[20:16];
    assign instr_1511 = if_id_bundle[15:11];

    Control Chim (
        .opcode(if_id_bundle[31:26]),
        .control_bits(control_signals)
    );

    REG_File LUF (
        .clk(clk),
        .reg_write(control_signals[0]),
        .rs(if_id_bundle[25:21]),
        .rt(if_id_bundle[20:16]),
        .rd(instr_1511),
        .write_data(32'b0), // Placeholder for WB stage data
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    Sign_Extend Tom (
        .imm(if_id_bundle[15:0]),
        .sign_ext(sign_ext)
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            id_ex_bundle <= 144'b0; // Initialize to zero on reset
        end else begin
            id_ex_bundle <= {control_signals, npc, read_data1, read_data2, sign_ext, instr_2016, instr_1511};
        end
    end

endmodule
