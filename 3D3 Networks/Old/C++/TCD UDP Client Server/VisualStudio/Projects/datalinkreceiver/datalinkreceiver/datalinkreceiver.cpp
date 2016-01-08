//Esidor Pashaj -- 12302561

#undef UNICODE

#define WIN32_LEAN_AND_MEAN

#include <iostream>
#include <windows.h>
#include <winsock2.h>
#include <ws2tcpip.h>
#include <stdlib.h>
#include <stdio.h>
#include <fstream>

// Need to link with Ws2_32.lib
#pragma comment (lib, "Ws2_32.lib")

#define DEFAULT_BUFLEN 10
#define DEFAULT_PORT "8888"

using namespace std;

// taken from the int src2
// alorithm of calculating the 'checksum'
unsigned short crc16(unsigned char* data_p, unsigned char length){
    unsigned char x;
    unsigned short crc = 0xFFFF;

    while (length--){
        x = crc >> 8 ^ *data_p++;
        x ^= x>>4;
        crc = (crc << 8) ^ ((unsigned short)(x << 12)) ^ ((unsigned short)(x <<5)) ^ ((unsigned short)x);
    }
    return crc;
}

// Main body of the receiver
int __cdecl main(void) 
{
    WSADATA wsaData;
    int iResult;

    SOCKET ListenSocket = INVALID_SOCKET;
    SOCKET ClientSocket = INVALID_SOCKET;

    struct addrinfo *result = NULL;
    struct addrinfo hints;

    int iSendResult;
    char recvbuf[DEFAULT_BUFLEN];
    int recvbuflen = DEFAULT_BUFLEN;
    char recvdata[DEFAULT_BUFLEN-1];
	char crc2char;
	    
    // Initializing Winsock
    iResult = WSAStartup(MAKEWORD(2,2), &wsaData);
    if (iResult != 0) {
        printf("WSAStartup failed with error: %d\n", iResult);
        return 1;
    }

    ZeroMemory(&hints, sizeof(hints));
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = IPPROTO_TCP;
    hints.ai_flags = AI_PASSIVE;

    // Resolve the server address and port
    iResult = getaddrinfo(NULL, DEFAULT_PORT, &hints, &result);
    if ( iResult != 0 ) {
        printf("Getaddrinfo failed - ERROR: %d\n", iResult);
        WSACleanup();
        return 1;
    }

    // Create a SOCKET for connecting to server
    ListenSocket = socket(result->ai_family, result->ai_socktype, result->ai_protocol);
    if (ListenSocket == INVALID_SOCKET) {
        printf("Socket failed - ERROR: %ld\n", WSAGetLastError());
        freeaddrinfo(result);
        WSACleanup();
        return 1;
    }

    // Setup the TCP listening socket
    iResult = bind( ListenSocket, result->ai_addr, (int)result->ai_addrlen);
    if (iResult == SOCKET_ERROR) {
        printf("Failed to bind to the server - ERROR: %d\n", WSAGetLastError());//binding to the server/receiver
        freeaddrinfo(result);
        closesocket(ListenSocket);
        WSACleanup();
        return 1;
    }

    freeaddrinfo(result);

    iResult = listen(ListenSocket, SOMAXCONN);
    if (iResult == SOCKET_ERROR) {
        printf("Failed to listen - ERROR: %d\n", WSAGetLastError());
        closesocket(ListenSocket);
        WSACleanup();
        return 1;
    }

    // Accept a client socket
    ClientSocket = accept(ListenSocket, NULL, NULL);
    if (ClientSocket == INVALID_SOCKET) {
        printf("Failed to connect to socket - ERROR: %d\n", WSAGetLastError());
        closesocket(ListenSocket);
        WSACleanup();
        return 1;
    }

    // No longer need server socket
    closesocket(ListenSocket);

	ofstream out; 
	out.open("receivedData.txt");
	if(out.fail()) { 
		printf("Unable to open receivedData.txt\n");
		return 1; 
	}

    // Receive until the peer shuts down the connection
    do {
		
		iResult = recv(ClientSocket, recvbuf, recvbuflen, 0);
        if (iResult > 0) {
            printf("Bytes received from the transmitter: %d\n", iResult);
			// put a break here to go through each step 1 by 1...(128 steps)
			//cout << endl;
			for(int i = 0; i < DEFAULT_BUFLEN-1; i++)
			{
				recvdata[i] = recvbuf[i];
			}
			printf("Dataframe to send: ");
			// here we are calculating the crc
			crc2char = (char) crc16(reinterpret_cast<unsigned char*>(recvdata), DEFAULT_BUFLEN-1);
			// checking to the last byte of data frame (trailer)
			if (recvbuf[9] == crc2char) {
				// received the correct data frame - confirmed by CRC calculation
				for(int i = 1; i < DEFAULT_BUFLEN-1; i++) 
				{
					out<<recvdata[i]; // write frame data byte by byte into the output file stream
					cout<<recvdata[i]; // and console
				}
				// Echo the buffer back to the sender
				iSendResult = send( ClientSocket, recvbuf, iResult, 0 );
				if (iSendResult == SOCKET_ERROR) {
					printf("Send failed - ERROR: %d\n", WSAGetLastError());
					closesocket(ClientSocket);
					WSACleanup();
					return 1;
				}
				cout << endl;
				printf("Bytes sent to the transmitter: %d\n", iSendResult);
				cout << endl;
			} 
			
			else { // received incorrect data within the frame: CRC calculation failed
				cout << "|||CORRUPTION|||" << endl << endl;
				cout << "------------------------------------------------------" << endl;
				printf("Requesting from the transmitter to resend the frame...\n");
				cout << "------------------------------------------------------" << endl << endl;
				// Request to resend the frame in two steps:
				// 1. Populating buffer with zeros (a negative acknowledgement)
				for(int i = 0; i < DEFAULT_BUFLEN; i++)
				{
					recvbuf[i] = '0';
				}
				// 2. Sending the buffer with the negative acknowledgement (zeros) back to sender
				iSendResult = send( ClientSocket, recvbuf, iResult, 0 );
				if (iSendResult == SOCKET_ERROR) {
					printf("Send failed - ERROR: %d\n", WSAGetLastError());
					closesocket(ClientSocket);
					WSACleanup();
					return 1;
				}
			}

 
        }

        else if (iResult == 0)
            printf("Connection closing...\n");
        else  {
            printf("Recv failed - ERROR: %d\n", WSAGetLastError());
            closesocket(ClientSocket);
            WSACleanup();
            return 1;
        }
		

    } // the end of do
	
	while (iResult > 0);

    // shutdown the connection since we're done
    iResult = shutdown(ClientSocket, SD_SEND);
    if (iResult == SOCKET_ERROR) {
        printf("Shutdown failed - ERROR: %d\n", WSAGetLastError());
        closesocket(ClientSocket);
        WSACleanup();
        return 1;
    }
	
	out.close();
    // cleanup
    closesocket(ClientSocket);
    WSACleanup();

	system("PAUSE");

    return 0;

}