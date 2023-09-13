// ALU CONTROL DECODER

module aludec (input  logic [10:0] funct,  
					input  logic [1:0]  aluop,  
					output logic [3:0] alucontrol);  				
						
	always_comb
		
		// LDUR or STUR		
		if (aluop == 2'b00) 
			alucontrol = 4'b0010;										
		
		// CBZ or ERET or MRS
		else if (aluop == 2'b01) 
			alucontrol = 4'b0111; 									
		// ADD
		else if((aluop == 2'b10)  & (funct == 11'b10001011000)) 
			alucontrol = 4'b0010;	
			
		// SUB
		else if((aluop == 2'b10)  & (funct == 11'b11001011000)) 
			alucontrol = 4'b0110;	
		
		// AND
		else if((aluop == 2'b10)  & (funct == 11'b10001010000)) 
			alucontrol = 4'b0000;	
		
		// OR    
		else if((aluop == 2'b10)  & (funct == 11'b10101010000)) 
			alucontrol = 4'b0001;	
		else 
			alucontrol = 4'b0000;
endmodule
