// TEST FETCH

module fetch_tb();

	logic PCSrc_F, clk, reset;
	logic [63:0] PCBranch_F;
	logic [63:0] imem_addr_F;

	
	// device under test
	fetch dut(
		.PCSrc_F(PCSrc_F), .clk(clk), .reset(reset),
		.PCBranch_F(PCBranch_F),
		.imem_addr_F(imem_addr_F)
	);

	// Reloj de periodo 10ns
	always begin
		clk = 1; #5ns; clk = 0; #5ns;
	end

	initial begin
		reset = 1;
		#50ns;
		reset = 0;
	end

	logic [63:0] last_PC;
	int errors;
	
	initial begin
	
		$display("\n\n START TEST FETCH \n\n ");
	
	
		errors = 0;
		last_PC = 0;
		PCSrc_F = 1'b0;
		PCBranch_F = 64'd4004;

		#50ns;
		
		if (imem_addr_F !== 0) begin 
			$display("ERROR: imem_addr_F !== 0. imem_addr_F = %d", imem_addr_F);
		end

		for (int i=0; i<100; ++i) begin
			// posedge
			#5ns;

			// negedge
			if (last_PC + 4 !== imem_addr_F) begin
				$display("ERROR: last_PC + 4 !== imem_addr_F. last_PC = %d, imem_addr_F = %d", last_PC, imem_addr_F);
				errors++;
			end
			last_PC = imem_addr_F;

			#5ns;
		end

		// posedge
		#5ns;
		// negedge
		PCSrc_F = 1'b1;
		#10ns;
		if (64'd4004 !== imem_addr_F) begin
			$display("ERROR: 64'd4004 !== imem_addr_F");
			errors++;
		end

		$display("Total errors: %d", errors);
		
		$display("\n\n END TEST FETCH \n\n ");
		
		$stop;

	end


endmodule