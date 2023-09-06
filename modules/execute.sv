// EXECUTE

module execute
#(parameter N = 64)
(
	input logic AluSrc,
	input logic [3:0] AluControl,
	input logic [N-1:0] PC_E, signImm_E, readData1_E, readData2_E,
	output logic [N-1:0] PCBranch_E, aluResult_E, writeData_E,
	output logic zero_E
);

	// variables internas (temporales)
	logic [N-1:0] mux_out;
	logic [N-1:0] sl2_out;

	sl2 #(.N(N)) ShiftLeft2(
		.a(signImm_E),
		.y(sl2_out)
	);
	
	adder #(.N(N)) Add(
		.a(sl2_out),
		.b(PC_E),
		.y(PCBranch_E)
	);
	
	mux2 #(.N(N)) MUX(
		.d0(readData2_E),
		.d1(signImm_E),
		.s(AluSrc),
		.y(mux_out)
	);
	
	alu	ALU (
		.a(readData1_E),
		.b(mux_out),
		.ALUControl(AluControl),
		.result(aluResult_E),
		.zero(zero_E)
	);
	
	assign writeData_E = readData2_E;


endmodule 