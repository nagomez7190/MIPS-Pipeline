`timescale 1ns / 1ps

module ID_Stage (
    input clk,
    input reset,
    input [31:0] if_id_npc,
    input [31:0] if_id_instr,
    output [8:0] id_ex_control,
    output [31:0] id_ex_npc,
    output [31:0] id_ex_read_data1,
    output [31:0] id_ex_read_data2,
    output [31:0] id_ex_sign_ext,
    output [4:0] id_ex_instr_2016,
    output [4:0] id_ex_instr_1511
);
    wire [8:0] control_signals;
    wire [31:0] read_data1, read_data2, sign_ext;
    wire [4:0] instr_2016, instr_1511;

    assign instr_2016 = if_id_instr[20:16];
    assign instr_1511 = if_id_instr[15:11];

    Control control (
        .opcode(if_id_instr[31:26]),
        .control_bits(control_signals)
    );

    REG_File reg_file (
        .clk(clk),
        .reg_write(control_signals[0]),
        .rs(if_id_instr[25:21]),
        .rt(if_id_instr[20:16]),
        .rd(instr_1511),
        .write_data(32'b0), // Placeholder
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    Sign_Extend sign_extend (
        .imm(if_id_instr[15:0]),
        .sign_ext(sign_ext)
    );

    ID_EX id_ex (
        .clk(clk),
        .reset(reset),
        .control_in(control_signals),
        .npc_in(if_id_npc),
        .read_data1_in(read_data1),
        .read_data2_in(read_data2),
        .sign_ext_in(sign_ext),
        .instr_2016_in(instr_2016),
        .instr_1511_in(instr_1511),
        .control_out(id_ex_control),
        .npc_out(id_ex_npc),
        .read_data1_out(id_ex_read_data1),
        .read_data2_out(id_ex_read_data2),
        .sign_ext_out(id_ex_sign_ext),
        .instr_2016_out(id_ex_instr_2016),
        .instr_1511_out(id_ex_instr_1511)
    );
endmodule
