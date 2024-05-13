#include <stdio.h>
#include <stdlib.h>

// Definirea unei structuri pentru stivă
typedef struct {
    char *data;
    int top;
    int capacity;
} Stack;

// Funcție pentru inițializarea stivei
Stack* createStack(int capacity) {
    Stack *stack = (Stack*)malloc(sizeof(Stack));
    stack->capacity = capacity;
    stack->top = -1;
    stack->data = (char*)malloc(stack->capacity * sizeof(char));
    return stack;
}

// Funcție pentru a verifica dacă stiva este goală
int isEmpty(Stack *stack) {
    return stack->top == -1;
}

// Funcție pentru a adăuga un element în stivă
void push(Stack *stack, char item) {
    if (stack->top == stack->capacity - 1) {
        printf("Stiva este plina.\n");
        return;
    }
    stack->data[++stack->top] = item;
}

// Funcție pentru a elimina un element din stivă
char pop(Stack *stack) {
    if (isEmpty(stack)) {
        printf("Stiva este goala.\n");
        return '\0';
    }
    return stack->data[stack->top--];
}

// Funcție pentru a verifica parantezarea corectă
int checkParentheses(char *str) {
    Stack *stack = createStack(100); // presupunem o lungime maximă a șirului de 100 de caractere

    for (int i = 0; str[i] != '\0'; i++) {
        if (str[i] == '(' || str[i] == '{' || str[i] == '[') {
            push(stack, str[i]);
        } else if (str[i] == ')' || str[i] == '}' || str[i] == ']') {
            if (isEmpty(stack)) {
                free(stack->data);
                free(stack);
                return 1; // parantezele sunt închise greșit
            }

            char top = pop(stack);
            if ((str[i] == ')' && top != '(') ||
                (str[i] == '}' && top != '{') ||
                (str[i] == ']' && top != '[')) {
                free(stack->data);
                free(stack);
                return 1; // parantezele sunt închise greșit
            }
        }
    }

    if (!isEmpty(stack)) {
        free(stack->data);
        free(stack);
        return 1; // parantezele sunt închise greșit
    }

    free(stack->data);
    free(stack);
    return 0; // parantezele sunt corect parantezate
}

int main() {
    char str[100];
    printf("Introduceti sirul de paranteze: ");
    scanf("%s", str);

    if (checkParentheses(str)) {
        printf("Parantezele nu sunt parantezate corect.\n");
    } else {
        printf("Parantezele sunt parantezate corect.\n");
    }

    return 0;
}
