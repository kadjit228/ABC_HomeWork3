#include <stdio.h>

float float_input() {
    float q;
    scanf("%f", &q);
    return q;
}

float multiply(float k, float x) {
    return k * x;
}

float abs_(float x) {
    if (x < 0) {
        return -x;
    }
    return x;
}
int main()
{
    float precision = float_input();
    precision = precision / 100;
    printf("X must be in (-1 ; 1)\n");
    float x = float_input();
    float real_number = 1 / (1 - x);
    float sum = 1;
    float k = 1;
    while (abs_(sum - real_number) > precision) {
        k = multiply(k, x);
        sum += k;
    }
    printf("%f \n", real_number);
    printf("%f", sum);

    return 0;
}
