# Exercício 1

ori $t7, $zero, 0xD 	# t7 <- or bit a bit do 0 com D
sll $t7, $t7, 4			# desloca o t7 4 bits pra esquerda

# o resto faz a mesma coisa que o de cima!
ori $t7, $t7, 0xE
sll $t7, $t7, 4

ori $t7, $t7, 0xC
sll $t7, $t7, 4

ori $t7, $t7, 0xA
sll $t7, $t7, 4

ori $t7, $t7, 0xD
sll $t7, $t7, 4

ori $t7, $t7, 0xA
sll $t7, $t7, 4

ori $t7, $t7, 0x7
sll $t7, $t7, 4

ori $t7, $t7, 0x0
