#Escreva uma subrotina que retorne a média entre três valores. 
#A subrotina deve receber como argumentos três inteiros e retornar a média entre eles.

# o programa deve ler os 3 valores do usuário e mostrar o resultado
# o programa deve utilizar os registradores convencionados
# o retorno da subrotina vai pro t5

.data
	str1: .asciiz "Digite o valor: "
	str2: .asciiz "A media entre os valores digitados é: "
	
.text
.globl main

main:
	#------------------- 1o valor -------------------
	li $v0, 4 		#avisa pro syscall q ele vai ler strin
	la $a0, str1	#carrega a str1 no argumento 0
	syscall			#faz a chamada do syscall
	
	li $v0, 5
	syscall
	# add $a0, $zero, $zero
	move $a1, $v0

	#------------------- 2o valor -------------------	
	li $v0, 4 		#avisa pro syscall q ele vai ler strin
	syscall			#faz a chamada do syscall
	
	li $v0, 5
	syscall
	# add $a0, $zero, $zero
	move $a2, $v0
	
	#------------------- 3o valor -------------------
	li $v0, 4 		#avisa pro syscall q ele vai ler strin
	syscall			#faz a chamada do syscall
	
	li $v0, 5
	syscall
	# add $a0, $zero, $zero
	move $a3, $v0	
	
	# Faz a média dos 3 valores
	jal med3val
	
	# printa o resultado
	move $t5, $v1
	li $v0, 4
	la $a0, str2
	syscall
	
	li $v0, 1
	move $a0, $t5
	syscall

	
	# finaliza o programa
	li $v0, 10
	syscall

med3val:
	add $v0, $a1, $a2
	add $v0, $v0, $a3
	
	div $v1, $v0, 3
	jr $ra