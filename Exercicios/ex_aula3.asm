# y = 32ab - 3a + 7b - 13 

# Inicia a seção de dados
.data
	a: .word 3
	b: .word 5
	y: .space 4
	
# Inicia a seção de instruções
.text
	lui $t0, 0x1001 #define endereço inicial e armazena no registrador?
	lw $t1 0($t0) #carrega a pra dentro do t1 o a, deslocamento(t0)
	lw $t2 4($t0) #carrega pra dentro do t2 o b,
	addi $t3, $zero, 32 #guarda 32 na t3
	mult $t1, $t2  # multiplica a e b
	mflo $t4 #chama o resultado do mult pro t4
	mult $t4, $t3 # faz o a*b * 32
	mflo $t5 # guarda tudo no t5
	
	#agora a lógica é basicamente repetir.