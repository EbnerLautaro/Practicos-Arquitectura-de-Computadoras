// FLOP_R

module flopr 
#(parameter N=64) 
(	
	input logic clk, 
	input logic reset, 
	input logic [N-1:0] d, 
	output logic [N-1:0] q
);
	
	// reset asincrono
	always_ff @(posedge clk, posedge reset)
		if (reset) q <= '0;
		else q <= d;
		
endmodule