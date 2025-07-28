.data
	#definindo o vetor
	l: .word 0
	u: .word 0
	c: .word 0
	i: .word 0
	a: .word 0
	n: .word 0
	o: .word 0
	b: .word 0
	
.text
	#definindo o endereço
	lui $t0, 0x1001
	
	#definindo as váriaveis
	add  $t1, $t1, $zero		#i = 0
	addi $t2, $t2, 8			#end = 8
	add  $t3, $t3, $zero		#resto
	addi $t4, $t4, 2			#divisor e multiplicador auxiliar 2
	addi $t5, $t5, 4			#multiplicador auxiliar 4 p endereço
	addi $t6, $t6, 0			#resultado
	add  $t7, $t7, $zero		#pos endereço
	
	#código
	loop:
		div $t1, $t4
		mfhi $t3
		beq $t3, $zero, par
		j impar
		
		
	par:
		mult $t1, $t4	#i*2
		mflo $t6		#armaezna em resultado
		
		mult $t1, $t5	#i*4 pra posição do endereço
		mflo $t7		#armazena em pos endereço
		
		sw $t6, 0($t0)	#salva em vet[i]
		addi $t0, $t0, 4	#desloca o endereço
		
		addi $t1, $t1, 1	#i++
		beq $t1, $t2, end	#se i == 8 finaliza
		j loop				#se não, loopa
	
	impar:
		#ta errado a lógica em C, a posição atual no vetor não tem nada, ou seja pode conter lixo
		#aqui no mips eu inicializei o vetor com 0, então ele só faz um soma com 0.
		
		lw $t6, 0($t0) #loada a palavra atual
		sub $t0, $t0, $t5	# manda o endereço pra posição anterior
		lw $t6, 0($t0)	#loada a palavra anterior
		addi $t0, $t0, 4	# manda o endereço pra atual de novo
		
		add $t6, $t6, $t8 	#palavra anterior + atual
		sw $t6, 0($t0)
		
		addi $t0, $t0, 4	# manda o endereço pra próx livre
		
		# lógica de desvio
		addi $t1, $t1, 1
		beq $t1, $t2, end
		j loop
		
	end:
	