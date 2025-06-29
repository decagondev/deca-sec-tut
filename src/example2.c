#include <stdio.h>
#include <string.h>

int key = 0;

void win() {
    if (key == 0x1337) {
        printf("Success!\n");
    } else {
        printf("Failure: key=0x%x\n", key);
    }
}

void main() {
    char input[128];
    printf("Enter input: ");
    scanf("%127s", input);
    printf(input);
    printf("\n");
    win();
}
