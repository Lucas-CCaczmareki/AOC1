# Escreva um programa que conte com três subrotinas capazes de calcular a área da
#circunferência (π*r^2), do triângulo (b*a/2) e do retângulo (b*a).

# Inicialmente, pergunte ao usuário (use syscall) qual forma geométrica ele deseja (armazenando no
#registrador $t0) e depois solicite as medidas necessárias para calcular a área de cada forma 

# (armazenar para circunferência o valor r em $t0, 
#triângulo e retângulo armazenar valor de a e b em $t0 e $t1, respectivamente). 

# Ao final, imprima a área desejada. Respeite as convenções de uso dos registradores.

.data
	str1: .asciiz "Qual forma geometrica voce deseja calcular a area?\n1. Circulo\n2. Triangulo\n3. Retangulo\nDigite sua opcao: "
	raio: .asciiz "Digite o raio: "
	base: .asciiz "Digite a base: "
	alt: .asciiz "Digite a altura: "
	res: .asciiz "O resultado e: "
	
.text
.globl main

main:
	li $v0, 4 		#indica pro system qual é a função que ele vai executar
	la $a0, str1 	#carrega a str1 pro argumento
	syscall			#chama função
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	#com base em t0, ele pula pra função designada
	beq $t0, 1, a1
	beq $t0, 2, a2	
	beq $t0, 3, a3
	
	#calcula a area e finaliza o programa
	a1: jal circulo
	j end
	a2: jal triangulo
	j end
	a3: jal retangulo
	j end
	
circulo:
#pi * r * r
# considerando pi = 3 pra facilitar
	li $v0, 4 		#imprime a string
	la $a0, raio 	#define a string a ser impressa
	syscall
	
	li $v0, 5 		#espera o usuario digitar o raio
	syscall
	
	move $t0, $v0 	#move o valor do raio pra t0
	mult $t0, $t0	#raio ao quadrado
	mflo $t0
	
	li $t1, 3 		#carrega o pi
	mult $t1, $t0 	#pi * r^2
	mflo $v0		#resultado
	
	# ------------ Imprimindo resultado ---------------
	
	move $t2, $v0 	#salva o resultado em t2
	li $v0, 4		#imprime string
	la $a0, res		
	syscall
	
	li $v0, 1		#imprime int
	move $a0, $t2	#a0 = t2 (resultado)
	syscall			#printa o resultado
	
	jr $ra			#volta pro main

triangulo:
#base * altura / 2
	# ---------------- Base ------------------
	li $v0, 4 		#imprime a string
	la $a0, base 	#define a string a ser impressa
	syscall
	
	li $v0, 5 		#espera o usuario digitar a base
	syscall
	
	move $t0, $v0 	#move o valor da base pra t0
	
	# ------------ Atltura ----------------
	li $v0, 4 		#imprime a string
	la $a0, alt 	#define a string a ser impressa
	syscall
	
	li $v0, 5 		#espera o usuario digitar a altura
	syscall
	
	move $t1, $v0 	#move o valor da altura pra t1
	
	# ---------- Calculos ----------------
	mult $t0, $t1	#base * altura
	mflo $t0		#carrega o resultado disso no t0
	li $t1, 2		#carrega o 2 no t1
	div $t0, $t1	# base * alt / 2
	mflo $v0		# salva o resultado da area no v0
	
	# ------------ Imprimindo resultado ---------------
	
	move $t2, $v0 	#salva o resultado em t2
	li $v0, 4		#imprime string
	la $a0, res		
	syscall
	
	li $v0, 1		#imprime int
	move $a0, $t2	#a0 = t2 (resultado)
	syscall			#printa o resultado
	
	jr $ra			#volta pro main
	

retangulo:
#base * altura	
	# ---------------- Base ------------------
	li $v0, 4 		#imprime a string
	la $a0, base 	#define a string a ser impressa
	syscall
	
	li $v0, 5 		#espera o usuario digitar a base
	syscall
	
	move $t0, $v0 	#move o valor da base pra t0
	
	# ------------ Atltura ----------------
	li $v0, 4 		#imprime a string
	la $a0, alt 	#define a string a ser impressa
	syscall
	
	li $v0, 5 		#espera o usuario digitar a altura
	syscall
	
	move $t1, $v0 	#move o valor da altura pra t1
	
	# ---------- Calculos ----------------
	mult $t0, $t1	#base * altura
	mflo $v0		#carrega o resultado disso no v0
	
	
	# ------------ Imprimindo resultado ---------------
	move $t2, $v0 	#salva o resultado em t2
	li $v0, 4		#imprime string
	la $a0, res		
	syscall
	
	li $v0, 1		#imprime int
	move $a0, $t2	#a0 = t2 (resultado)
	syscall			#printa o resultado
	
	jr $ra			#volta pro main
	
end:
	
	