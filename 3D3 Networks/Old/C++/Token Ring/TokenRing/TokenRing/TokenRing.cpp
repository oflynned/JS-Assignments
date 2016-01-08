//Esidor Pashaj --- Stud.No: 12302561 --- TokenRing

#undef UNICODE

#define WIN32_LEAN_AND_MEAN

#include <iostream>
#include <windows.h>
#include <winsock2.h>
#include <ws2tcpip.h>
#include <stdlib.h>
#include <stdio.h>
#include <fstream>
#include <typeinfo>  
#include <cstdlib>
#include <time.h>

// Need to link with Ws2_32.lib, Mswsock.lib, and Advapi32.lib
#pragma comment (lib, "Ws2_32.lib")
#pragma comment (lib, "Mswsock.lib")
#pragma comment (lib, "AdvApi32.lib")

#define DEFAULT_BUFLEN 10
#define TOKEN "T" //token

using namespace std;


	WSADATA wsaData;
    SOCKET ConnectSocket = INVALID_SOCKET;
    SOCKET ConnectSocket1 = INVALID_SOCKET;
    SOCKET ClientSocket = INVALID_SOCKET;
    SOCKET ListenSocket = INVALID_SOCKET;

	char recvdata[DEFAULT_BUFLEN-1];

    struct addrinfo *resultIn = NULL,
                    *ptrIn = NULL,
                    hintsIn;

	struct addrinfo *resultOut = NULL,
                    *ptrOut = NULL,
                    hintsOut;

    char recvbuf[DEFAULT_BUFLEN];

    int recvbuflen = DEFAULT_BUFLEN;
	char data[DEFAULT_BUFLEN];
	 string leftPort;
	 string rightPort;
	 string nextRightPort;

	char inputMonitor;
	bool isMonitor = false; 
	bool isGetAddrRan = false; 
	int paramint ;
	int iResult;
	int iSendResult;


int serverListen()
{
	//Initialize Winsock -- taken from project1
    iResult = WSAStartup(MAKEWORD(2,2), &wsaData);
    if (iResult != 0) {
        printf("WSAStartup failed with error: %d\n", iResult);
		system("Pause");
        return 1;
    }

    ZeroMemory(&hintsIn, sizeof(hintsIn));
    hintsIn.ai_family = AF_INET;
    hintsIn.ai_socktype = SOCK_STREAM;
    hintsIn.ai_protocol = IPPROTO_TCP;

    //Resolve the server address and port -- taken from project1
	iResult = getaddrinfo("127.0.0.1", leftPort.c_str(), &hintsIn, &resultIn);
    if ( iResult != 0 ) {
		//precautions is the Getaddrinfo funct doesn't work
        printf("Getaddrinfo failed - error: %d\n", iResult);
        WSACleanup();
        return 1;
    }
	
    //Create a SOCKET for connecting to server -- taken from project1
    ListenSocket = socket(resultIn->ai_family, resultIn->ai_socktype, resultIn->ai_protocol);
    if (ListenSocket == INVALID_SOCKET) {
		//precautions is the sockets don't work
        printf("Socket failed - error: %ld\n", WSAGetLastError());
        freeaddrinfo(resultIn);
        WSACleanup();
        return 1;
    }

    //Setup the TCP listening socket -- taken from project1
    iResult = bind( ListenSocket, resultIn->ai_addr, (int)resultIn->ai_addrlen);
    if (iResult == SOCKET_ERROR) {
		//precautions is the Bind funct doesn't work
        printf("Bind failed - error: %d\n", WSAGetLastError());
        freeaddrinfo(resultIn);
        closesocket(ListenSocket);
        WSACleanup();
        return 1;
    }

    freeaddrinfo(resultIn);
	//precautions is the Listen funct doesn't work 
    iResult = listen(ListenSocket, SOMAXCONN);
    if (iResult == SOCKET_ERROR) {
        printf("Listen failed - error: %d\n", WSAGetLastError());
        closesocket(ListenSocket);
        WSACleanup();
        return 1;
    }

    //Accept a client socket -- taken from project1
    ClientSocket = accept(ListenSocket, NULL, NULL);
    if (ClientSocket == INVALID_SOCKET) {
        printf("Accept failed - error: %d\n", WSAGetLastError());
        closesocket(ListenSocket);
        WSACleanup();
        return 1;
    }

    //Receive data until the peer shuts down the connection -- taken from project1
    do {
		iResult = recv(ClientSocket, recvbuf, recvbuflen, 0);
        if (iResult > 0) {
            printf("Bytes Received: %d\n", iResult);
        }
        else if (iResult == 0)
            printf("Connection is now closing!!\n"); 
			
        else  {
            printf("Recv failed - error: %d\n", WSAGetLastError());
            closesocket(ClientSocket);
            WSACleanup();
            return 1;
        }
		cout << endl;
    } while (iResult > 0);

    //shutdown the connection since we're done -- taken from project1
    iResult = shutdown(ClientSocket, SD_SEND);
    if (iResult == SOCKET_ERROR) {
		//precautions is the sockets don't work
        printf("Shutdown failed - error: %d\n", WSAGetLastError());
        closesocket(ClientSocket);
        WSACleanup();
        return 1;
    }
	
	closesocket(ClientSocket);
	WSACleanup();
}

int connect2Server()
{
	
	//Initialize Winsock -- taken from project1
    iResult = WSAStartup(MAKEWORD(2,2), &wsaData);
    if (iResult != 0) {
        printf("WSAStartup failed - error: %d\n", iResult);
		system("Pause");
        return 1;
    }

    ZeroMemory( &hintsOut, sizeof(hintsOut) );
    hintsOut.ai_family = AF_UNSPEC;
    hintsOut.ai_socktype = SOCK_STREAM;
    hintsOut.ai_protocol = IPPROTO_TCP;
	hintsOut.ai_flags = AI_PASSIVE;

 	//Resolve the server address and port -- taken from project1
	iResult = getaddrinfo("127.0.0.1", rightPort.c_str(), &hintsOut, &resultOut);
	if ( iResult != 0 ) {
		printf("Getaddrinfo failed - error: %d\n", iResult);
		system("Pause");
		WSACleanup();
		return 1;
	}

	//Attempt to connect to an address until one succeeds
	for(ptrOut=resultOut; ptrOut != NULL ;ptrOut=ptrOut->ai_next) {
		
		// Create a SOCKET for connecting to server -- taken from project1
		ConnectSocket = socket(ptrOut->ai_family, ptrOut->ai_socktype, 
			ptrOut->ai_protocol);
		//line below used to debug -- to see which socket it is
		// cout<<"ConnectSocket "<< ConnectSocket <<  endl;
		if (ConnectSocket == INVALID_SOCKET) {
			printf("Socket failed - error: %ld\n", WSAGetLastError());
			system("Pause");
			WSACleanup();
			return 1;
		}
		
		//Connect to server -- taken from project1
		iResult = connect( ConnectSocket, ptrOut->ai_addr, (int)ptrOut->ai_addrlen);
		if (iResult == SOCKET_ERROR) {
			closesocket(ConnectSocket);
			ConnectSocket = INVALID_SOCKET;
			continue;
		}
		break;
	}

	freeaddrinfo(resultOut);
	//taken from project1			
	if (ConnectSocket == INVALID_SOCKET) {
		cout << endl;
		printf("Unable to connect to server!\n");
		system("Pause");
		WSACleanup();
		return 1;
	}

	cout << endl;
	//printf("Dataframe to send: "); 
			
	//Send the buffer -- taken from project1
	iResult = send( ConnectSocket, TOKEN, DEFAULT_BUFLEN, 0 );
	if (iResult == SOCKET_ERROR) 
	{
		printf("Send failed - error: %d\n", WSAGetLastError());
		system("Pause");
		closesocket(ConnectSocket);
		WSACleanup();
		return 1;
	}
	for(int i = 1; i < DEFAULT_BUFLEN-1; i++) // cutting off the rubbish
	{
		 cout<<data[i]; 
	}
	printf("\nBytes Sent: %ld\n",iResult);
	
	//shutdown the connection since no more data will be sent
    iResult = shutdown(ConnectSocket, SD_SEND);

	//this is a precaution if the sockets dont work for some reason
	//just alerts the user that they are not functioning because of some error
    if (iResult == SOCKET_ERROR) {
        printf("Shutdown failed - error: %d\n", WSAGetLastError());
        closesocket(ConnectSocket);
        WSACleanup();
        return 1;
    }

    //cleanup in the end
    closesocket(ConnectSocket);
	WSACleanup();

}


int __cdecl main() 
{
	//input is required here to give the node a number between 2-5
	cout << "Enter a Node number between 2-5: ";
	cin >> paramint;
	cout << endl;

	if ( paramint == 2 ) 
	{
		cout << "-------------------" << endl;
		cout << "This is now Node 2!" << endl;
		cout << "-------------------" << endl;

		leftPort  = "22";
		rightPort = "333";
	}
	if ( paramint == 3 ) 
	{
		cout << "-------------------" << endl;
		cout << "This is now Node 3!" << endl;
		cout << "-------------------" << endl;

		leftPort  = "333";
		rightPort = "4444";
	}
	if ( paramint == 4 ) 
	{
		cout << "-------------------" << endl;
		cout << "This is now Node 4!" << endl;
		cout << "-------------------" << endl;

		leftPort  = "4444";
		rightPort = "55555";
	}
	if ( paramint == 5 ) 
	{
		cout << "-------------------" << endl;
		cout << "This is now Node 5!" << endl;
		cout << "-------------------" << endl;

		leftPort  = "55555";
		rightPort = "22";
	}

	//while loop to make sure user doesn't enter an invalid input
	while ( paramint != 2 && paramint != 3 && paramint != 4 && paramint != 5 )  
	{
		cout << "Number not betwen the range of 2-5!! Enter the node number again: ";
		cin >> paramint;
		cout << endl;

		if ( paramint == 2 ) 
		{
			cout << "-------------------" << endl;
			cout << "This is now Node 2!" << endl;
			cout << "-------------------" << endl;

			leftPort  = "22";
			rightPort = "333";
		}
		else if ( paramint == 3 ) 
		{
			cout << "-------------------" << endl;
			cout << "This is now Node 3!" << endl;
			cout << "-------------------" << endl;

			leftPort  = "333";
			rightPort = "4444";
		}
		else if ( paramint == 4 ) 
		{
			cout << "-------------------" << endl;
			cout << "This is now Node 4!" << endl;
			cout << "-------------------" << endl;

			leftPort  = "4444";
			rightPort = "55555";
		}
		else if ( paramint == 5 ) 
		{
			cout << "-------------------" << endl;
			cout << "This is now Node 5!" << endl;
			cout << "-------------------" << endl;

			leftPort  = "55555";
			rightPort = "22";
		}
	}

	cout << endl;
	cout << "Type 'yes' if you want to make this Node a Monitor...or 'no' to not make it: ";
	cin >> inputMonitor;
	cout << endl;

	//input is required here to make the node a Monitor or not
	if( inputMonitor == 'y')
	{
		isMonitor = true;
		cout << "-----------------------------------------" << endl;
		cout << "This Node has been chosen as the Monitor!" << endl;
		cout << "-----------------------------------------" << endl;
	}
	else if ( inputMonitor == 'n')
	{
		cout << "---------------------------" << endl;
		cout << "This Node is NOT a Monitor!"<< endl;
		cout << "---------------------------" << endl << endl;
	}

	//while loop to make sure user doesn't enter an invalid input
	while ( inputMonitor != 'y' && inputMonitor != 'n' )
	{
		cout << "Invalid input!! Enter either 'y' or 'n': ";
		cin >> inputMonitor;
		cout << endl;

		if ( inputMonitor == 'n')
		{
			isMonitor = false;
			cout << "---------------------------" << endl;
			cout << "This Node is NOT a Monitor!"<< endl;
			cout << "---------------------------" << endl << endl;
			break;
		}
		else if( inputMonitor == 'y')
		{
			isMonitor = true;
			cout << "This Node has been chosen as the Monitor!"<< endl << endl;
		}
		
	}

	//if the node is a monitor, connect to server and listen 
 	if (isMonitor) connect2Server();
	serverListen();
	
	//main loop
    do {
        //cout << "recvbuf[0] - " << recvbuf[0] << endl << endl;

		if(recvbuf[0] == 'T') //check for token
		{
			if (isMonitor) {
				cout << "----------------";
				cout << endl << "Token received!!" << endl << "----------------" << endl ;
				cout << "---------------------------" << endl;
				cout << "DataFrame received: ";
				
				//generate random letters to show that you're sending a dataframe
				for(int i = 0;  i < 7; i++)
				{
					cout << static_cast <char> ((rand()%26)+65);
				}

				cout << endl << "---------------------------" << endl;
				cout << "---------------------------------" << endl;
				cout << "Dataframe sent to the next Node!!" << endl;
				cout << "---------------------------------" << endl << endl;

			}
			system("Pause");
		} 
		else 
		{
			if (isMonitor)  cout << "Dataframe received!!"<<  endl;
		}
		connect2Server();
		serverListen();

    } while (true);

    //shutdown the connection since we're done
    iResult = shutdown(ClientSocket, SD_SEND);

	//this is a precaution if the sockets dont work for some reason
	//just alerts the user that they are not functioning because of some error
    if (iResult == SOCKET_ERROR) {
        printf("Shutdown failed - error: %d\n", WSAGetLastError());
        closesocket(ClientSocket);
        WSACleanup();
        return 1;
    }
		
    //cleanup in the end
    closesocket(ClientSocket);
    WSACleanup();

    return 0;
}