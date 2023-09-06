// FLOP_R

module flopr 
#(parameter width=64) 
(	
	input logic clk, 
	input logic reset, 
	input logic [width-1:0] d, 
	output logic [width-1:0] q
);
	
	// reset asincrono
	always_ff @(posedge clk, posedge reset)
		if (reset) q <= '0;
		else q <= d;
		
endmodule