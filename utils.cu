#include <nvml.h>
#include "utils.h"

std::pair<unsigned int, unsigned int> getMemoryThroughput(int deviceId)
{
    nvmlReturn_t result;
    nvmlDevice_t device;
    unsigned int receiveKBytes, transmitKBytes;

    // Initialize NVML library
    result = nvmlInit();
    if (result != NVML_SUCCESS)
    {
        std::cerr << "Failed to initialize NVML library: " << nvmlErrorString(result) << std::endl;
        return {0, 0};
    }

    // Get the device handle
    result = nvmlDeviceGetHandleByIndex(deviceId, &device);
    if (result != NVML_SUCCESS)
    {
        std::cerr << "Failed to get device handle: " << nvmlErrorString(result) << std::endl;
        nvmlShutdown();
        return {0, 0};
    }

    // Get receive and transmit bytes
    result = nvmlDeviceGetPcieThroughput(device, NVML_PCIE_UTIL_RX_BYTES, &receiveKBytes);
    if (result != NVML_SUCCESS)
    {
        std::cerr << "Failed to get receive bytes: " << nvmlErrorString(result) << std::endl;
        nvmlShutdown();
        return {0, 0};
    }

    result = nvmlDeviceGetPcieThroughput(device, NVML_PCIE_UTIL_TX_BYTES, &transmitKBytes);
    if (result != NVML_SUCCESS)
    {
        std::cerr << "Failed to get transmit bytes: " << nvmlErrorString(result) << std::endl;
        nvmlShutdown();
        return {0, 0};
    }

    // Shutdown NVML library
    nvmlShutdown();

    return {receiveKBytes / 1000, transmitKBytes / 1000};
}
