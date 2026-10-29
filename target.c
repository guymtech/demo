
#include <stdio.h>

int main() {
    printf("Target Code:\n");
    printf("MOV R1, #0\n");
    printf("MOV R2, #0\n");
    printf("MUL R3, a, b\n");
    printf("L1: CMP R1, n\n");
    printf("JGE L2\n");
    printf("ADD R2, R2, R3\n");
    printf("ADD R1, R1, #1\n");
    printf("JMP L1\n");
    printf("L2: HALT\n");

    return 0;
}
