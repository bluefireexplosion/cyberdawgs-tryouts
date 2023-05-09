#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <winsock2.h>
#include <ws2tcpip.h>
#include <time.h>

#pragma comment(lib, "ws2_32.lib")

int main() {
    WSADATA wsaData;
    int result;

    // Initialize Winsock
    result = WSAStartup(MAKEWORD(2, 2), &wsaData);
    if (result != 0) {
        printf("WSAStartup failed: %d\n", result);
        return 1;
    }

    while (1) {
        ADDRINFOA hints, *res;

        // Set up hints structure
        ZeroMemory(&hints, sizeof(hints));
        hints.ai_family = AF_UNSPEC;
        hints.ai_socktype = SOCK_DGRAM;
        hints.ai_protocol = IPPROTO_UDP;

        // Perform DNS lookup
        result = getaddrinfo("badguywebsitecyberdawgstryouts.org", NULL, &hints, &res);
        if (result != 0) {
            printf("getaddrinfo failed: %d\n", result);
            WSACleanup();
            return 1;
        }

        // Release memory
        freeaddrinfo(res);

        // Wait for 10 seconds before sending the next request
        Sleep(10000);
    }

    // Cleanup
    WSACleanup();
    return 0;
}
