//Edmond O Flynn 12304742 CS3D3 Assignment 1

using System;
using System.Net;
using System.Net.Sockets;
using System.Text;

public class SocketListener
{

    //incoming data from the client.
    public static string data = null;

    public static void StartListening()
    {
        //data buffer
        byte[] bytes = new Byte[1024];
        int port = 4547;

        // Create a TCP/IP socket.
        // Bind the socket to the local endpoint and 
        // listen for incoming connections.

        TcpListener serverSocket = new TcpListener(port);
        int reqCount = 0;
        TcpClient clientSocket = default(TcpClient);
        serverSocket.Start();
        try
        {
            while (true)
            {
                //increment request counter
                reqCount++;
                Console.WriteLine("req count: " + reqCount);
                Console.WriteLine("server initiated");
                //accept incoming connection
                clientSocket = serverSocket.AcceptTcpClient();
                Console.WriteLine("client connected");

                //buffer
                NetworkStream networkStream = clientSocket.GetStream();
                byte[] bytesFrom = new Byte[10025];

                //read in length of bytes to be received
                int bytesRead = networkStream.Read(bytesFrom, 0, bytesFrom.Length);
                Console.WriteLine("bytes received: " + bytesRead);

                //read in bytes to string
                if (bytesFrom.Length != 0)
                {
                    string dataFromClient = System.Text.Encoding.ASCII.GetString(bytesFrom);
                    dataFromClient = dataFromClient.Substring(0, bytesRead);
                    Console.WriteLine("data: " + dataFromClient);
                    string serverResponse = "data received: " + dataFromClient;

                    //write data received to a txt file 
                    System.IO.File.WriteAllText(@"C:\Users\Ed\Documents\Visual Studio 2013\Projects\CS3D3_proj1\Data\dataReceived.txt", dataFromClient);
                    //encode from string to bytes
                    Byte[] sendBytes = Encoding.ASCII.GetBytes(serverResponse);

                    //handle response and flush connection
                    networkStream.Write(sendBytes, 0, sendBytes.Length);
                    networkStream.Flush();
                    //write server response
                    Console.WriteLine("server response: " + "'" + serverResponse + "'");
                    Console.WriteLine("\n");
                }
                else if (bytesFrom.Length == 0)
                {
                    Console.WriteLine("empty string, received size: " + bytesFrom);
                }
                
            }
        }
        catch (Exception e)
        {
            Console.WriteLine(e.ToString());
        }

        Console.WriteLine("\nPress any button to end...");
        Console.Read();

    }

    public static int Main(String[] args)
    {
        StartListening();
        return 0;
    }
}