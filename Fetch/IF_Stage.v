module IF_Stage(
    input clk,
    input reset,
    input pcsrc,         // Control signal to select next PC
    output [31:0] pc_out, // Current PC value
    output [31:0] if_id_ir, // Instruction output
    output [31:0] if_id_npc // Next PC value for the pipeline
);
    // Internal wires for connections
    wire [31:0] pc, npc, instruc, mux_out;

    ProgramCounter pc_reg(
        .clk(clk),
        .reset(reset),
        .pc_in(mux_out), // PC input from MUX
        .pc_out(pc)      // Current PC output
    );

    InstructMem imem(
        .add(pc[6:0]),      // PC address 
        .instruc(instruc)   // Fetched instruction
    );

    Incrementor_by_4 inc(
        .pc_in(pc),         // Current PC
        .pc_out(npc)        // Next sequential PC
    );

    mux NAG(
        .a(npc),            // Next sequential PC
        .b(32'b0),          // Placeholder for branch target
        .sel(pcsrc),        // Control signal
        .y(mux_out)         // Output selected PC
    );
    
    IF_ID if_id(
        .clk(clk),
        .reset(reset),
        .npc_in(npc),         // Next sequential PC
        .instruction_in(instruc), // Instruction fetched
        .npc_out(if_id_npc),     // Output next PC to ID stage
        .instruction_out(if_id_ir) // Output instruction to ID stage
    );

    
    assign pc_out = pc; // Expose current PC as output
endmodule
