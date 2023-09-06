// FETCH

module fetch 
#(parameter N = 64)
(
	input logic PCSrc_F, clk, reset,
	input logic [N-1:0] PCBranch_F,
	output logic [N-1:0] imem_addr_F
);

	// variables internas (temporales)
	logic [N-1:0] add_out;
	logic [N-1:0] mux_out; 
	// constante 4 para el adder
	const logic [N-1:0] four = 'd4;
	
	
	mux2  #(.N(N)) MUX(
		.d0(add_out), 
		.d1(PCBranch_F), 
		.s(PCSrc_F), 
		.y(mux_out)
	);
	
	flopr #(.N(N)) PC(
		.clk(clk), 
		.reset(reset), 
		.d(mux_out), 
		.q(imem_addr_F)
	);
	
	adder #(.N(N)) Add(
		.a(imem_addr_F), 
		.b(four), 
		.y(add_out)
	);

endmodule 