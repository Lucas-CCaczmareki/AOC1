# Escreva um programa que leia uma string de entrada e armazene na memória iniciando na posição 0x10010000
# Transforme os caracteres maiúsculos de uma string em minúsculos e os caracteres minúsculos em maiúsculos.

.data
    str: .asciiz "ONE RING to rule Them aLL\n"
    
.text
.globl main

main:
    # Maiusculo -> minusculo = +32
    # A = 65, Z = 90
    # Minusculo -> maiusculo = -32
    # a = 97, z = 122

    la $t0, str     # $t0 = ponteiro para o caractere atual da string 
    lb $t1, 0($t0)  # $t1 = carrega o primeiro caractere (valor ASCII)
    li $t2, 0x00    # $t2 = terminador nulo (para fim da string)

    # Carrega os valores limite para as comparações
    li $t3, 'A'     # $t3 = ASCII de 'A' (65)
    li $t4, 'Z'     # $t4 = ASCII de 'Z' (90)
    li $t5, 'a'     # $t5 = ASCII de 'a' (97)
    li $t6, 'z'     # $t6 = ASCII de 'z' (122)

    # Printa a string original (para comparação)
    li $v0, 4       # Syscall para imprimir string
    la $a0, str     # Endereço da string
    syscall         # Executa a syscall 

loop:
    beq $t1, $t2, end_str # Se chegou ao fim da string (caractere nulo), termina o loop
    
    # Lógica para converter MAIÚSCULO para minúsculo
    blt $t1, $t3, check_lower  # Se char < 'A', não é maiúscula, pula para verificar minúscula.
    bgt $t1, $t4, check_lower  # Se char > 'Z', não é maiúscula, pula para verificar minúscula.
    
    # Se chegou até aqui, é MAIÚSCULA. Converte para minúscula.
    addi $t1, $t1, 32
    sb $t1, 0($t0) # Salva o caractere modificado de volta na memória
    j next_char    # Terminou o processamento para este caractere, vai para o próximo

check_lower:
    # Lógica para converter MINÚSCULO para MAIÚSCULO
    blt $t1, $t5, next_char  # Se char < 'a', não é minúscula, pula para o próximo.
    bgt $t1, $t6, next_char  # Se char > 'z', não é minúscula, pula para o próximo.
    
    # Se chegou até aqui, é MINÚSCULA. Converte para maiúscula.
    addi $t1, $t1, -32
    sb $t1, 0($t0) # Salva o caractere modificado de volta na memória

next_char:
    addi $t0, $t0, 1 # Move o ponteiro $t0 para o próximo byte/caractere
    lb $t1, 0($t0)   # Carrega o próximo caractere para $t1
    j loop           # Volta para o início do loop

end_str:
    # Printa a string modificada
    li $v0, 4       # Syscall para imprimir string
    la $a0, str     # Endereço da string
    syscall         # Executa a syscall

end:
    li $v0, 10 # Finaliza o programa 
    syscall    # Executa a syscall 