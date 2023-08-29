#include <cuda_runtime.h>
#include <stdio.h>
#include <vector>

#define DATASIZE = 32000000
#define REPEATTIMES = 7

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

void memCopyP2P(int *des, int desDevice, int *src, int srcDevice,
                int dataSize, int repeat,
                cudaEvent_t start, cudaEvent_t stop,
                cudaStream_t stream);

void memCopyD2D(int *des, int *src, int dataSize, int repeat,
                cudaEvent_t start, cudaEvent_t stop,
                cudaStream_t stream);

void memCopyD2H();

void memCopyH2D();

void memCopy(int desDevice, int srcDevice, int dataSize, int repeat,
                cudaEvent_t start, cudaEvent_t stop,
                cudaStream_t stream);

int numGpus();

int main(int argc, char **argv)
{

}

void memCopyP2P(int *des, int desDevice, int *src, int srcDevice,
                int dataSize, int repeat,
                cudaEvent_t start, cudaEvent_t stop,
                cudaStream_t stream)
{
    cudaEventRecord(start, stream);
    cudaCheckError();
    for (int r = 0; r < repeat; r++)
    {
        cudaMemcpyPeerAsync(des, desDevice, src, srcDevice,
                            sizeof(int) * dataSize, stream);
        cudaCheckError();
    }
    cudaEventRecord(stop, stream);
    cudaCheckError();
}
