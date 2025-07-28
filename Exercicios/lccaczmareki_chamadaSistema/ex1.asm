# Escreva um programa que repetidamente pergunte ao usuário
# pelo número de quilômetros viajados e litros de gasolina 
# consumidos e depois imprima o número de quilômetros por litro

# Para sair do progrmaa, o usuário deve digitar 0 como número de quilômetros

# Armazene todos os números de quilômetros por litro na memória,
# iniciando pelo endereço 0x10010000

# ------------------------------------------------------

#Ta dando um problema: Como o exercício pede pra salvar na 0x1001000 e o .data inicia ai
# a string 1 ta sendo sobreescrita pelos dados inseridos

#Como a gente ainda não sabe alocação dinâmica aqui, vou só reservar um espaço pré-determinado

.data
	resultados: .space 100
	string1: .asciiz "Quilometros viajados (0 para sair): "
	string2: .asciiz "Litros de gasolina consumidos: "

.text
.globl main

main:

	# aqui vai ter que criar um ponteiro pra armazenar na memória?
	lui $t3, 0x1001
loop:
	#v0 sempre leva o código de operação do system call
	#a0, a1, e a2 levam os operadores
	# o resto "o sistema que se vire" ele meio q sabe
	li $v0, 4
	la $a0, string1
	syscall
	
	
	#aqui, ele espera a escrita e bota no v0 o valor lido
	li $v0, 5
	syscall
	add $t0, $zero, $v0		#guarda quilometros viajados em t0
	
	#se kms viajados é 0, então o usuário deseja sair
	beqz $t0, end
	
	#agora faz a mesma coisa pra gasolina consumida
	li $v0, 4				#recebe o código de operação
	la $a0, string2			#carrega a string pra dentro do a0
	syscall					#imprime na tela
	
	li $v0, 5				#código de operação: leitura inteiro
	syscall
	add $t1, $zero, $v0		#copia o valor lido pra dentro do t1
	
	div $t0, $t1			#calcula quantos km/l
	mflo $t2				#armazena a parte cheia da divisão (sem as casas após a vírgula)
	
	sw $t2, 0($t3)		#salva os km/l na 0x100100xx
	addi $t3, $t3, 4	#pula pra próxima word
	
	j loop

end:
	li $v0, 10
	syscall			#finaliza o programa
	
	
	
