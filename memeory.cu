#include <iostream>
#include <cuda_runtime.h>
#include "memeory.h"

#define cudaCheckError()                                             \
    {                                                                \
        cudaError_t e = cudaGetLastError();                          \
        if (e != cudaSuccess)                                        \
        {                                                            \
            printf("Cuda failure %s:%d: '%s'\n", __FILE__, __LINE__, \
                   cudaGetErrorString(e));                           \
            exit(EXIT_FAILURE);                                      \
        }                                                            \
    }

// Global variable to control the execution
volatile bool stopExecution = false;

__global__ void delay(volatile int *flag,
                      unsigned long long timeout_clocks = 10000000)
{
    long long int start_clock, sample_clock;
    start_clock = clock64();

    while (true)
    {
        sample_clock = clock64();

        if (sample_clock - start_clock > timeout_clocks)
        {
            break;
        }
    }
}

// Function to occupy bandwidth between GPUs
int occupyBandwidth(int desDevice, int srcDevice, size_t bandwidthInBytesPerSecond)
{
    // Calculate number of bytes in miliseconds
    size_t bytesPerMs = bandwidthInBytesPerSecond / 1000;
    int *desBuffer, *srcBuffer;

    stopExecution = false;

    // Allocate memory
    if (desDevice < 0 && srcDevice < 0)
    {
        return -2;
    }

    if (desDevice < 0)
    {
        desBuffer = (int *)malloc(bytesPerMs)
    }
    else
    {
        cudaSetDevice(desDevice);
        cudaCheckError();
        cudaMalloc((void **)&desBuffer, bytesPerMs)
    }
    if (srcDevice < 0)
    {
        srcBuffer = (int *)malloc(bytesPerMs)
    }
    else
    {
        cudaSetDevice(srcDevice);
        cudaCheckError();
        cudaMalloc((void **)&srcBuffer, bytesPerMs)
    }

    // Create CUDA stream
    cudaStream_t stream;
    cudaEvent_t start, stop;

    cudaStreamCreate(&stream);
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    // Start the execution loop
    while (!stopExecution)
    {
        // Copy data from srcGPU to desGPU using cudaMemcpyPeerAsync
        cudaMemcpyPeerAsync(desGPU, 0, srcGPU, 0, numElements * sizeof(float), stream);

        // Synchronize the CUDA stream
        cudaStreamSynchronize(stream);
    }

    // Release allocated memory
    cudaFree(desGPU);
    cudaFree(srcGPU);

    // Destroy CUDA stream
    cudaStreamDestroy(stream);
}

int main()
{
    // Example usage
    float *desGPU;
    float *srcGPU;
    size_t bandwidthBytes = 1024 * 1024; // Example bandwidth of 1 MB

    // Start the function to occupy bandwidth
    occupyBandwidth(desGPU, srcGPU, bandwidthBytes);

    return 0;
}
