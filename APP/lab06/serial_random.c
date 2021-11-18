#include <stdio.h>
#include <stdlib.h>

int get_random (int seed) {
    int A = 2;
    int M = seed;
    int Q;
    int R;
    int number;
    int spoof_factor = 10;

	Q = M / A;
    R = M % A;

    for (int i = 0; i < spoof_factor; i++) {
        number = ( A * (number % Q)) -
            ( R * number / Q );

	    if (number < 0)
            number = number + M;        
    }

    return number;
}

int main () {
    printf ("%d\n", get_random(11383));
    return 0;
}
