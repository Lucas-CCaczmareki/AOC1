# Escreva um programa que reomva os espaços de uma string
# USAR APENAS UMA STRING. 
# Terminar a string com nulo

# Lógica de 2 ponteiros. Leitura e escrita
# Se o caracter lido pelo ponteiro de leitura não for um espaço, copia ele pra onde ta o ponteiro de escrita

# Em Ascii
# espaço é 32
# nulo é 0




.data
	string: .asciiz "Gosto muito do meu professor de AOC-1."
	
.text
.globl main

main:
	# Carrega o endereço base da string nos ponteiros
	# La carrega um endereço em um registrador
	la $t0, string		#t0 = write_ptr
	la $t1, string		#t1 = read_ptr
	
# Loop para percorrer a string usando o read_ptr
loop:
	# Carrega um byte (1 char) da posição por read_ptr
	# lbu lê 1 byte (= 1 caracter)
	lbu $t2, 0($t1)
	
	# Verificando se o caracter que pegamos é nulo
	beq $t2, $zero, fim
	
	# Carrega o valor do espaço em branco num registrador pra comparar
	li $t3, 32
	
	# Compara o caracter que carregamos com o valor do espaço
	beq $t2, $t3, ignora_espaco
	
	# Se não for um espaço (ou seja, não foi desviado)
	# Armazenamos esse caracter na posição apontada pelo write_ptr
	sb $t2, 0($t0)
	addi $t0, $t0, 1	#incrementa o write_ptr pro próximo byte (caracter)
	
# Vai ser executado tanto pra pular um espaço quanto pra pular pra ler o próximo caracter
ignora_espaco:
	# Incrementa o read_ptr
	addi $t1, $t1, 1
	# Loopa até achar o terminador da string (nulo)
	j loop
	
# Finaliza o programa, salvando o nulo
fim:
	#Só entra aqui após percorrer toda string
	#Escreve o terminador nulo pra onde o write_ptr aponta (sempre prox espaço livre)
	sb $zero, 0($t0)














