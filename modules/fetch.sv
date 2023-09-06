// FETCH

module fetch 
(
	input logic PCSrc_F, clk, reset,
	input logic [63:0] PCBranch_F,
	output logic [63:0] imem_addr_F
);

	// variables internas (temporales)
	logic [63:0] add_out;
	logic [63:0] mux_out; 
	// constante 4 para el adder
	logic [63:0] four = 'd4;
	
	
	mux2  #(.N(64)) MUX(
		.d0(add_out), 
		.d1(PCBranch_F), 
		.s(PCSrc_F), 
		.y(mux_out)
	);
	
	flopr #(.N(64)) PC(
		.clk(clk), 
		.reset(reset), 
		.d(mux_out), 
		.q(imem_addr_F)
	);
	
	adder #(.N(64)) Add(
		.a(imem_addr_F), 
		.b(four), 
		.y(add_out)
	);

endmodule 