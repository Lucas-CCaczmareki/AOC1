#  Leia dois vetores de 5 números inteiros (word) e armazene na memória iniciando na posição 0x10010000. 
# Concatene os vetores e imprima o resultado na tela.

.data
	vetor1: .word 1, 5, 4, 3, 5
	vetor2: .word 2, 3, 4, 6, 8
	saida: .space 40				#como cada int ocupa 4 bytes, e queremos concatenar esse vetor, ele ocupa 10 posições, 40 bytes
	
.text
.globl main

main:
	#vou precisar de um ponteiro pro endereço e de um contador?
	#lui $t0, 0x1001		#carrega uma parte do endereço pra dentro do t0
	#li $t1, 0x0028		#carrega a segunda parte pro registrador t1 que vai auxiliar
	#or $t0, $t0, $t1	#junta as duas partes no t0. Agora ele aponta pro início do espaço que vai ficar o vetor do resultado
	la $t0, saida
	
	li $t1, 0			#zera o t1
	
	la $a0, vetor1		#carrega o endereço da primeira posição do vetor 1
	#la $a1, vetor2		#carrega o endereço da primeira posição do vetor 2
	##la $a1, saida
	
	jal cat1			#concatena os vetores
	
	li $t1, 0			#zera o t1 (contador)
	loop:
		beq $t1, 10, end	#enquanto t1 < 10 (loopa 10 vezes)
		addi $t1, $t1, 1	#t1 ++
		
		lw $a0, 0($t0)		#carrega a posição i do vetor de saída 
		addi $t0, $t0, 4	#move o ponteiro do saída pra frente
		li $v0, 1			#indica pro syscall que ele vai printar um int
		syscall
		
		j loop
	
	j end
	

cat1:
	addiu $sp, $sp, -4	#prepara a pilha
	sw $ra, ($sp)		#guarda o valor de retorno de cat1
	
	la $v0, saida
	
	loop_cat1:
		beq $t1, 5, end_cat1	#enquanto contador < 4 (isso loopa pra todo vetor 1)
		addi $t1, $t1, 1		#t1++
		
		lw $t2, ($a0)			#carrega o valor do a0 (vetor 1) em t2
		sw $t2, ($v0)			#guarda do valor do t2 (v1[i]) no v0
		
		addi $v0, $v0, 4		#avança o saída pra próx posição
		addi $a0, $a0, 4		#avança o vetor 1 pra próx posição
		
		j loop_cat1
		
	end_cat1:
		jal cat2				#vai pra subrotina que concatena o segundo vetor
		lw $ra, ($sp)			#seta o ra pro valor do topo (o que armazenamos antes
		addiu $sp, $sp, 4 		#faz um pop na pilha
		jr $ra 					#volta pra main com o vetor escrito na memória

cat2:
	la $a0, vetor2		#atualiza o a0 pra apontar pro segundo vetor
	li $t1, 0			#zera o contador
	loop_cat2:
		beq $t1, 5, end_cat2	#enquanto contador < 4 (isso loopa pra todo vetor 2)
		addi $t1, $t1, 1		#t1++
		
		lw $t2, ($a0)			#carrega o valor do a0 (vetor 2) em t2
		sw $t2, ($v0)			#guarda do valor do t2 (v2[i]) no v0
		
		addi $v0, $v0, 4		#avança o saída pra próx posição
		addi $a0, $a0, 4		#avança o vetor 2 pra próx posição
		
		j loop_cat2
	end_cat2:
		jr $ra					#volta pra dentro do cat1
		
end:
