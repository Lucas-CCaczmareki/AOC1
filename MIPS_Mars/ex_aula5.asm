.data
	tam: .word 10
	vetor: .word 0, -1, 2, -3, -4, 5, 6, 7, 8, 9
	
.text
	#t1 <- Soma total
	li $t1, 0
	#t2 <- Soma posiivos
	li $t2, 0
	#t3 <- Soma negativos
	li $t3, 0
	#s0 <- reg base
	la $s0, vetor
	lw $t0, tam
	
inicio:
	beq $t0, $zero, fim
	lw $t4, 0($s0)
	add $t1, $t1, $t4
	addi $s0, $s0, 4 #avança 1 int no endereço
	
	subi $t0, $t0, 1 #diminui o contador pra finalizar
	
	j inicio
	
fim: nop
	