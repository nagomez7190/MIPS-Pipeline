module EX_Stage (
    input clk,
    input reset,
    input [143:0] id_ex_bundle,  // Bundled input: control, NPC, reg data, etc.
    output [70:0] ex_mem_bundle  // Reduced bundled output: control, ALU result, etc.
);

    wire [8:0] control_signals = id_ex_bundle[143:135];
    wire [31:0] alu_input1 = id_ex_bundle[102:71];
    wire [31:0] alu_input2 = id_ex_bundle[70:39];
    wire [31:0] branch_target = id_ex_bundle[134:103];
    wire [4:0] reg_dest = id_ex_bundle[6:2];
    wire [31:0] alu_result;
    wire alu_zero;

    ALU GREEN (
        .A(alu_input1),
        .B(alu_input2),
        .control(control_signals[3:1]), // ALU control bits
        .result(alu_result),
        .zero(alu_zero)
    );

    // Instantiate Branch Target Adder
    Adder RED (
        .add_in1(branch_target),
        .add_in2(alu_input2), // Assuming branch target logic
        .add_out(branch_target)
    );

    // Reduced EX_MEM Latch
    EX_MEM BAMF (
        .clk(clk),
        .reset(reset),
        .ex_mem_bundle_in({control_signals[8:4], alu_result, alu_zero, reg_dest}), // Reduced bundle
        .ex_mem_bundle_out(ex_mem_bundle)
    );

endmodule
