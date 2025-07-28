# Crie um programa para calcular a soma S de todos os números pares dentre os N números informados pelo usuário.
# Inicialmente, o número N deverá ser lido pelo teclado e, logo depois, serão lidos os N valores. 
# Os N valores lidos devem ser armazenados na memória

# O resultado S da soma de pares deverá ser apresentado na tela, assim como a quantidade Q de valores pares.
# Você deve criar uma sub-rotina para a leitura dos valores e uma sub-rotina para encontrar e somar os pares.

.data
	str1: .asciiz "Quantos valores voce deseja ler? "
	str2: .asciiz "Valor: "
	str3: .asciiz "Soma pares = "
	#res: .space 0

.text	
.globl main
main: 
	li $v0, 4		#indica que vamos printar uma string
	la $a0, str1	#carrega o endereço da string pra a0
	syscall			#printa ela
	
	li $v0, 5		#indica que vamos ler um int
	syscall			#espera leitura
	move $a1, $v0	#move o valor lido pra a0
	
	jal leitura
	jal soma_par
	j end
	



leitura:
	#esse endereço pode mudar se eu precisar de mais strings
	lui $t2, 0x1001		#carrega o espaço livre de memória após as strings
	li $t3, 0x0020		
	or $t2, $t2, $t3
	addi $t2, $t2, 24
	
	loop_read:
		beq $t0, $a1, end_read		#enquanto t0 < n, loopa
		addi $t0, $t0, 1			#$t0++
		
		li $v0, 4		#indica que vamos printar uma string
		la $a0, str2	#carrega o endereço da string pra a0
		syscall			#printa ela
		
		li $v0, 5		#indica que vamos ler um int
		syscall			#espera leitura
		
		move $t1, $v0		#move o valor lido pra t1
		
		sw $t1, 0($t2)		#armazena o valor lido lá	
		addi $t2, $t2, 4	#move pra próxima posição livre
											
		j loop_read
	
	end_read:
	jr $ra

soma_par:
	#t0, contador
	#t1, valor
	#t2, endereço
	#t3, soma
	#t4, auxiliar 2 pra divisão
	#t5, auxiliar resto
	
	
	#esse endereço pode mudar se eu precisar de mais strings
	lui $t2, 0x1001		#carrega o espaço de memória onde está os números lidos
	li $t3, 0x0020		
	or $t2, $t2, $t3
	addi $t2, $t2, 24
	
	li $t0, 0	#zera o contador
	li $t3, 0	#zera o t3
	li $t4, 2	#carrega o 2 pra dividir
	
	loop_par:
		beq $t0, $a1, end_par		#enquanto t0 < n, loopa
		addi $t0, $t0, 1			#$t0++
		
		lw $t1, 0($t2)		#carrega o valor lido
		addi $t2, $t2, 4	#move pra próxima posição
		
		div $t1, $t4		#n / 2
		mfhi $t5			#resto da divisao
		
		beqz $t5, par		#se o resto da divisão é igual a 0, ele é par
		j impar
		
		par:
			add $t3, $t3, $t1	#soma += n(t1)
		
		impar:
			j loop_par
			
	end_par:
		li $v0, 4		#indica que vamos printar uma string
		la $a0, str3	#carrega o endereço da string pra a0
		syscall			#printa ela
		
		li $v0, 1		#indica que vai printar um inteiro
		move $a0, $t3	#move o valor da soma
		syscall
		jr $ra
		
end:
