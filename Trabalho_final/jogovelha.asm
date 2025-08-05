# TA FALTANDO ISSO
#Implementar a flag que define quem ta jogando (O ou X)
#Implementar as condições de vitória e checar se alguém ganha
#Implementar o VS máquina que joga sempre num lugar aleatório
#----------------------------------------------------------

#Jogo da velha
# Autores: Lucas C Caczmareki e Victor Mariano

#Comentário de teste dos guri pra ver se ta tudo bem

#TABELA PRA MODIFICAR A STRING
	#espaço mem - numero
	#3 			= 1
	#7			= 2
	#11 		= 3
	#27 		= 4
	#31 		= 5
	#35 		= 6
	#51 		= 7
	#55 		= 8
	#59 		= 9	

.data
	tabuleiro: .asciiz "\n\n 1 | 2 | 3\n------------\n 4 | 5 | 6\n------------\n 7 | 8 | 9\n\n\n"
	str1: .asciiz "\n--------------- Jogo da velha ---------------\n1. Nova partida\n2. Placar atual\n3. Encerrar jogo\n"
	str2: .asciiz "Digite a sua opção: "
	str3: .asciiz "Vitórias X: "
	str4: .asciiz "Vitórias O: "
	str5: .asciiz "Empates: "
	new_line: .asciiz "\n"
	line: .asciiz "----------------------\n"
	invalido_text: .asciiz "\nO numero digitado é invalido tente novamente\n"
    intro_text: .asciiz "Digite o numero do espaço desejado: "
	
.text
.globl main

#o main vai funcionar como o menu
main:
loop:
	#imprime string
	la $a0, str1
	li $v0, 4
	syscall
	
	#imprime string
	la $a0, str2
	li $v0, 4
	syscall
	
	#Lê a opção digitada pelo usuário
	li $v0, 5
	syscall
	#t0 nessa parte vai conter a opção do menu
	move $t0, $v0

	#da uma cuidada depois pra ver se eles não vão entrar em conflito
	li $t1, 1 #t1 = op 1
	li $t2, 2 #t2 = op 2
	li $t3, 3 #t3 = op 3
	beq $t0, $t1, nova_partida
	beq $t0, $t2, imprime_placar
	beq $t0, $t3, end
	j loop		#se o usuario quiser foder com a minha vida só volta pro inicio

	nova_partida:
		jal partida
		#ai la dentro de partida vai vir o código que o Victor ta fazendo
		#depois ele volta pra cá com o resultado no $v0
		#1 se quem ganhou foi o X, 0 se for o Bolinha e qualquer coisa se empate

		#----------------------------
		#t8 guarda as vitórias do x
		#t9 guarda as do O
		#s7 guarda os empates
		#----------------------------					
		
		beqz $v0, bola_vence	#se o bola venceu, atualiza o placar e loopa (vence com 0)
		beq $v0, 1, xis_vence	#se o xis venceu, atualiza e loopa			 (vence com 1)
		j velha_vence
		
		#se nenhum deles venceu, então empatou
		addi $s7, $s7, 1	#s7++, atualiza placar
		j loop				#loopa até acabar
				
		xis_vence:
			addi $t8, $t8, 1	#t8++
			j loop
		
		bola_vence:
			addi $t9, $t9, 1	#t9++
			j loop #continua loopando até que o usuario escolha encerrar
			
		velha_vence:
			addi $s7, $s7, 1	#s7++
			j loop #loopa até o usuário dizer chega
	
	imprime_placar:
		
		# ---------------------------------------
		#imprime uma linha e da espaçamento pra melhor visualização
		la $a0, new_line
		li $v0, 4
		syscall
		la $a0, line
		li $v0, 4
		syscall
		
		
		#imprime o placar pro X
		la $a0, str3
		li $v0, 4
		syscall
		
		move $a0, $t8 #traz o placar do x pro argumento
		li $v0, 1 #imprime int
		syscall
		
		la $a0, new_line
		li $v0, 4
		syscall
		# ---------------------------------------
		
		
		# ---------------------------------------
		#imprime o placar pro O
		la $a0, str4
		li $v0, 4
		syscall
		
		move $a0, $t9 #traz o placar do x pro argumento
		li $v0, 1 #imprime int
		syscall
		
		la $a0, new_line
		li $v0, 4
		syscall
		# ---------------------------------------
		
		# ---------------------------------------
		#imprime o placar pra velha
		la $a0, str5
		li $v0, 4
		syscall
		
		move $a0, $s7 #traz o placar do x pro argumento
		li $v0, 1 #imprime int
		syscall
		
		la $a0, new_line
		li $v0, 4
		syscall
		# ---------------------------------------
		#imprime uma linha pra melhor visualização e depois pula
		la $a0, line
		li $v0, 4
		syscall
		la $a0, new_line
		li $v0, 4
		syscall
		
		j loop	#volta e loopa

partida:
	#Guardamos o RA na pilha pois depois haverá outra subrotina
	addiu $sp, $sp, -4	#faz o stack pointer apontar pro topo
	sw $ra, ($sp)		#salva o RA na pilha
	
	addi $s5, $zero, 0 	# inicia o contador
	addi, $s6, $zero, 9	# final do contador

	jogada:
		#vou usar o t0 e ficar de olho
		li $t0, 2
		#se for par(resto da div por 2 == 0), seta a flag pra 1 (joga x)
		div $s5, $t0	#contador % 2
		mfhi $a3		#resto 0, joga O, resto 1 joga X
		
		#se for impar, seta pra 0(joga O)
		
		#aqui entra as condições
		beq $s5, $s6, empate		#quando terminar pula pra empate que finaliza a partida
		jal imprime_tab
		
		#tem que botar uma flag pra indicar se a jogada é o X ou ou o O
		
		# texto pro usuario
 		la $a0, intro_text 		
 		li $v0, 4
 		syscall
    	
    	# ler a entrada do usuario e salva em s0
		li $v0, 12  			
		syscall 
		move $s0, $v0
    	
    	# teste se for 0-9
		blt $s0, 48, invalido 	#s0 < 0
		bgt $s0, 57, invalido	#s0 > 9

		#s1 = endereço da string
		#s3 = caracter lido da string
		#s0 = caracter digitado pelo usuário
			
		la $s1, tabuleiro 		# carrega a string em s1
		li $s2, 0 				# flag para ver se encontrou ou não
	
		loop_string: 			#percorre a string até achar (ou não) o número
			
			lb $s3, 0($s1) 		#carrega o caractere atual da string em s3
			
			beqz $s3, invalido 	#se for o ultimo caracter sai do loop
			
			bne $s3, $s0, next 	# vai pro proximo elemento se não for o numero do usuario
			
			#se chegou aqui, encontrou o número
			addi $s5, $s5, 1	#contador(i)++
			
			#dependendo do número encontrado retorna um resultado
			#Esses números são os decimais (1-9) na tabela ascii
			beq $s0, 49, final1		
			beq $s0, 50, final2
			beq $s0, 51, final3
			beq $s0, 52, final4
			beq $s0, 53, final5
			beq $s0, 54, final6
			beq $s0, 55, final7
			beq $s0, 56, final8
			beq $s0, 57, final9
	
			next: #vai pro próxima iterações
				addi $s1, $s1, 1
				j loop_string
	
			invalido:
				li $v0, 4
				la $a0, invalido_text
				syscall
				j jogada
		
			#retorna a posição do número respectivo na string
			final1:
				addi $v0, $zero, 3
				j modifica_tabuleiro
	
			final2:
				addi $v0, $zero, 7
				j modifica_tabuleiro
	
			final3:
				addi $v0, $zero, 11
				j modifica_tabuleiro
	
			final4:
				addi $v0, $zero, 27
				j modifica_tabuleiro
	
			final5:
				addi $v0, $zero, 31
				j modifica_tabuleiro
	
			final6:
				addi $v0, $zero, 35
				j modifica_tabuleiro
	
			final7:
				addi $v0, $zero, 51
				j modifica_tabuleiro

			final8:
				addi $v0, $zero, 55
				j modifica_tabuleiro
	 
			final9:
				addi $v0, $zero, 59
				j modifica_tabuleiro
	

	modifica_tabuleiro:
	
		#a0 -> flag se ta jogando o x(1) ou o(0) PRECISA IMPLEMENTAR!!!
		#li $a0, 1			#escreve x nesse caso (dps vai ter que fazer isso com base num registrador que vai ficar trocando
		move $a1, $v0		#esse número vai vir atravéz do v0, valor de retorno da função que o victor ta fazendo
		jal escreve
		j jogada
	
	#aqui ainda vai ser necessário implementar as condições de vitória!
	empate:
		#aqui por enquanto é o único retorno da subrotina "partida" vou precisa desempilhar o ra
		lw $ra, ($sp)		#faz um pop do valor
		addiu $sp, $sp, 4	#faz o top voltar uma posição
		
		#se chegou em empate v0 igual a 2
		li $v0, 2
		
		jr $ra				#aqui retorna o valor do resultado
		
escreve:
	#t0 endereço string
	la $t0, tabuleiro
	
	#a0, qual símbolo escreve
	beqz $a3, bolinha
	
	xis:
		#t1 simbolo pra escrever
		li $t1, 'X'
		add $t0, $t0, $a1
		sb $t1, 0($t0)		#troca só o caracter com sb
		jr $ra
		
	bolinha:
		#t1 simbolo pra escrever
		li $t1, 'O'				#carrega o simbolo pra escrever
		add $t0, $t0, $a1		#adiciona o valor pra chegar no número na string ao endereço
		sb $t1, 0($t0)			#modifica o byte apontado (troca o número pelo símbolo)
		jr $ra	
	
imprime_tab:
	#aqui não precisa salvar o RA por que ele não chama função nenhuma
	#imprime tabuleiro
	la $a0, tabuleiro
	li $v0, 4
	syscall
	jr $ra

#condicao_vitoria:
#	horizontal_1:
#		1, 5, 9 tem o mesmo símbolo.
#		flag
		
		#retorna 1 se x ganhou
		#0 se O ganhou
		#qualquer coisa se não foi decidido ainda
	

end:
