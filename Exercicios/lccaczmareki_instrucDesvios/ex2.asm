# Escreva um programa que calcule:
# 1 + 2 + 3 + … + 333

# Escreva o resultado (y) em uma palavra (4 bytes) de memória. 
# O resultado deve ser armazenado, obrigatoriamente, na posição 0x10010000 da memória .data.

.data
	y: .space 4
	
.text
	lui $t0, 0x1001			#carrega o endereço no t0
	addi $t1, $zero, 1		# t1 <= contador = 1
	add $t2, $zero, $zero	# t2 = acumulador = 0
	
	loop:
		add $t2, $t2, $t1 	# acumulador += contador
		addi $t1, $t1, 1	# contador ++
		addi $t3, $zero, 334
		bne $t1, $t3, loop #enquanto contador != 334, loopa
		
	sw $t2, 0($t0)			#salva o acumulador na memória
		


