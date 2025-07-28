.data
	#reserva o espaço máximo que o vetor pode ter (32 words)
	A: .space 128 
	B: .space 128 
	R: .space 128 
	
	str1: .asciiz "Esse programa calcula a soma ou a multiplicacao de vetores. Digite a opcao desejada:\n(0) para soma\n(1) para multiplicação\nSua opcao: "
	str2: .asciiz "Digite o tamanho dos vetores (valores entre 2 e 32): "
	str3: .asciiz "Digite os "
	str4: .asciiz " elementos do vetor A:\n"
	str5: .asciiz " elementos do vetor B:\n"
	str6: .asciiz "O resultado da " 			# <- aqui adiciona a operação com base no código
	str7: .asciiz " entre os vetores e: \n"
	str8: .asciiz "Elemento: "
	str9: .asciiz "adicao"
	str10: .asciiz "multiplicacao"
	str11: .asciiz "\nSe voce quer realizar um novo calculo, digite:\n(0) para soma\n(1) para multiplicao\nMas se voce deseja sair, digite qualquer outra tecla\nSua opcao: "
	
.text
.globl main
main: 
	la $a0, str1	#Carrega a string pro a0
	li $v0, 4		#Diz pro system q vamo imprimir uma string
	syscall			#Executa o comando especificado
	
	li $v0, 5		#Leitura de int
	syscall
	move $t0, $v0	#move o valor lido pra dentro de t0
	
	loop:
	la $a0, str2	#carrega string
	li $v0, 4		#impressão de string
	syscall
	
	li $v0, 5		#Leitura de int
	syscall
	move $t1, $v0	#move o valor lido pra dentro de t1	
	
	# ---------- LEITURA DO VETOR A -----------------
	#------------ imprimindo uma string com valor no meio -------------
	la $a0, str3	#carrega string
	li $v0, 4		#impressão de string
	syscall	
	
	#substitui N pelo valor de N na hora de imprimir
	move $a0, $t1	
	li $v0, 1
	syscall
	
	#Imprime o resto da string
	la $a0, str4
	li $v0, 4
	syscall 
	
	#faz a leitura dos N elementos de A
	move $a1, $t1	#move n pra a1, que vai ser passado pra subrotina
	la $a2, A		#a2 recebe o endereço do vetor onde a gente vai armazenar
	
	jal leitura_elementos	#chama a subrotina de leitura de elementos

	# ---------- LEITURA DO VETOR B -----------------
	#------------ imprimindo uma string com valor no meio -------------
	la $a0, str3	#carrega string
	li $v0, 4		#impressão de string
	syscall	
	
	#substitui N pelo valor de N na hora de imprimir
	move $a0, $t1	
	li $v0, 1
	syscall
	
	#Imprime o resto da string pra B
	la $a0, str5
	li $v0, 4
	syscall 
	
	#faz a leitura dos n elementos de B
	move $a1, $t1	#move n pra a1, que vai ser passado pra subrotina
	la $a2, B		#a2 recebe o endereço do vetor onde a gente vai armazenar
				
	jal leitura_elementos	#chama a subrotina de leitura de elementos			
	# ------------------------------------------------------------------------------------------
	
	move $a0, $t1	#argumento 0 = n
	la $a1, A		#argumento 1 = vetor A
	la $a2, B		#argumento 2 = vetor B
	la $a3, R		#argumento 3 = vetor de resultados
	
	# Condicional pra definir se soma ou multiplica os vetores
	beqz $t0, somar
	
	jal multiplica
	j fim_if
	
	somar: jal soma
	
	fim_if:
		move $a1, $t1	#argumento 1 = n
		la $a2, R		#argumento 2 = vetor
		
		jal imprime_vetor
	
	# condição que decide se vai loopar ou não
	la $a0, str11	#Carrega a string pro a0
	li $v0, 4		#Diz pro system q vamo imprimir uma string
	syscall			#Executa o comando especificado
	
	li $v0, 5		#Leitura de int
	syscall
	
	move $t0, $v0	#move o valor lido pra dentro de t0
	
	beqz $t0, loop		#se selecionou 0, executa de novo
	beq $t0, 1, loop	#se selecionou 1, executa de novo																																			
	j end				#se colocou qualquer outra coisa, encerra o programa

leitura_elementos:
	#t8 servirá como contador
	li $t8, 0
	
	loop_read:
		beq $t8, $a1, end_read 	#enquanto t8 < n, loopa
		addi $t8, $t8, 1		#t8++
		
		#imprime a string pra ajudar o usuario a digitar o elemento
		la $a0, str8	#carrega a string "Elemento: "
		li $v0, 4
		syscall 
		
		li $v0, 5		#lê o numero digitado
		syscall
		
		sw $v0, 0($a2)		#salva o conteúdo lido na memória do vetor
		addi $a2, $a2, 4	#move o ponteiro do vetor pra próxima posição livre
		
		j loop_read
		
	end_read:
		jr $ra

	
soma:
#argumento 0 = n
#argumento 1 = vetor A
#argumento 2 = vetor B
#argumento 3 = vetor de resultados
	
#t8 servirá como contador
li $t8, 0	#zera o t8

loop_sum:
	beq $t8, $a0, end_sum	#enqanto contador < n
	addi $t8, $t8, 1		#contador++

	lw $t2, 0($a1)		#t2 = A[i]
	addi $a1, $a1, 4	#aponta pro próximo elemento

	lw $t3, 0($a2)		#t3 = B[i]
	addi $a2, $a2, 4	#próximo elemento
						
	#t4 = R[i]						
	add $t4, $t2, $t3	# R[i] = A[i] + B[i]
	sw $t4, 0($a3)		#salva t4 no R[i]
	addi $a3, $a3, 4	#move pra próxima posição vazia
		
	j loop_sum
end_sum:
	jr $ra
	

multiplica:						
#argumento 0 = n
#argumento 1 = vetor A
#argumento 2 = vetor B
#argumento 3 = vetor de resultados
#t8 servirá como contador
li $t8, 0	#zera o t8

loop_mult:
	beq $t8, $a0, end_mult	#enqanto contador < n
	addi $t8, $t8, 1		#contador++
	
	lw $t2, 0($a1)		#t2 = A[i]
	addi $a1, $a1, 4	#aponta pro próximo elemento

	lw $t3, 0($a2)		#t3 = B[i]
	addi $a2, $a2, 4	#próximo elemento
	
	#t4 = R[i]
	mult $t2, $t3		#A[i] * B[i]
	mflo $t4			#joga pra dentro do t4 o resultado da multiplicação

	sw $t4, 0($a3)		#salva t4 no R[i]
	addi $a3, $a3, 4	#move pra próxima posição vazia
	
	j loop_mult
	
end_mult:
	jr $ra
	

imprime_vetor:
	#argumento 1 = n
	#argumento 2 = vetor
	
	#printa a string "O resultado da"
	la $a0, str6
	li $v0, 4
	syscall
	
	#se a opção digitada for a 0 (adição) printa a string correspondente
	beqz $t0, print_str9

	#se a opção digitada não tiver sido 0, printa a string multiplicação
	la $a0, str10 
	li $v0, 4
	syscall
	j printed	#pula pra depois da string adição, pra evitar que o código printe as duas
	
	print_str9:
		la $a0, str9
		li $v0, 4
		syscall
	
	printed: 
	#printa o resto da string: "entre os vetores é: "
	la $a0, str7
	li $v0, 4
	syscall
	
	# ---------------------------------------------------------
	# imprime a string que vai indicar o resultado
	#t8 servirá como contador
	li $t8, 0	#zera o contador
	
	loop_print:
		beq $t8, $a1, end_print	#enquanto t8 < n, loopa
		addi $t8, $t8, 1		#t8++

		# ---------- IMPRIME ESPAÇO ------------------
		li $a0, 32			#manda pro a0 o espaço q vamo imprimir
		li $v0, 11			#indica que vamo printa  um caracter
		syscall
		# ---------------------------------------------
						
		lw $a0, 0($a2)		#chama pra dentro do a0 o elemento V[i] pra ser impresso
		addi $a2, $a2, 4	#move pra próx posição
		
		li $v0, 1			#indica pro sistema q vamo imprimir int
		syscall				#imprime int
		
		# ---------- IMPRIME ESPAÇO ------------------
		li $a0, 32			#manda pro a0 o espaço q vamo imprimir
		li $v0, 11			#indica que vamo printa um caracter
		syscall
		# ---------------------------------------------
		
		j loop_print
	
	end_print:	
		jr $ra
	
# -----------------------------------------------------------------------	
end:
	li $v0, 10
	syscall
	
	