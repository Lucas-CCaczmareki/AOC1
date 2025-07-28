# Escreva um programa equivalente ao código C abaixo com o assembly do MIPS.
# Assim como no exemplo em C, utilize duas subrotinas (soma3n e soma).
# Armazene os valores em $t0, $t1, $t2 e $t3, para X, Y, Z e R, respectivamente.

# main(){
#int X=150;
#int Y=230;
#int Z=991;
#int R=0;
#R = soma3n(X, Y, Z);
#}
#int soma3n(int n1, int n2, int n3){
#return( soma(n3, soma(n1, n2)));
#}
#int soma(int A, int B){
#return( A+B );
#}

.globl main
main:
	li $a0, 150
	li $a1, 230
	li $a2, 991
	jal soma3n
	j end
	
	
soma3n:
	#aqui a gente quebra uma diretriz de que uma subrotina não pode chamar outra\
	#mas como é o que o exercício pediu, simbora. Vai precisar de uma pilha pra armazenar o ra
	
	#faz um push
	addiu $sp, $sp, -4 #move o ponteiro pro próximo espaço livre	
	sw $ra, ($sp)
	

	jal soma		#soma A + B
	move $a0, $v0 	#traz o resultado de A + B pra A
	move $a1, $a2 	#traz o C pra dentro de B
	jal soma		#soma A + B
	
	#agora preciso carregar o topo da pilha
	#faz um pop
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	
	#ra agora tem a parte do main que apontávamos antes
	jr $ra
	
	
soma:
	add $v0, $a0, $a1
	jr $ra
	
end:
