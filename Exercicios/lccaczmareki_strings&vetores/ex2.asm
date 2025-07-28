# Escreva um programa que altere uma string para "capitalizar" a primeira letra de cada palavra.
# Para capitalizar basta remover 32 do valor do caracter segundo a ascii


.data
	string: .asciiz "meu professor eh muito bom"
	
.text
.globl main

main:
	# t0 é o ponteiro que percorre a string
	la $t0, string
	
	# t1 é a flag de nova palavra
	# começa em 1 pois todo primeiro caracter de uma frase é uma palavra
	li $t1, 1
	
loop:
	# Carrega o caracter atual da string
	lbu $t2, 0($t0)
	
	# se for nulo, cabou-se, ai pula pro final
	beq $t2, $zero, fim
	
	#verifica se é um espaço
	li $t3, 32
	beq $t2, $t3, set_flag
	
	#se não for um espaço é uma letra. verifica o flag e capitaliza ou não
	#flag 0, avança pra próxima
	beq $t1, $zero, advance_pointer
	
	#flag 1, capitaliza
	subu $t2, $t2, 32
	#joga o caracter capitalizado pra dentro da string
	sb $t2, 0($t0)
	
	#retorna o flag pra 0, pois já capitalizou
	li $t1, 0
	j advance_pointer
	
# setando a flag quando encontra um espaço
set_flag:
	#um espaço significa que a próxima palavra é nova, e deve ter sua primeira letra capitalizada
	li $t1, 1
	#o resto do programa avança o ponteiro normal
	
advance_pointer:
	addi $t0, $t0, 1
	j loop	# loopa até \0
	
fim:
	#faz nada, só finaliza
