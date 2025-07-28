# Escreva um programa que leia uma string de entrada e armazene na memória iniciando na posição 0x10010000
# Transforme os caracteres maiúsculos de uma string em minúsculos e os caracteres minúsculos em maiúsculos.

.data 
	str: .asciiz "ONE RING to rule Them aLL\n"
	
.text
.globl main

main:
# maiusculo -> minúsculo  = +32
# A = 65
# Z = 90

la $t0, str		#carrega o endereço da string
lb $t1, 0($t0)	#carrega só um caracter
li $t2, 0x00	#carrega o terminador \0 pra loopar até o fim da string

#carrega os valores pra comparar se é maiusculo
li $t3, 65		
li $t4, 90

#carrega os valores pra comparar se é minúsculo
li $t5	97
li $t6 122


#printa a string normal
la $a0, str		#carrega a string no argumento 0
li $v0, 4		#indica que vamo printa uma string
syscall			#printa

loop:
	beq $t1, $t2, end_str
	
	# ------------- Problema aqui -----------------
	blt $t1, $t3, continue		 		#se o char  < 65, não mexe
	bgt $t1, $t4, capitaliza			#se é > 90, vai pra ver se é minuscula e pode capitalizar
	
	#se só passou desses dois testes, significa que é >= 65 e <= 90
	j descapitaliza
	
	#se ela não ta na primeira faixa, mas é maior que 90, pode ser que ela seja minúscula!
	
	
	# ------------- Problema aqui -----------------
	
	#se ainda tiver fora da faixa, > 122, então não mexe
	j continue 
	
	descapitaliza:
		#soma 32 pois é maiúscula
		addi $t1, $t1, 32
		sb $t1, 0($t0)	
		j continue
				
	capitaliza:
		#blt $t1, $t5, continue 				#se ta fora da faixa dos minúsculo > 90 e < 97. Não mexe
		#ble $t1, $t6, cont_cap 				#se é >= 97 e <= 122, capitaliza
		bgt $t1, $t6, continue					# se é maior que 122, nao faz nad
		cont_cap:
			#diminui 32, pois é minúscula
			subi $t1, $t1, 32
			sb $t1, 0($t0)
			j continue
			
	continue:
		addi $t0, $t0, 1	#move pro próximo caracter (1 byte a frente)
		lb $t1, 0($t0)		#carrega o próximo caracter
		j loop	
	
end_str:
	#printa a string trocada
	la $a0, str		#carrega a string no argumento 0
	li $v0, 4		#indica que vamo printa uma string
	syscall			#printa

end:


