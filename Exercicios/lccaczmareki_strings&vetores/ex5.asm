# declare 3 vetores de tamanho igual
#inicialize um ponteiro pra cada vetor (la) e faça elementos do vetor 2 a 2
# o vetor resultante deve ser armazenado depois dos elementos do segundo vetor
# soma [i] = vetor1[i]+vetor2[i]

.data
	tamanho: .word 7
	vetor1: .word -30, -23, 56, -43, 72, -18, 71
	vetor2: .word 45, 23, 21, -23, -82, 0, 69
	soma: .word 0, 0, 0, 0, 0, 0, 0
	
.text
.globl main

main: 
	la $t0, vetor1#t0 ponteiro para vetor 1
	la $t1, vetor2#t1 pointeiro pra vetor 2
	la $t5, soma #t5 ponteiro para vetor resultado
	lw $t3, tamanho
	add $t2, $zero, $zero #t2, contador i
	
loop:
	bge $t2, $t3, end #se i >= tamanho vetor, finaliza
	
	#t6 e t7 vão ser auxiliar pra guardar os valores a serem somados
	lw $t6, 0($t0)
	lw $t7, 0($t1)
	
	add $t4, $t6, $t7	#soma v1[i] + v2[i]
	sw $t4, 0($t5)		#salva a soma no vetor resultado
	
	#pula pros próximos espaços nos ponteiros dos vetores e contador
	addi $t0, $t0, 4	#v1, cada inteiro = 4 bytes
	addi $t1, $t1, 4	#v2
	addi $t2, $t2, 1	#contador
	addi $t5, $t5, 4	#v_soma(resultado)
	
	j loop
end:
	nop