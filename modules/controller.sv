// CONTROLLER

module controller
(
	input logic [10:0] instr,
	output logic [3:0] AluControl,						
	output logic reg2loc, regWrite, Branch, memtoReg, memRead, memWrite,
	
	
	// Señales nuevas
	input logic reset, ExtIRQ, ExcAck,
	output logic ExtIAck, ERet, Exc,
	output logic [3:0] EStatus,
	output logic [1:0] AluSrc // modificada
);
	logic NotAnInstr; // Señales nuevas
											
	logic [1:0] AluOp_s; 
											
	maindec decPpal (
		.Op(instr), 
		.reset(reset),
		.Reg2Loc(reg2loc), 
		.MemtoReg(memtoReg), 
		.RegWrite(regWrite), 
		.MemRead(memRead), 
		.MemWrite(memWrite), 
		.Branch(Branch), 
		.ALUOp(AluOp_s)
		.ALUSrc(AluSrc), 
		.NotAnInstr(NotAnInstr),
		.ERet(ERet),
		.EStatus(EStatus)
	);
	
	
	
	
	aludec decAlu (
		.funct(instr), 
		.aluop(AluOp_s), 
		.alucontrol(AluControl)
	);
			
			 
	always_comb begin 
		Exc <= ExtIRQ | NotAnInstr;
		
		if (ExcAck && ExtIRQ)
			ExtIAck <= 1;
		else 
			ExtIAck <= 0;
	end 
	
endmodule



/*
[x] - Agregar la entrada reset al bloque #maindec. Si esta vale ‘1’, todas las salidas del bloque #controller deben valer ‘0’.
[x] - Agregar un puerto de salida NotAnInstr al módulo #maindec, de tal forma que este tome el valor ‘1’ cuando se ingresa un opcode invalido, 
	caso contrario debe valer ‘0’. El resto de las señales de control deben tomar los valores indicados en la tabla correspondientes a la fila “Invalid OpCode”.
[x] - La salida Exc de #controller debe ser el resultado de una operación OR entre la entrada ExtIRQ y la señal interna NotAnInstr.
[?] - Ante la ocurrencia de una flanco ascendente en ExtIRQ (indicada en la tabla por la fila “External IRQ”) las señales de control generadas en #maindec no sufren modificaciones.
[x] - Las señales EStatus deben tomar los valores indicados en la tabla, según el caso correspondiente.
[x] - La salida del modulo #controller, ExtIAck es ‘1’ cuando ExcAck = ‘1’ y ExtIRQ = ‘1’, caso contrario debe valer ‘0’.
	
	
*/