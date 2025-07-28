.data
	nova_linha: .asciiz "\n"
	string1: .asciiz "Quilometros viajados (digite 0 para sair): "
	string2: .asciiz "Litros de gasolina consumidos: "

.text
.globl main

main:
	# Usando $s0 para o ponteiro, pois é um registrador salvo que persiste
	# entre chamadas de sub-rotina.
	lui $s0, 0x1001
	
loop:
	# Imprime uma nova linha para formatação.
	li $v0, 4
	la $a0, nova_linha
	syscall

	# Pergunta pelos quilômetros.
	li $v0, 4
	la $a0, string1
	syscall
	
	# Lê o inteiro digitado pelo usuário.
	li $v0, 5
	syscall
	
	# Se o valor lido for 0, o programa termina.
	beq $v0, $zero, end
	
	# Prepara o primeiro argumento para a sub-rotina.
	move $a0, $v0		# Argumento 1 ($a0): Quilômetros.

	# Pergunta pelos litros.
	li $v0, 4
	la $a0, string2
	syscall
	
	# Lê o inteiro.
	li $v0, 5
	syscall
	move $a1, $v0		# Argumento 2 ($a1): Litros.
	
	# Passa o ponteiro de memória atual como terceiro argumento.
	move $a2, $s0       # Argumento 3 ($a2): Endereço de memória.

	# Chama a sub-rotina para realizar o cálculo e o armazenamento.
	jal calculate_and_store
	
	# A sub-rotina retorna o novo endereço do ponteiro em $v0.
	# Atualizamos nosso ponteiro principal com esse novo valor.
	move $s0, $v0
	
	j loop

# --------------------------------------------------------------------------
# Sub-rotina: calculate_and_store
# Realiza a divisão e armazena o resultado na memória.
# Argumentos:
#   $a0: Quilômetros
#   $a1: Litros
#   $a2: Ponteiro de memória atual
# Retorno:
#   $v0: Novo valor do ponteiro de memória (endereço + 4)
# --------------------------------------------------------------------------
calculate_and_store:
	# Divide km ($a0) por litros ($a1).
	div $a0, $a1
	mflo $t0			# Armazena o quociente em um registrador temporário.
	
	# Armazena o resultado no endereço de memória apontado por $a2.
	sw $t0, 0($a2)
	
	# Prepara o valor de retorno (o novo ponteiro).
	addi $v0, $a2, 4
	
	# Retorna para o chamador (o loop principal).
	jr $ra

end:
	# Finaliza o programa.
	li $v0, 10
	syscall
