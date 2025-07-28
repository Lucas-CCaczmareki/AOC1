# Exercício 3

ori $t1, $zero, 0x01	#t1 recebe 1 no bit menos significativo

#meu objetivo é preencher tudo com 32 1's no menor número de instruções possíveis usando só instruções de registrador

sll $t2, $t1, 1			#t2 recebe t1(0001) 1 bit deslocado pra esquerda (0010)
or $t1, $t1, $t2		#junta t2(0010) e t1(0001) = (0011) e armazena em t1

sll $t2, $t1, 2			#t2 <- desloca o t1 2 bits (1100)
or $t1, $t1, $t2		#t1 <- (0011) ou (1100) bit a bit

sll $t2, $t1, 4			#t2 <- desloca o t1(1111) em 4
or $t1, $t1, $t2		#t1 <- (00001111) ou (11110000) bit a bit

sll $t2, $t1, 8			# segue a mesma lógica exponencial
or $t1, $t1, $t2		

sll $t2, $t1, 16		#segue a mesma lógica exponencial
or $t1, $t1, $t2		#faz 16 0's 16 1's(0000ffff) ou 16 1's 16's(ffff0000) conseguindo 32 1's que é igual a 0xFFFFFFFF
