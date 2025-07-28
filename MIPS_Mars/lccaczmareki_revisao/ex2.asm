# Calcula: A = PRODUTÓRIO(i=0 até n) de (n + i/2)

.data
	n: .word 4	#n = 4

.text
    # --- 1. Carregar o valor de 'n' da memória ---
    lui $t0, 0x1001             # Carrega 0x1001 nos 16 bits mais altos de $t0
    lw  $s0, 0($t0)             # Carrega a palavra do endereço ($t0 + 0) em $s0

    # --- 2. Inicializar variáveis ---
    addi $s1, $zero, 1          # $s1 = $zero + 1
    add $t1, $zero, $zero       # $t1 = $zero + $zero
    addi $t3, $zero, 2          # $t3 = $zero + 2

# --- 3. Iniciar o laço de cálculo do produtório ---
loop:
    # Condição de saída: sair do laço se i > n
    slt $t2, $s0, $t1           # $t2 = 1 se $s0 < $t1 (n < i), senão $t2 = 0
    bne $t2, $zero, end_loop    # Se $t2 != 0, desvia para end_loop

    # a. Calcular i / 2
    div $t1, $t3                # Efetua a divisão. Quociente em LO, resto em HI
    mflo $t4                    # Move o quociente (de LO) para $t4

    # b. Calcular n + (i / 2)
    add $t5, $s0, $t4           # $t5 = $s0 + $t4

    # c. Atualizar o produtório A = A * (n + i/2)
    mult $s1, $t5               # Multiplica $s1 por $t5. Resultado de 64 bits em HI/LO
    mflo $s1                    # Move a parte baixa (32 bits) do resultado para $s1
                                # (Assumindo que o resultado não excederá 32 bits)

    # d. Incrementar o contador 'i'
    addi $t1, $t1, 1            # $t1 = $t1 + 1

    j loop                      # loopa

# 4. Fim do laço e armazenamento do resultado
end_loop:
    sw $s1, 4($t0)              # Armazena $s1 no endereço ($t0 + 4)

# Fim
exit:
