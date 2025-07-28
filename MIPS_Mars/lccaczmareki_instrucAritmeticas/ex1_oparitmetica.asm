# Faça um programa que some os números decimais
#326 - 211 + 311 - 648
#e escreva o resultado no registrador $t0

#prototype:
#addi $destino, $origem, $valor_imediato
addi $t0, $zero, 326 	# t0 <- 0 + 326
addi $t0, $t0, -211 	# t0 <- *t0 + (-211)
addi $t0, $t0, 311	# t0 <- *t0 + 311
addi $t0, $t0, -648	# t0 <- *t0 + (-648)