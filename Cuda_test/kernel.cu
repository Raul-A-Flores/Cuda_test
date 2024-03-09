
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

// cuda kernel
__global__ void add(int* a, int* b, int* c) {

    int i = threadIdx.x + blockDim.x * blockIdx.x;

    c[i] = a[i] + b[i];


}


__managed__ int vector_a[256], vector_b[256], vector_c[256];

int main() {

    for (int i = 0; i < 256; i++) {

        vector_a[i] = i;
        vector_b[i] = 256 - i;
    }

    add <<< 1, 256 >>> (vector_a, vector_b, vector_c);

    cudaDeviceSynchronize();

    int result_sum = 0;

    for (int i = 0; i < 256; i++) {
        result_sum += vector_c[i];
    }

    printf("The result of these vectors \n");
    printf("Result: %d ", result_sum);
    return 0;
}