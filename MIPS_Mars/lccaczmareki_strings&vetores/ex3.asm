# Ler um vetor de 10 posições e verificar se está ordenado ou não

.data
	vetor: .word 10, 20, 30, 40, 50, 60, 70, 80, 90, 100  # Vetor ordenado
    # vetor: .word 10, 20, 5, 40, 50, 60, 70, 80, 90, 100   # Vetor desordenado
    
.text
.globl main

main:
	#t0 flag se está ordenado
	li $t0, 1 #assumimos que está ordenado
	
	#$t1 aponta pro início do vetor
	la $t1, vetor
	
	# 3. Endereço final ($t5): Calcula o endereço do PENÚLTIMO elemento.
    #    O loop vai de i=0 a 8. O último i a ser verificado é 8,
    #    que corresponde ao endereço base + (8 * 4 bytes) = base + 32.
    #    A comparação será v[8] com v[9].
    addi $t5, $t1, 32  # 32 = 8 posições * 4 bytes/posição
    
loop:
	# carrega o elemento atual
	lw $t2, 0($t1)
	
	# carrega o próximo elemento
	lw $t3, 4($t1)	
	
	# se o atual é menor que o próximo (caso que está ordenado) continua
	ble $t2, $t3, continue_loop
	
	#caso esteja desordenado
	li $t0, 0	#reseta a flag (agora ele não está ordenado)
	j fim		#finaliza o programa, já que é só essa info que queremos
	
continue_loop:
	#precisa verificar se chegamos ao final da comparação
	# se o ponteiro do atual (t1) for igual ao endereço do penúltimo,
	# significa que já comparamos todos
	beq $t1, $t5, fim	#finaliza
	
	# se não fez todas comparações
	add $t1, $t1, 4		#avança o ponteiro do atual pro próximo número
	
	j loop 				# continua testando
	
fim:
	nop #finaliza, t0, contém o resultado
	#t0 = 0, vetor desordenado
	#t0 = 1, vetor ordenado
	
	