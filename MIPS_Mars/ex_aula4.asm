#esse programa calcula o fatorial de n
.data
	n: .word 5
	nfat: .space 4

.text
	lui $t0, 0x1001		#coloca o endereço da memória no t0
	
	lw $t1, 0($t0)		#t1 recebe n
	
	#lógica do fatorial
	#t1 recebe n*n-1...
	
	addi $t2, $zero, 1	#seta o 1 na memória pra usar
	sub $t3, $t1, $t2	# t3 recebe n-1
	
	#calculo do fatorial
	#precisa loopar n vezes
	Loop:	mult $t1, $t3	#n * n-1...
			mflo $t1		#t1 <- fatorial
			sub $t3, $t3, $t2	#t3 <- (n-1) - 1...
			beq $t3, $zero, Exit
			j Loop
			
	#quando ele chegar aqui, é pra $t1 ter o fatorial
	Exit:	sw $t1, 4($t0)
	
	