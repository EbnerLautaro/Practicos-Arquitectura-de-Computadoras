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
	ADD 	X3, XZR, XZR

loop: 	
	ADD 	X3, X3, X16			// X3 += X16
	SUB 	X17, X17, X1		// X17 --
	CBNZ 	X17, loop			
	STUR 	X3, [X0, #0]		// M[X0] = X3
	
infloop:
	CBZ xzr, infloop
	