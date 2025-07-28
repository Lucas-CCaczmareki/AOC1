# Inicialização
# Carrega o valor desejado em $t1.
# Exemplo com o número 29, que em binário é 11101 (5 bits).

# Carrega o valor em t1
ori  $t1, $zero, 29              # $t1 = 29(11101).

# Inicia o contador de bits ($t2) em 0.
add  $t2, $zero, $zero           # $t2 = 0 + 0

# Contagem de bits
loop:
    # Condição de parada: se o número em $t1 for 0, o laço termina.
    beq  $t1, $zero, end_loop      # Pula para 'end_loop' se $t1 == 0
    
    # Desloca o número 1 bit para a direita
    # Isso manda o bit da direita pras cucuia e adiciona um zero na esquerda
    srl  $t1, $t1, 1               # $t1 = $t1 >> 1

    # Incrementa o contador de bits significativos.
    addi $t2, $t2, 1               # $t2 = $t2 + 1

    # Retorna ao início do laço.
    j    loop                      # Pula incondicionalmente para 'loop'

# Fim do programa
end_loop:
    # O resultado final já está armazenado em $t2