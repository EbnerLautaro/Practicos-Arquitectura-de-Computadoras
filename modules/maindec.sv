// MAINDEC

module maindec
(
		input logic [10:0] Op,
		input logic reset, // nuevo
		output logic Reg2Loc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, 
		output logic NotAnInstr, ERet, // nuevo
		output logic [1:0] ALUOp, ALUSrc, // modificado
		output logic [3:0] EStatus // nuevo
);

	always_comb begin
	
		if (reset) begin 
			Reg2Loc 	<= 1'b0;
			MemtoReg 	<= 1'b0;
			RegWrite 	<= 1'b0;
			MemRead 	<= 1'b0;
			MemWrite 	<= 1'b0;
			Branch 		<= 1'b0;
			ALUOp 		<= 2'b00;
			ALUSrc		<= 2'b00;
			ERet		<= 1'b0;
			EStatus 	<= 4'b0000;

		
		end else begin 
		
			casez(Op)
		
				// LDUR
				11'b111_1100_0010: begin 
					Reg2Loc 	<= 1'bx;
					ALUSrc 		<= 2'b01;
					MemtoReg 	<= 1'b1;
					RegWrite 	<= 1'b1;
					MemRead 	<= 1'b1;
					MemWrite 	<= 1'b0;
					Branch 		<= 1'b0;
					ALUOp 		<= 2'b00;
					ERet		<= 1'b0;
					EStatus 	<= 4'b0000;
					NotAnInstr	<= 1'b0;
				end
					
				// STUR
				11'b111_1100_0000: begin   
					Reg2Loc 	<= 1'b1;
					ALUSrc 		<= 2'b01;
					MemtoReg 	<= 1'bx;
					RegWrite 	<= 1'b0;
					MemRead 	<= 1'b0;
					MemWrite 	<= 1'b1;
					Branch 		<= 1'b0;
					ALUOp 		<= 2'b00;
					ERet		<= 1'b0;
					EStatus 	<= 4'b0000;
					NotAnInstr	<= 1'b0;
				end
				
				// CBZ
				11'b101_1010_0???: begin   
					Reg2Loc 	<= 1'b1;
					ALUSrc 		<= 2'b00;
					MemtoReg 	<= 1'bx;
					RegWrite 	<= 1'b0;
					MemRead 	<= 1'b0;
					MemWrite 	<= 1'b0;
					Branch 		<= 1'b1;
					ALUOp 		<= 2'b01;
					ERet		<= 1'b0;
					EStatus 	<= 4'b0000;
					NotAnInstr	<= 1'b0;
				end
				
				// R-TYPE
				// ADD, SUB, AND, ORR 
				11'b100_0101_1000, 11'b110_0101_1000, 11'b100_0101_0000, 11'b101_0101_0000: begin 
					Reg2Loc 	<= 1'b0;
					ALUSrc 		<= 2'b00;
					MemtoReg 	<= 1'b0;
					RegWrite 	<= 1'b1;
					MemRead 	<= 1'b0;
					MemWrite 	<= 1'b0;
					Branch 		<= 1'b0;
					ALUOp 		<= 2'b10;
					ERet		<= 1'b0;
					EStatus 	<= 4'b0000;
					NotAnInstr	<= 1'b0;
					
				end
				
				
				
				
				// INVALID OPCODE
				default: begin 
					Reg2Loc 	<= 1'bx;
					ALUSrc 		<= 2'bxx;
					MemtoReg 	<= 1'b0;
					RegWrite 	<= 1'b0;
					MemRead 	<= 1'b0;
					MemWrite 	<= 1'b0;
					Branch 		<= 1'b0;
					ALUOp 		<= 2'bxx;
					ERet		<= 1'b0;
					EStatus 	<= 4'b0010;
					NotAnInstr	<= 1'b1;
				end
			
			endcase
		end // else
	end // always_comb 
	
endmodule 