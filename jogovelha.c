#include <stdio.h>
#include <stdbool.h> // utilizar o tipo booleano

bool valido(int escolha, char jogo[]);
void tabuleiro(char jogo[]);
void preenche(int escolha, char jogo[], char jogador);
bool fim(char jogo[], char jogador);

int main() 
{
    int escolha;
    char jogo[9] = {'1', '2', '3', '4', '5', '6', '7', '8', '9'};
    int j = 0;
    char jogador = 'X';

    do{
        tabuleiro(jogo);

        printf("Jogador %c Digite qual espaço voce deseja preencher: \n", jogador);
        scanf("%d",&escolha);

        if (escolha < 1 || escolha > 9) 
        {
            printf("numero inválido, tente novamente\n");
            continue;
        }

        if (!valido(escolha, jogo))
        {
            printf("Espaço ocupado, tente novamente\n");
            continue;
        }

        preenche(escolha, jogo, jogador);

        if (fim(jogo, jogador))
        {
            tabuleiro(jogo);
            printf("Fim de jogo!\nJogador %c venceu!", jogador);
            return 0;
        }
        j++;

        if (jogador == 'X')
        {
            jogador = 'O';
        } else 
        {
            jogador = 'X';
        }

    }while(j < 9);

    tabuleiro(jogo);
    printf("Fim de jogo!\nEmpate!\n");
    return 0;
}

void tabuleiro(char jogo[])
{
    printf(" %c | %c | %c \n", jogo[0], jogo[1], jogo[2]);
    printf("---+---+---\n");
    printf(" %c | %c | %c \n", jogo[3], jogo[4], jogo[5]);
    printf("---+---+---\n");
    printf(" %c | %c | %c \n", jogo[6], jogo[7], jogo[8]);
}

bool valido(int escolha, char jogo[])
{
    return jogo[escolha-1] == ('0' + escolha);
}

void preenche(int escolha, char jogo[], char jogador)
{
    jogo[escolha-1] = jogador;
}

bool fim(char jogo[], char jogador) 
{
    if (jogo[0] == jogador && jogo[1] == jogador && jogo[2] == jogador) return true;
    if (jogo[3] == jogador && jogo[4] == jogador && jogo[5] == jogador) return true;
    if (jogo[6] == jogador && jogo[7] == jogador && jogo[8] == jogador) return true;
    if (jogo[0] == jogador && jogo[3] == jogador && jogo[6] == jogador) return true;
    if (jogo[1] == jogador && jogo[4] == jogador && jogo[7] == jogador) return true;
    if (jogo[2] == jogador && jogo[5] == jogador && jogo[8] == jogador) return true;
    if (jogo[0] == jogador && jogo[4] == jogador && jogo[8] == jogador) return true;
    if (jogo[2] == jogador && jogo[4] == jogador && jogo[6] == jogador) return true;
    return false;
}