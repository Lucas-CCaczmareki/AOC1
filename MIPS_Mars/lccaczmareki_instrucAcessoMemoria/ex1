# y = 32ab - 3a + 7b - 13 

# Inicia a seção de dados
.data
	a: .word 3
	b: .word 5
	y: .space 4
	
# Inicia a seção de instruções
.text
	lui $t0, 0x1001 		#define endereço inicial e armazena no registrador?
	lw $t1 0($t0) 			#carrega a pra dentro do t1 o a, deslocamento(t0)
	lw $t2 4($t0) 			#carrega pra dentro do t2 o b,
	
	addi $t3, $zero, 32 	#guarda 32 na t3
	mult $t1, $t2  			#multiplica a e b
	mflo $t4 				#chama o resultado do mult pro t4
	mult $t4, $t3 			#faz o a*b * 32
	mflo $t4 				#guarda tudo no 45
	
	addi $t3, $zero, 3		#t3 <- 3
	mult $t1, $t3			#t1(a) * t3(3) 
	mflo $t5				#t5 <- 3a
	
	addi $t3, $zero, 7
	mult $t3, $t2			#7*b
	mflo $t6				#guarda o 7b no t6
	
	addi $t3, $zero, 13
	
	#agora só somar tudo e guardar em y
	addi $t3, $zero, 13    # t3 = 13
	
	#montando o endereço de y na memoria (10010008)
	lui $t7, 0x1001        # carrega os primeiros 16 bits + significativos
	ori $t7, $t7, 0x0008	# carrega os últimos 16 bits - significativos

	sub  $t8, $t4, $t5        # t8 = 32ab - 3a
	add  $t8, $t8, $t6        # t8 = (32ab - 3a) + 7b
	sub  $t8, $t8, $t3        # t8 = (32ab - 3a + 7b - 13)

	sw   $t8, 8($t7)          # armazena o resultado final (t7) em y (t0+8)
	