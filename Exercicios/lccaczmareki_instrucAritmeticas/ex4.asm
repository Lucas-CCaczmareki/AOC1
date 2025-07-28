# y = (9x + 7) / (2x + 8)

#salvando x
addi $t1, $zero, -4

# (9x + 7)
addi $t4, $zero, 9	#salva o 9 no t4
mult $t1, $t4		#x * 9
mflo $t4			#salva no t4 a multi
addi $t4, $t4, 7		#soma a mult com 7

#(2x + 8)
addi $t5, $zero, 2	#salva o 2 no t5
mult $t1, $t5		# x * 2
mflo $t5			# salva no t5
addi $t5, $t5, 8

# Testando pra ver se o que  a div por 0 mostra é o valor anterior mesmo
#addi $t6, $zero, 5	
#mult $t1, $t6
# e sim, quando x = -4, o compilador enfrenta uma divisão por 0
# que não é permitida, por isso ele não executa e só retorna oq tava na memória do lo e hi antes

# (9x + 7) / (2x + 8)
div $t4, $t5		# divide o resultado das duas expressões
mflo $t2			# armazena o quociente em t2
mfhi $t3			# armazena o resto em t3
