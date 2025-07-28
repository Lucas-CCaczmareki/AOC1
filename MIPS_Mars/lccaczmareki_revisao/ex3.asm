.data
	a: .word 19
	b: .word 9
	c: .word 6
	#Mediana = 9

.text
	addi $t4, $t4, 1	#1 auxiliar pra comparar com flag
	
	#aqui é necessário ordenar pro espaço 0($t0) sempre ser a mediana
	lui $t0, 0x1001
	
	#t1 fica reservado como flag pra trocar
	voltatudo:
	lw $t2, 0($t0)	#loada o a
	lw $t3, 4($t0)	#loada o b
	
	#beq $t2, $t3	
		
	slt $t1, $t2, $t3 #a < b seta 1 (ou seja, tudo certo)
	bne $t1, $t4, ordena1	#se n tiver tudo certo. 
	
	volta:
	lw $t2, 4($t0)	#carrega b
	lw $t3, 8($t0)	#carrega c
	
	slt $t1, $t2, $t3 #a < b seta 1 (ou seja, tudo certo)
	bne $t1, $t4, ordena2	#se n tiver tudo certo.
	j end
	
	ordena1:
		#se o de antes for maior que o de depois (a > b)
		#precisa ficar b < a
		#ou seja, t2 vai pra 4(t0) e t3 vai pra 0(t0)
		sw $t2 4($t0)
		sw $t3 0($t0)
		j volta
	
	ordena2:
		sw $t2 8($t0)
		sw $t3 4($t0)
		j voltatudo
		
	end:
		lw $t2, 4($t0)	 #carrega a mediana
		sw $t2, 12($t0) #salva a mediana no 100100C
	
	
	

