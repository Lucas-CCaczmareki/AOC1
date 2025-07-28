.data
	n: .word 5
	res: .space 4
	
.text
	lui $t0, 0x1001
	lw $t1, 0($t0) #carrega n
	
	addi $t2, $t2, 1	#1 auxiliar
	sub $t3, $t1, $t2	#n-1
	
	
	loop:
		mult $t1, $t3 #n*n-1
		mflo $t1
		sub $t3, $t3, $t2 #(n-1) - 1
		beq $t2, $t3, end
		j loop
	
	 end:
	 sw $t1, 4($t0) 
		
		
	