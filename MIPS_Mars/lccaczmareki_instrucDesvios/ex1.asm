# Escreva um programa que leia dois halfwords (a e b) da memória e 
# calcule a sua divisão se os dois valores forem diferentes 
# e a sua multiplicação se os dois valores forem iguais. 

# Escreva o resultado (y) em uma palavra (4 bytes) de memória. O
# resultado deve ser armazenado, obrigatoriamente, na posição 0x10010004 da
# memória .data. Inicie o código com:

# aparentemente, a grande diferença aqui é que uma half word precisa ta alinhada à multiplo de 2
# já que ela é metade de uma word, que vale 4 bytes.

.data
	a: .half 30
	b: .half 30
	y: .space 4
	
.text
	lui $t0, 0x1001		#guarda o endereço da memória no t0
	
	lh $t1, 0($t0)		#lh(load halfword): t1 <- a
	lh $t2, 2($t0)		#t2 <- b
	
	beq $t1, $t2, equal		#se t1 e t2 forem iguais, executa equal
	beq $t2, $zero, fim		#evita divisões por 0
	
	#se não pular no beq, faz a divisão pros valores diferentes:
	div $t1, $t2	#calcula a divisão
	mflo $t3		#traz o resultado pro t3
	j fim			#pula pro fim
	
	equal:	mult $t1, $t2	#t1 x t2
			mflo $t3		#t3 <- resultado
			j fim			#pula pro fim
	
	fim:	sw $t3, 4($t0)	#salva o resultado de t3 na memória (y) ignorando o resto
	
			