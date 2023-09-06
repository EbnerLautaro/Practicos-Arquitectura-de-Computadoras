// SIGN EXTEND

module signext 
(
	input logic [31:0] a,
	output logic [63:0] y
);
	always_comb begin
		casez(a[31:21]) 
			
			// LDUR - Load Register
			// STUR - Store Register
			11'b111_1100_00?0 : y = {{55{a[20]}}, a[20:12]};
			
			// CBZ - Compare and branch if zero
			11'b101_1010_0??? : y = {{45{a[23]}}, a[23:5]};
			
			// DEFAULT CASE
			default: y = 0;
		endcase
	end
				
	// circuitcove.com/design-examples-sign-extension/
	// {45{a[23]}} -> crea un vector de 45 de largo con 
	// el valor de a[23] despues lo concatena 
	
	
endmodule
