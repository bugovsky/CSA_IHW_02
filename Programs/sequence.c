#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void input(char *str) {
    int counter = 0;
    int current_char;
    do {
        current_char = fgetc(stdin);
        str[counter] = current_char;
        ++counter;
    } while(current_char != EOF && counter < 100000);
    str[counter - 1] = '\0';
}

void GetSequence(char *input, char *sequence, int input_size, int sequence_size) {
    int end_index = -1;
    int start_index = -1;
    int current_index = 0;
    for (int i = input_size - 1; i > 0; --i) {
        if (end_index == -1) {
            end_index = i;
            start_index = i;
        }
        if (end_index - start_index + 1 == sequence_size) {
            break;
        }
        if (input[i] > input[i - 1]) {
            start_index = i - 1;
        } else {
            end_index = -1;
            start_index = -1;
        }
    }
    if (end_index - start_index + 1 < sequence_size) {
        printf("There is no sequence with size = %d\n", sequence_size);
        sequence[0] = '\0';
    } else {
        for (int i = start_index; i <= end_index; ++i) {
            sequence[current_index] = input[i];
            ++current_index;
        }
        sequence[current_index] = '\0';
    }
}

void output(char *str) {
    int current_index = 0;
    while (str[current_index] != '\0') {
        putchar(str[current_index]);
        ++current_index;
    }
    printf("\n");
}

int main() {
    int n;
    scanf("%d", &n);
    char *input_str = malloc(100000 * sizeof(char));
    input(input_str);
    int input_size = strlen(input_str);
    char *sequence = malloc((n + 1) * sizeof(char));
    if (n <=0 || n > input_size) {
        printf("Incorrect size\n");
    } else {
        GetSequence(input_str, sequence, input_size, n);
        if (strlen(sequence) > 0) {
        printf("Sequence:");
        output(sequence);
        }
    }
    free(input_str);
    free(sequence);
    return 0;
}
