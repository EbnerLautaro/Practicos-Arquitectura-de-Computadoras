/*
	X3 -> sum
 	x0 -> puntero a memoria
	x9 -> delimitador (N)
	
	
	seteo x3 en 0
	seteo x9 en X17
	en cada iteracion: 

	for (i=X17; i==0; i--)
		- X3 += X16
		
	Realizar la multiplicación de dos registros: X16 y X17 y guardar el resultado en la
	posición “0” de la memoria.
*/

	ADD  	X9, X30, XZR
	ADD		X2, XZR, XZR		// X2 = 0
loop1: 
	STUR 	X2, [X0, #0]		// WRITE X2 IN X0 ADDR 
	ADD		X2, X2, X1			// X2 ++
	ADD 	X0, X0, X8			// X0 += 8
	SUB 	X9, X9, X1			// X9 --
	CBZ 	X9, end1				
	CBZ 	XZR, loop1				

end1:
	ADD 	X3, XZR, XZR
	ADD 	X0, XZR, XZR

loop2: 	
	ADD 	X3, X3, X16			// X3 += X16
	SUB 	X17, X17, X1		// X17 --
	CBZ 	X17, end2				
	CBZ 	XZR, loop2		
end2:
	STUR 	X3, [X0, #0]		// M[X0] = X3

infloop:
	CBZ xzr, infloop
	