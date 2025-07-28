# Escreva um programa que leia um valor x > 0 da memória (posição 0x10010000) e
# calcule o x-ésimo termo da série de Fibonacci:

#		1, 1, 2, 3, 5, 8, 13, 21, 34, 55, ...

# Escreva o x-ésimo termo da série (y) em uma palavra (4 bytes) de memória. 
# O resultado deve ser armazenado, obrigatoriamente, na posição 0x10010004 da memória .data.

.data
	x: .word 10
	y: .space 4

.text
	lui $t0, 0x1001		#carrega endereço de memória no t0
	lw $t1, 0($t0)		#carrega x no t1
	
	addi $t2, $zero, 1	#1o da sequencia
	addi $t3, $zero, 1	#2o da sequencia
	addi $t5, $zero, 2	# contador inicia em 2
	#add $t4, $t2, $t3
	
	#fibonacci é sempre a soma dos 2 anteriores(ultimo e penultimo)
	loop:
		add $t4, $t2, $t3	#calcula o prox (ultimo)
		or $t2, $t3, $zero	#t2 vira o t3 (o antepenultimo vira penultimo)
		or $t3, $t4, $zero	#t2 vira o t4 (o ultimo
		addi $t5, $t5, 1	#contador ++
		bne $t5, $t1, loop	#loopa enquanto contador(t5) != x(t1)
		
	sw $t4, 4($t0)			#salva o enésimo termo da sequencia na memoria
		
		
		