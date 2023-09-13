// MAINDEC

module maindec
(
		input logic [10:0] Op,
		input logic reset, 							// nuevo
		output logic Reg2Loc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, 
		output logic NotAnInstr, ERet, BranchToReg, // nuevo
		output logic [1:0] ALUOp, ALUSrc 			// modificado
);

	always_comb begin	
	
		if (reset) begin 
			Reg2Loc 	<= 1'b0;
			MemtoReg 	<= 1'b0;
			RegWrite 	<= 1'b0;
			MemRead 	<= 1'b0;
			MemWrite 	<= 1'b0;
			Branch 		<= 1'b0;
			BranchToReg <= 1'b0;
			ALUOp 		<= 2'b00;
			ALUSrc		<= 2'b00;
			ERet		<= 1'b0;
			NotAnInstr  <= 1'b0;
		end 
		
		else begin 
		
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
					BranchToReg <= 1'b0;
					ALUOp 		<= 2'b00;
					ERet		<= 1'b0;
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
					BranchToReg <= 1'b0;
					ALUOp 		<= 2'b00;
					ERet		<= 1'b0;
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
					BranchToReg <= 1'b0;
					ALUOp 		<= 2'b01;
					ERet		<= 1'b0;
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
					BranchToReg <= 1'b0;
					ALUOp 		<= 2'b10;
					ERet		<= 1'b0;
					NotAnInstr	<= 1'b0;
				end
				
				// ERET
				11'b110_1011_0100: begin   
					Reg2Loc 	<= 1'b0;
					ALUSrc 		<= 2'b00;
					MemtoReg 	<= 1'bx;
					RegWrite 	<= 1'b0;
					MemRead 	<= 1'b0;
					MemWrite 	<= 1'b0;
					Branch 		<= 1'b1;
					BranchToReg <= 1'b0;
					ALUOp 		<= 2'b01;
					ERet		<= 1'b1;
					NotAnInstr	<= 1'b0;
				end
				
				// MRS
				11'b110_1010_1001: begin   
					Reg2Loc 	<= 1'b1;
					ALUSrc 		<= 2'b1x;
					MemtoReg 	<= 1'b0;
					RegWrite 	<= 1'b1;
					MemRead 	<= 1'b0;
					MemWrite 	<= 1'b0;
					Branch 		<= 1'b0;
					BranchToReg <= 1'b0;
					ALUOp 		<= 2'bxx;
					ERet		<= 1'b0;
					NotAnInstr	<= 1'b0;	
				end
				
				// BR
				11'b110_1011_0000: begin   		// CBZ
					Reg2Loc 	<= 1'bx;		// 1
					ALUSrc 		<= 2'bxx;		// 00
					MemtoReg 	<= 1'bx;		// x
					RegWrite 	<= 1'b0;		// 0
					MemRead 	<= 1'b0;		// 0
					MemWrite 	<= 1'b0;		// 0
					Branch 		<= 1'b1;		// 1
					BranchToReg <= 1'b1;		// 0
					ALUOp 		<= 2'b01;		// 01
					ERet		<= 1'b0;		// 0
					NotAnInstr	<= 1'b0;		// 0
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
					BranchToReg <= 1'b0;
					ALUOp 		<= 2'bxx;
					ERet		<= 1'b0;
					NotAnInstr	<= 1'b1;
				end
			
			endcase
		end // else
	end // always_comb 
	
endmodule 