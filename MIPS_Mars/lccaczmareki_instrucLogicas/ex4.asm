# carrega 0x12345678 em $t1
ori $t1, $zero, 0x1234
sll $t1, $t1, 16			#desloca pra parte mais significativa
ori $t1, $t1, 0x5678

# carrega 0xF000 0000 num registrador auxiliar
ori $t3, $zero, 0xF000
sll $t3, $t3, 16

#compara 1111 com o mais significativo (1) pra manter seus valores
# e depois desloca para o final de t2 para inverter
and $t2, $t1, $t3
srl $t2, $t2, 28

#copia a mesma lógica aqui
srl $t3, $t3, 4 	#move 1 pro lado
and $t4, $t3, $t1	#guarda o 2 em outro registrador auxiliar (fica 0x0200 0000
srl $t4, $t4, 20	#move o 2 pra posição certa (0x0000 0020)
or $t2, $t2, $t4	#faz um ou do registrador 4 (aux) com o 2 para montar na ordem contrária

#segue a mesma lógica
srl $t3, $t3, 4
and $t4, $zero, $zero	#zera o registrador auxiliar
and $t4, $t3, $t1
srl $t4, $t4, 12
or $t2, $t2, $t4

#segue a mesma lógica
srl $t3, $t3, 4
and $t4, $zero, $zero	#zera o registrador auxiliar
and $t4, $t3, $t1
srl $t4, $t4, 4
or $t2, $t2, $t4

#agora a lógica de posição vai precisar mudar, já que ela começa a ir pra esquerda
srl $t3, $t3, 4
and $t4, $zero, $zero	#zera o registrador auxiliar
and $t4, $t3, $t1
sll $t4, $t4, 4			#joga o 5 uma posição pra trás
or $t2, $t2, $t4

#mesma lógica
srl $t3, $t3, 4
and $t4, $zero, $zero		#zera o registrador auxiliar
and $t4, $t3, $t1
sll $t4, $t4, 12			#joga o 5 uma posição pra trás
or $t2, $t2, $t4

#mesma lógica
srl $t3, $t3, 4
and $t4, $zero, $zero		#zera o registrador auxiliar
and $t4, $t3, $t1
sll $t4, $t4, 20			#joga o 5 uma posição pra trás
or $t2, $t2, $t4

#mesma lógica
srl $t3, $t3, 4
and $t4, $zero, $zero		#zera o registrador auxiliar
and $t4, $t3, $t1
sll $t4, $t4, 28			#joga o 5 uma posição pra trás
or $t2, $t2, $t4



