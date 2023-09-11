/*
	X3 -> sum
 	x0 -> puntero a memoria
	x9 -> delimitador (N)
	
	
	seteo x3 en 0
	seteo x9 en N = 29
	en cada iteracion: 
		- cargo en X2 el valor de memoria de X0
		- X3 += X2
		- X0 + 8
		- X9 --
		- si X9 != 0 -> branch loop
		- guardo en la pos X0 de memoria el valor de X3
*/

	ADD 	X3, XZR, XZR
	ADD 	X9, X30, XZR

loop: 	
	LDUR 	X2, [X0, #0]		// X2 = M[X0]
	ADD 	X3, X3, X2			// X3 += X2
	ADD 	X0, X0, X8			// X0 += 8b
	SUB 	X9, X9, X1			// X9 --
	CBNZ 	X9, loop			
	STUR 	X3, [X0, #0]		// M[X0] = X3
	
infloop:
	CBZ xzr, infloop
	