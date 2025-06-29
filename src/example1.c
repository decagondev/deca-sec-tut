#include <stdio.h>
#include <string.h>

void main() {
    char buffer[32];
    printf("Enter input: ");
    gets(buffer);
    if (strcmp(buffer, "password") == 0) {
        printf("Success!\n");
    } else {
        printf("Failure.\n");
    }
}
