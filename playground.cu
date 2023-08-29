#include <iostream>
#include "utils.h"

int main()
{
    int deviceId = 0; // Specify the device ID of the GPU you want to query
    auto throughput = getMemoryThroughput(deviceId);
    std::cout << "Receive Bytes: " << throughput.first << std::endl;
    std::cout << "Transmit Bytes: " << throughput.second << std::endl;

    return 0;
}
