.data
	vetor:    .word   15, -3, 0, 8, 25, -10, 5, 30, 7, 4  # O vetor ocupa 40 bytes
	tamanho:  .word   10                                  # O tamanho está em 0x10010028

.text
    # Carrega valores de exemplo para o intervalo [$s0, $s1] = [0, 10]
    add  $s0, $zero, $zero         # $s0 = $zero + $zero
    addi $s1, $zero, 10            # $s1 = $zero + 10

    # Carrega endereço ($s3) e tamanho ($s4) do vetor
    lui  $s3, 0x1001               #Carrega a parte alta do endereço do segmento de dados
    
    # 'tamanho' está 40 bytes após o início de 'vetor'
    lw   $s4, 40($s3)              # Carrega a palavra do endereço ($s3 + 40)

    # Prepara os registradores para o laço
    add  $t3, $zero, $zero         # Inicia o contador $t3 com 0.
    add  $t0, $s3, $zero           # Copia o endereço de $s3 para o ponteiro $t0.

    # Calcula o endereço final do vetor em $t1
    addi $t7, $zero, 4             # Carrega a constante 4 em um registrador temporário
    mult $s4, $t7                  # Efetua a multiplicação. Resultado vai para HI/LO
    mflo $t1                       # Move o resultado de LO para $t1 (tamanho em bytes)
    add  $t1, $s3, $t1             # $t1 = endereço_inicial + tamanho_em_bytes

# --- 2. Laço para percorrer o vetor ---
loop:
    # Condição de parada: if (ponteiro >= endereço_final) pula pra end_loop
    #t0 começa no ínicio, t1 guarda o endereço final
    slt  $at, $t0, $t1             # $at = 1 se $t0 < $t1, senão $at = 0
    beq  $at, $zero, end_loop      # Se $at for 0 (indicando $t0 >= $t1), pule para o fim.

    # Carrega o elemento atual do vetor
    lw   $t2, 0($t0)               # $t2 = vetor[i]

    # Verifica se o elemento está FORA do intervalo
    # if (elemento < min), pule para o próximo
    slt  $at, $t2, $s0             # $at = 1 se $t2 < $s0
    bne  $at, $zero, next_element  # Se $at for 1, pule para o próximo elemento.

    # if (elemento > max), pule para o próximo
    slt  $at, $s1, $t2             # $at = 1 se $s1 < $t2 (equivalente a $t2 > $s1)
    bne  $at, $zero, next_element  # Se $at for 1, pule para o próximo elemento.

    # Se o programa chegou aqui, o número está DENTRO do intervalo. Incrementa o contador.
    addi $t3, $t3, 1               # contador = contador + 1

next_element:
    # Avança o ponteiro para o próximo elemento do vetor (4 bytes)
    addi $t0, $t0, 4               # ponteiro = ponteiro + 4
    j    loop                      # Salta de volta para o início do laço

end_loop:
    # O resultado final já está em $t3
   