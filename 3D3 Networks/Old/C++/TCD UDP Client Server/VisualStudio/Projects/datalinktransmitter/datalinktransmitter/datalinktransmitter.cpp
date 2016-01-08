//Esidor Pashaj -- 12302561

#define WIN32_LEAN_AND_MEAN

#include <windows.h>
#include <winsock2.h>
#include <ws2tcpip.h>
#include <stdlib.h>
#include <stdio.h>
#include <fstream>
#include <iostream>
#include <time.h>


// Need to link with Ws2_32.lib, Mswsock.lib, and Advapi32.lib
#pragma comment (lib, "Ws2_32.lib")
#pragma comment (lib, "Mswsock.lib")
#pragma comment (lib, "AdvApi32.lib")


#define DEFAULT_BUFLEN 10
#define DEFAULT_PORT "8888"

using namespace std;

// taken from the internet - src2
// the alorithm of calculating the 'checksum'
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

// wipes out control sum with the probability of 5%
char Gremlin(char data) 
{
 int num = 0;
 num = rand()%20; //spliiting it in 20 parts
 
 if (num == 1) {
	 data = ' ';
	 cout << endl << "*********************************************************************" << endl;
	 printf("Gremlin function is activated here...\n"); // the gremlin function
	 cout << "*********************************************************************" << endl << endl;
 }
 return data;   
}

int __cdecl main(int argc, char **argv) 
{
    WSADATA wsaData;
    SOCKET ConnectSocket = INVALID_SOCKET;
    struct addrinfo *result = NULL,
                    *ptr = NULL,
                    hints;
    char recvbuf[DEFAULT_BUFLEN];
    int iResult;
    int recvbuflen = DEFAULT_BUFLEN;
	char data[DEFAULT_BUFLEN];
	ifstream in; 
    char *message;
	char crc2char;
	bool confirmed = false;

	// this is the random generator activation
	srand((unsigned)time(0));

	// Open data file
	in.open("data_file.txt");
	if(in.fail()) 
    { 
		printf("Unable to open data_file.txt \n");
		return 1; 
    } 

	// Initialize Winsock - from internet
    iResult = WSAStartup(MAKEWORD(2,2), &wsaData);
    if (iResult != 0) {
        printf("WSAStartup failed with error: %d\n", iResult);
        return 1;
    }

    ZeroMemory( &hints, sizeof(hints) );
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = IPPROTO_TCP;

    // Resolve the server address and port -- add in unique ip -- local ip 127.0.0.1 
    iResult = getaddrinfo("10.6.76.111", DEFAULT_PORT, &hints, &result);
    if ( iResult != 0 ) {
        printf("Getaddrinfo failed - ERROR: %d\n", iResult);
        WSACleanup();
        return 1;
    }

    // Attempt to connect to an address until one succeeds - from internet
    for(ptr=result; ptr != NULL ;ptr=ptr->ai_next) {

        // Create a SOCKET for connecting to server
        ConnectSocket = socket(ptr->ai_family, ptr->ai_socktype, 
            ptr->ai_protocol);
		// checking if it's not the right socket and alerting us
        if (ConnectSocket == INVALID_SOCKET) {
            printf("Socket failed - ERROR: %ld\n", WSAGetLastError());
            WSACleanup();
            return 1;
        }

        // Connect to server
        iResult = connect( ConnectSocket, ptr->ai_addr, (int)ptr->ai_addrlen);
        if (iResult == SOCKET_ERROR) {
            closesocket(ConnectSocket);
            ConnectSocket = INVALID_SOCKET;
            continue;
        }
        break;
    }

    freeaddrinfo(result);
	// alerting us if socket is invalid, saying it cant connect
    if (ConnectSocket == INVALID_SOCKET) {
        printf("Unable to connect to server!\n");
        WSACleanup();
        return 1;
    }

	for(int j = 0; j < 128; j++)
	{
		data[0] = ' '; // header byte
		for(int i = 1; i < DEFAULT_BUFLEN-1; i++)
		{
			in>>data[i]; 	// read in the alphanumeric data into the buffer
		}
		//calculating crc, stored in the 10th byte -- crc converted to char
		crc2char = (char) crc16(reinterpret_cast<unsigned char*>(data), DEFAULT_BUFLEN-1);
		//loop starts here - runs and checks until it's true
		do {
			//pause it to go throught the steps step by step
			//system("PAUSE");
			confirmed = false; // drop the flag
			data[9] =  Gremlin(crc2char); // data written into the trailer; ugly gremlin steals the data randomly((
			printf("Dataframe to send: ", data);
			
			// Send the buffer
			iResult = send( ConnectSocket, data, DEFAULT_BUFLEN, 0 );
			if (iResult == SOCKET_ERROR) 
			{
				printf("Send failed with error: %d\n", WSAGetLastError());
				closesocket(ConnectSocket);
				WSACleanup();
				return 1;
			}
			//cut the rubbish while you display the data
			for(int i = 1; i < DEFAULT_BUFLEN-1; i++)
			{
				cout << data[i];
			}
			cout << endl;
			printf("Bytes sent to the receiver: %ld\n",iResult);
			cout << endl;

			//check the reply from receiver
			iResult = recv(ConnectSocket, recvbuf, recvbuflen, 0);
			//if data frame is corrupted by gremlin, we request from the receiver to re-send the frame
			if ( iResult > 0 ) {

				printf("Bytes received from the receiver: %d\n", iResult);
				if ( recvbuf[0] == '0' && recvbuf[1] == '0' && recvbuf[2] == '0' && recvbuf[3] == '0' && recvbuf[4] == '0' &&
					 recvbuf[5] == '0' && recvbuf[6] == '0' && recvbuf[7] == '0' && recvbuf[8] == '0' && recvbuf[9] == '0')
				{
					cout << endl;
					cout << "------------------------------------------------------" << endl;
					printf("Request from the receiver to re-send the frame... \n");
					cout << "------------------------------------------------------" << endl;
					cout << endl;
				} else
					confirmed = true;
			
			} else if ( iResult == 0 ) {
				printf("Connection closed\n");
				break;
			} else {
				printf("Receiver failed - ERROR: %d\n", WSAGetLastError());
				break;
			}

		} 
		
		while( !confirmed );


	}
	//closing the file
	in.close();

    //shutdown the connection since no more data will be sent - from internet
    iResult = shutdown(ConnectSocket, SD_SEND);
    if (iResult == SOCKET_ERROR) {
        printf("Shutdown failed - ERROR: %d\n", WSAGetLastError());
        closesocket(ConnectSocket);
        WSACleanup();
        return 1;
    }

    // Receive until the peer closes the connection
    do {

        iResult = recv(ConnectSocket, recvbuf, recvbuflen, 0);
        if ( iResult > 0 )
            printf("Bytes received from the transmitter: %d\n", iResult);
        else if ( iResult == 0 )
            printf("Connection closed\n");
        else
            printf("Receiver failed - ERROR: %d\n", WSAGetLastError());

    } 
	
	while( iResult > 0 );

    // cleanup everything
    closesocket(ConnectSocket);
    WSACleanup();
	cout << endl;
	system("PAUSE");
    return 0;
}
