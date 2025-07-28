# Uma temperatura, armazenada em $t0, pode ficar em dois intervalos:
# 		20 <= temp <= 40 e
#		60 <= temp <= 80.

# Escreva um programa que coloque uma flag (registrador $t1) para 1 
# se a temperatura está entre os valores permitidos e para 0 caso contrário.

# Inicie o código com a instrução: ori $t0, $zero, temperatura, substituindo
# temperatura por um valor qualquer.

ori $t0, $zero, 80		#carrega um valor para temperatura

#1o intervalo
slti $t1, $t0, 41		#se ela for menor que 41, seta
slti $t2, $t0, 20		#se for menor que 20, seta outra

beq $t1, $t2, zera1		#se for menor q quarente e menor que 20 zera. não cumpriu a condição.
j end					#se ela estava no intervalo (não é < 20 e > 40, finaliza)

#zera as comparações pra conferir no segundo intervalo
zera1:
	add $t1, $zero, $zero	
	add $t2, $zero, $zero

#2ndo intervalo
slti $t1, $t0, 81		#se for menor que 81, seta
slti $t2, $t0, 60		#se for menor que 60, seta outra

beq $t1, $t2, zera2		#se for menor que 80 e menor que 60, não cumpriu a condição do segundo intervalo
j end					#se cumpriu a condição (está no intervalo 2) finaliza

#zera as flags pra mostrar o resultado correto, se for caso
zera2:
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	
#só finaliza o programa
end: