# escrever um programa que inverte a ordem dos elementos de um vetor
# O vetor de entrada deve ser modificado, e não um novo.

.data
	vetor: .word 1, 2, 3, 4, 5
	
.text
.globl main

main: 
	#t0 aponta pro início do meu vetor
	la $t0, vetor
	
	#t1 aponta pro final
	la $t1, vetor
	addi $t1, $t1, 16
	
	#os 2 ponteiros vão me movendo em direção ao centro conforme trocam os números de posição

loop:
	#o loop continua enquanto o endereço de t0 for menor que o que t1
	# no momento que eles forem iguais ou t0 for maior, eles chegaram ao centro, finaliza
	bge $t0, $t1, fim

	#carrega vetor[ptr_start] em t2, e vetor[ptr_end] em t3	
	lw $t2, 0($t0)
	lw $t3, 0($t1)
	
	#savla vetor[ptr_end] em vetor[ptr_start] e vice versa
	sw $t3, 0($t0)	
	sw $t2, 0($t1)
	
	#avanca start e recua end
	add $t0, $t0, 4
	addi $t1, $t1, -4
	
	#continua trocando
	j loop
	
fim:
	nop #finaliza o programa