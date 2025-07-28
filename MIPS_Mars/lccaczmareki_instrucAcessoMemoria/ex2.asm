#y = 9a³- 5a² + 7a + 15
# O algoritmo de horner visa diminuir o número de multiplicações
#o que consequentemente diminui o número de instruções em assembly
# A equação transformada (pelo horner) é a seguinte:

#y = ( ( ( 9a − 5 ) a + 7 ) a + 15 )

.data
	a: .word 3        	# valor de a
	y: .space 4       	# espaço para o resultado
	
.text
	lui $t0, 0x1001		# carrega pra t0 o endereço de memória
	lw $t1, 0($t0)		# carrega pra dentro de t1 o valor de 0x10010000 (que armazena a)
	
	# 9 * a
	ori $t2, $zero, 9	# carrega 9 no t2
	mult $t1, $t2		#9*a
	mflo $t3 			#armazena no t3
	
	# (9a - 5)
	ori $t2, $zero, 5	#carrega 5 no t2
	sub $t3, $t3, $t2	#t3 <- t3(9a) - 5
	
	# (9a-5)*a
	mult $t1, $t3		#t3 * a
	mflo $t3			#carrega pra t3
	
	# + 7
	addi $t3, $t3, 7 	#t3 <- t3+7
	
	# ((9a-5)*a+7) *a
	mult $t1, $t3
	mflo $t3
	
	# + 15
	addi $t3, $t3, 15	#t3 <- t3 + 15
	
	#armazena em y
	sw $t3, 4($t0)
			
