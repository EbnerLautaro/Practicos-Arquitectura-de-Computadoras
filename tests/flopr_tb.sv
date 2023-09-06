// TEST FLOP_R

module flopr_tb();
	parameter N=32;
	
	logic clk, reset; 
	logic [N-1:0] d;
	logic [N-1:0] q;
	int i, errors;
	
	logic [N-1:0] testvectors [0:9] = '{ 'd0, 
										'd1,
										'd2,
										'd3,
										'd4,
										'd5,
										'd6,
										'd7,
										'd8,
										'd9};
	
	
	
	
	// - Instanciar el modulo flopr con N=64.
	flopr #(N) dut (clk, reset, d, q);
	
	// - Clock
	always // se va a ejecutar siempre
		begin
		 clk = 1; #5; clk = 0; #5;
		end	
	
	// iniciaizamos 
	initial 
		begin
			reset=1; #52; reset=0;
			i=0; errors=0;
		end
	
	// asignacion de valores
	always @(negedge clk)
		begin
		 d = testvectors[i];
		end
			
			
	// check resultados
	always @(posedge clk) begin
	
		#1;
		
		// check reset
		if (reset) begin
			if (q !== 0)
				$display("Error, q!==0");
		end 
		
		// check guardar valores
		else begin 
					
			if (q !== testvectors[i]) begin
				$display("Error: input = %d (%d expected)", q,testvectors[i]);
				errors++;
			
			end else begin
				$display("input = %d (%d expected)", q,testvectors[i]);
			end
			i++;

			// si leemos indefinido, es decir, si estamos "afuera de la lista"
			if (testvectors[i] === 'bx)  begin
				$display("%d tests completed with %d errors", i, errors);
				$stop; 
			end
		end
	end
endmodule
	
	
	