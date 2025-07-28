#Jogo da velha
# Autores: Lucas C Caczmareki e Victor Mariano

#TABELA PRA MODIFICAR A STRING
	#espaço mem - numero
	#1 			= 1
	#5			= 2
	#9 			= 3
	#25 		= 4
	#29 		= 5
	#33 		= 6
	#49 		= 7
	#53 		= 8
	#57 		= 9	

.data
	tabuleiro: .asciiz " 1 | 2 | 3\n------------\n 4 | 5 | 6\n------------\n 7 | 8 | 9\n\n\n"
	str1: .asciiz "--------------- Jogo da velha ---------------\n1. Nova partida\n2. Placar atual\n3. Encerrar jogo\n"
	str2: .asciiz "Digite a sua opção: "
	str3: .asciiz "Vitórias X: "
	str4: .asciiz "Vitórias O: "
	str5: .asciiz "Empates: "
	new_line: .asciiz "\n"
	line: .asciiz "----------------------\n"
	invalido_text: .asciiz "O numero digitado é invalido tente novamente\n"
    intro_text: .asciiz "Digite o numero do espaço desejado: "
	
.text
.globl main

#o main vai funcionar como o menu
main:
loop:
	la $a0, str1
	li $v0, 4
	syscall
	
	la $a0, str2
	li $v0, 4
	syscall
	
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
		
		beqz $v0, bola_vence	#se o bola venceu, atualiza o placar e loopa
		beq $v0, 1, xis_vence	#se o xis venceu, atualiza e loopa
		
		#se nenhum deles venceu, então empatou
		addi $s7, $s7, 1	#s7++, atualiza placar
		j loop				#loopa até acabar
				
		xis_vence:
			addi $t8, $t8, 1	#t8++
			j loop
		
		bola_vence:
			addi $t9, $t9, 1	#t9++
			j loop #continua loopando até que o usuario escolha encerrar
	
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
	addi $s5, $zero, 0 # inicia o contador
	addi, $s6, $zero, 9

	jogada:
		#aqui entra as condições
		beq $s5, $s6, empate
		jal imprime_tab
		
		#tem que botar uma flag pra indicar se a jogada é o X ou ou o O
		
 		la $a0, intro_text # texto pro usuario
 		li $v0, 4
 		syscall
    
		li $v0, 12  # ler a entrada do usuario e salva em s0
		syscall 
		move $s0, $v0
    
		blt $s0, 48, invalido # teste se for 0-9
		bgt $s0, 57, invalido
	
		la $s1, tabuleiro # carrega a string em s1
		li $s2, 0 # flag para ver se encontrou ou não
	
		loop_string: #percorre a string até achar (ou não) o número
		
			lb $s3, 0($s1) #carrega o caractere atual da string em s3
			
			beqz $s3, invalido #se for o ultimo caracter sai do loop
	
			bne $s3, $s1, next # vai pro proximo elemento se não fro o numero do usuario
	
			#se chegou aqui, encontrou o número
			addi $s5, $s5, 1
			
			#dependendo do número encontrado retorna um resultado
			beq $s1, 49, final1
			beq $s1, 50, final2
			beq $s1, 51, final3
			beq $s1, 52, final4
			beq $s1, 53, final5
			beq $s1, 54, final6
			beq $s1, 55, final7
			beq $s1, 56, final8
			beq $s1, 57, final9
	
			next: #vai pro próxima iterações
				addi $s1, $s1, 1
				j loop_string
	
			invalido:
				li $v0, 4
				la $a0, invalido_text
				syscall
				j jogada

			final1:
				addi $v0, $zero, 1
				j modifica_tabuleiro
	
			final2:
				addi $v0, $zero, 5
				j modifica_tabuleiro
	
			final3:
				addi $v0, $zero, 9
				j modifica_tabuleiro
	
			final4:
				addi $v0, $zero, 25
				j modifica_tabuleiro
	
			final5:
				addi $v0, $zero, 29
				j modifica_tabuleiro
	
			final6:
				addi $v0, $zero, 33
				j modifica_tabuleiro
	
			final7:
				addi $v0, $zero, 49
				j modifica_tabuleiro

			final8:
				addi $v0, $zero, 53
				j modifica_tabuleiro
	 
			final9:
				addi $v0, $zero, 57
				j modifica_tabuleiro
	

	modifica_tabuleiro:
	
		#a0 -> flag se ta jogando o x(1) ou o(0)
		li $a0, 1		#escreve x nesse caso (dps vai ter que fazer isso com base num registrador que vai ficar trocando
		move $a1, $v0		#esse número vai vir atravéz do v0, valor de retorno da função que o victor ta fazendo
		jal escreve
		j jogada
	
	empate:
		jr $ra
		#aqui retorna o valor do resultado

escreve:
	#t0 endereço string
	la $t0, tabuleiro
	
	#a0, qual símbolo escreve
	beqz $a0, bolinha
	
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
	#imprime tabuleiro
	la $a0, tabuleiro
	li $v0, 4
	syscall
	jr $ra

condicao_vitoria:
	horizontal_1:
		1, 5, 9 tem o mesmo símbolo.
		flag
		
		#retorna 1 se x ganhou
		#0 se O ganhou
		#qualquer coisa se não foi decidido ainda
	

end:
