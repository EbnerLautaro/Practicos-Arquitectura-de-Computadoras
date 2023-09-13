module execute 
#(parameter N=64)
(	
	input logic BranchToReg,
	input logic [1:0] AluSrc,
	input logic [3:0] AluControl,
	input logic [N-1:0] PC_E, signImm_E, readData1_E, readData2_E, readData3_E,
	output logic [N-1:0] PCBranch_E, aluResult_E, writeData_E,
	output logic zero_E
);

	logic [N-1:0] mux_out, sl2_out, adder_out;
	
	

	mux4  #(N) MUX_E(
		.d0(readData2_E), 
		.d1(signImm_E), 
		.d2(readData3_E), 
		.d3(readData3_E), 
		.s(AluSrc), 
		.y(mux_out)
	);
	
	
	alu ALU(
		.a(readData1_E), 
		.b(mux_out), 
		.ALUControl(AluControl), 
		.result(aluResult_E), 
		.zero(zero_E)
	);
	
	sl2 #(N) ShiftLeft_E(
		.a(signImm_E), 
		.y(sl2_out)
	);
	
	adder #(N) Add_E(
		sl2_out, 
		PC_E, 
		adder_out
	);

	mux2 #N muxPC(
		.d0(adder_out),
		.d1(readData1_E),
		.s(BranchToReg),
		.y(PCBranch_E)
		);
	
	assign writeData_E = readData2_E;
endmodule
