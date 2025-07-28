# y = 3x² -5x +13

#definindo x
addi $t5, $zero, -1

# 3x²
addi $t1, $zero, 3	# salva 3 em t1
mult $t5, $t5		# x * x
mflo $t2			# salva x² em t2
mult $t1, $t2		# 3 * x²
mflo $t6			# salva 3x² em t6 (y)_

# 5x
addi $t1	, $zero, 5	# salva 3 em t1
mult $t1, $t5		# 5 * x
mflo $t2			# salva 5x em t2
sub $t6, $t6, $t2	# faz 3x² - 5x

# + 13
addi $t6, $t6, 13	# t6 <- 3x² - 5x + 13 