
#include <stdio.h>

int main() {
    printf("Optimized Three Address Code:\n");
    printf("i = 0\n");
    printf("sum = 0\n");
    printf("t1 = a * b\n");
    printf("L1: if (i >= n) goto L2\n");
    printf("sum = sum + t1\n");
    printf("i = i + 1\n");
    printf("goto L1\n");
    printf("L2:\n");

    return 0;
}
