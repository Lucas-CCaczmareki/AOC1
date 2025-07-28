#polinômio horner:
# y = ( ( ( ( −a ) x + b ) x − c ) x + d ) x − e

.data
	a: .word -3
	b: .word 7
	c: .word 5
	d: .word -2
	e: .word 8
	x: .word 4
	y: .space 4
	
.text
	lui $t0 0x1001		#carrega em t0 o endereço de memória onde estão as variáveis
	
	#carrega os valores das variáveis
	lw $t1, 0($t0)		#a
	lw $t2, 4($t0)		#b
	lw $t3, 8($t0)		#c
	lw $t4, 12($t0)		#d
	lw $t5, 16($t0)		#e
	lw $t6, 20($t0)		#x
	
	# -a
	sub $t7, $zero, $t1		# t7 <- 0 - a 
	
	#-ax
	mult $t7, $t6			# -a * x
	mflo $t7				# move pra t7
	
	# + b
	add $t7, $t7, $t2		# t7 <- -ax + b
	
	#(-ax + b)*x
	mult $t7, $t6			# t7 * x
	mflo $t7				# move pra t7
	
	# - c
	sub $t7, $t7, $t3		# (-ax + b)*x - c
	
	# ((-ax + b)*x - c)*x
	mult $t7, $t6			# t7 * x
	mflo $t7
	
	# + d
	add $t7, $t7, $t4		# ((-ax + b)*x - c)* x + d
	
	#(((-ax + b)*x - c)* x + d)*x
	mult $t7, $t6
	mflo $t7
	
	# - e
	sub $t7, $t7, $t5		# t7 - e
	
	#carrega t7 pra y na memória
	sw $t7, 24($t0)
	
	
	
	
	
	
	
	