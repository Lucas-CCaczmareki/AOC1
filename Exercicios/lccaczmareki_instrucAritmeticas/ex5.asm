# a = (b * h)/2

# definindo b
addi $t1, $zero, 160

#definindo h
addi $t2, $zero, 120

# b * h
mult $t1, $t2	
mflo $t3						#guarda o resutlado de b*h em t3

# divide por 2
addi $t4, $zero, 2 				#guarda o 2
div $t3, $t4					#divine b*h por 2
mflo $t3						#guarda o valor, sem casa decimal (arredondado) em t3

