# 4x - 2y + 3z
# x, y e z em $t1, $t2 e $t3
# res no t7

#definindo x
addi $t1, $zero, 1

#definindo y
addi $t2, $zero, 2

#definindo z
addi $t3, $zero, 3

# 4 * x 
addi $t4, $zero, 4 	#guarda o 4 no t4
mult $t1, $t4		# multiplica x * 4
mflo $t1			# traz o resultado da multiplicação pra dentro do t1

# 2  * y
addi $t4, $zero, 2	#guarda o 2 no t4
mult $t2, $t4		# multiplica 2 * y
mflo $t2			# guarda o resultado em t2

# 3 * z
addi $t4, $zero, 3	#guarda o 3 no t4
mult $t3, $t4		# multiplica 3 * z
mflo $t3			# guarda o resutlado em t3

## 4x - 2y + 3z
sub $t7, $t1, $t2
add $t7, $t7, $t3


  