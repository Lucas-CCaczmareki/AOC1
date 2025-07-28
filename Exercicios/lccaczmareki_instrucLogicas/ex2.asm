# Exercício 2

# A instrução ORI só aceita valores imediatos de até 16 bits!
#por isso se faz necessário esse "truque"

ori $t1, $zero, 0xAAAA		#Acidionaem t1 o resultado de uma comparação bit a bit com o valor máx AAAA
sll $t1, $t1, 16			#desloca esse valor em 16 bits
ori $t1, $t1, 0xAAAA		#Adiciona os outros 16 bits (AAAA) na parte menos significativa

srl $t2, $t1, 1				#faz um shift do AAAAAAAA pra direita em 1 bit e coloca em t2

#OR entre t1 e t2
or $t3, $t1, $t2			#t3 <- t1 OR t2

#AND entre t1 e t2
and $t4, $t1, $t2			#t4 <- t1 AND t2

#XOR entre t1 e t2
xor $t5, $t1, $t2			#t5 <- t1 XOR t2

#t1 está preenchido com 32 bits da seguinte maneira
#10101010101010101010101010101010 (t1)

#Ao fazer o deslocamento de 1 bit pra direita e armazenar em t2, ele preenche o mais significativo com 0, fica assim
#01010101010101010101010101010101 (t2)

#Ao fazer um OR bit a bit preenchemos o registrador com 1's
#11111111111111111111111111111111 (t3)

#Ao fazer um AND bit a bit, deixamos o registrador com 0's
#00000000000000000000000000000000 (t4)

#Ao fazer um XOR bit a bit, deixamos o registrados com 1's
#11111111111111111111111111111111 (t5)