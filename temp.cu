#include <iostream>
#include <cuda_runtime.h>

#define NUM_STREAMS 3

__global__ void kernel(int *data, int stream_id)
{
    int tid = blockIdx.x * blockDim.x + threadIdx.x;
    data[tid] = stream_id;
}

int main()
{
    const int dataSize = 256;
    int *data;
    cudaMallocManaged(&data, dataSize * sizeof(int));

    cudaStream_t streams[NUM_STREAMS];
    for (int i = 0; i < NUM_STREAMS; i++)
        cudaStreamCreate(&streams[i]);

    cudaEvent_t event, event1;
    float timeInMs;

    cudaEventCreate(&event1);
    cudaEventCreate(&event);

    std::cout << "waiting for event" << std::endl;
    cudaEventSynchronize(event);
    cudaEventSynchronize(event1);
    std::cout << "event synchronized" << std::endl;

    cudaEventElapsedTime(&timeInMs, event1, event);
    std::cout << "time: " << timeInMs << std::endl;

    cudaStreamWaitEvent(streams[0], event);
    // Launch kernels on different streams
    for (int i = 0; i < NUM_STREAMS; i++)
    {
        kernel<<<1, dataSize, 0, streams[i]>>>(data, i);
    }
    cudaEventRecord(event, streams[1]);

    // Synchronize higher-level streams with lower-level streams
    cudaStreamSynchronize(streams[2]);
    cudaStreamSynchronize(streams[1]);

    // Print the results
    for (int i = 0; i < dataSize; i++)
    {
        std::cout << data[i] << " ";
    }
    std::cout << std::endl;

    // Cleanup
    cudaFree(data);
    for (int i = 0; i < NUM_STREAMS; i++)
        cudaStreamDestroy(streams[i]);

    return 0;
}
