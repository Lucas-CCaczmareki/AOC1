# Escreva um programa que calcule o fatorial de um número N inteiro sem sinal, 
#o valor N deve ser inicializado no registrador $t0. 

# Para o cálculo do fatorial deve ser utilizada uma subrotina recursiva. 
#O resultado final deve ser armazenado em $t1.
#O argumento para a subrotina deve ser passado através do registrador $a0 
#e o resultado da subrotina deve ser retornado através do registrador $v0.

.globl main
main:
	li $t0, 6	#carrega o valor do fatorial pra dentro de t0
	move $a0, $t0 #passa o 5 como argumento
	subi $a1, $a0, 1
	
	jal fatorial
	j end
	

fatorial:	
	#guarda o ra
	addiu $sp, $sp, -4
	sw $ra, ($sp)
	
	#faz as contas
	beqz $a1, end_fat
	mult $a0, $a1
	mflo $v0
	
	#a0 igual a resultado da multiplicação
	move $a0, $v0
	subi $a1, $a1, 1
	
	#recursivo com o resultado
	jal fatorial
	
	end_fat:
		lw $ra, ($sp)
		addiu $sp, $sp, 4
		jr $ra
	

end:
