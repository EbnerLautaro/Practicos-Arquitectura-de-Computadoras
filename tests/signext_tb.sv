// TEST SIGN EXTEND

module signext_tb();
	logic [31:0]in;
	logic [63:0] out;
	
	signext dut (in, out);
	
	always begin
			
		// TEST LDUR
		in = 32'b11111000010_000001111_11_00000_00000; 
		#2;
		$display("IN: 000001111 - OUT: %b", out);
		
		in = 32'b11111000010_111110001_11_00000_00000;
		#2;
		$display("IN: 111110001 - OUT: %b", out);
		
		// TEST CBZ
		in = 32'b10110100_0000000000000011111_00000; 
		#2;
		$display("IN: 0000000000000011111 - OUT: %b", out);
				 
		in = 32'b10110100_1111110000000011111_00000;
		#2;
		$display("IN: 1111110000000011111 - OUT: %b", out);
		
		// TEST CBZ
		in = 32'b01110100_0000000000000011111_00000; 
		#2;
		$display("Expected: 0 - OUT: %b", out);
				 
		in = 32'b11010100_1111110000000011111_00000;
		#2;
		$display("Expected: 0 - OUT: %b", out);
		
		
		$stop;
	end
	
endmodule