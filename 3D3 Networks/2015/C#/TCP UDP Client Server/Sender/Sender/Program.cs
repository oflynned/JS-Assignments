//Edmond O Flynn 12304742 CS3D3 Assignment 1

using System;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Collections;

public class SocketClient
{
    public static void WriteTextFile()
    {
        var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        var stringChars = new char[1024];
        var random = new Random();

        for (int i = 0; i < stringChars.Length; i++)
        {
            stringChars[i] = chars[random.Next(chars.Length)];
        }

        var finalString = new String(stringChars);
        System.IO.File.WriteAllText(@"C:\Users\Ed\Documents\Visual Studio 2013\Projects\CS3D3_proj1\Data\dataSent.txt", finalString);
    }
    public static void StartClient()
    {
        //Data buffer for incoming data.
        byte[] bytes = new byte[1024];

        //Connect to a remote device.
        try
        {
            //Establish the remote endpoint for the socket.
            //Use IP Address and port
            int port;
            IPAddress ipAddress;

            Console.WriteLine("Input an IP address to connect to: ");
            ipAddress = IPAddress.Parse(Console.ReadLine());
            Console.WriteLine("Input a port to connect to: ");
            port = int.Parse(Console.ReadLine());

            IPHostEntry ipHostInfo = Dns.GetHostEntry(Dns.GetHostName());
            IPEndPoint remoteEP = new IPEndPoint(ipAddress, port);

            //Create a TCP/IP  socket.
            Socket sender = new Socket(AddressFamily.InterNetwork,
                SocketType.Stream, ProtocolType.Tcp);

            //Connect the socket to the remote endpoint. Catch any errors.
            try
            {
                sender.Connect(remoteEP);

                Console.WriteLine("socket connected to {0}",
                    sender.RemoteEndPoint.ToString());
                Console.WriteLine("connected to socket");

                //read in external text file to string
                //8 bits per byte ascii
                string text = System.IO.File.ReadAllText(@"C:\Users\Ed\Documents\Visual Studio 2013\Projects\CS3D3_proj1\Data\dataSent.txt");
                
                byte[] msg = Encoding.ASCII.GetBytes(text); //convert bytes to bits
                BitArray bitMsg = new BitArray(msg);  
                //append header and trailer [amount of bits + flag, 0, 0, 0, 0, 0, 0, 0, 0, crc + flag] header,blank 8 bits,trailer

                //debug length
                int len = bitMsg.Length;
                Console.WriteLine("bits to be sent: " + len);

                int byteLen = msg.Length;
                Console.WriteLine("bytes to be sent: " + byteLen);

                /*
                byte[] buffer = new byte[8]; //packet of 8 bytes per transmission
                byte[] _data = new byte[10]; //array for data with 1 packet each for header and trailer
                byte[] data = new byte[10];
                byte[] header = new byte[1]; //header of 1 byte
                byte[] trailer = new byte[1]; //trailer of 1 byte

                **attempt to include bit stuffing
                for (int k = 0; k <= msg.Length; k++) //number of data link layer packets to be transmitted
                {
                    for (int i = 0; i <= 8; i++) //1 byte length
                    {
                        for (int j = 0; j <= 1; j++) //8 bytes to be sent per packet
                        {
                            bool[] buffer = Encoding.ASCII.GetBytes(text);
                            if(buffer[0] = true && buffer[1] = true & buffer[2] = true & buffer[3] = true & buffer[4] = true)
                            {
                                buffer[5] = false;
                                //unbitstuff at server side
                            }
                        }
                    }
                    _data[k] = buffer[i,j];
                    
                    **attempt at gremlin function
                    static Random rnd = new Random();
                    static Random rndPacket = new Random();

                    int r = rnd.Next(_data.Count); //random bit to flip within array
                    int rP = rnd.Next(0,100); //50% chance of corrupted packet

                    if(rP >50)
                    {
                        if(_data[r] = true)
                        {
                        _data[r] = false;
                        }
                        else if (_data[r] = false)
                        {
                            _data[r] = true;
                        }
                    }
                }
                
                **shift data array right by 1
                for(int j=0;j<10;j++){
                    _data[(j+1)%msg.Length] = data[j];
                }

                **attempt to add add header and trailer
                //transmit 8 bytes per transmission and then append headers and trailers
                data[0] = (byte)len; //may need to include various info about mac address, source, destination ie unknown header length with flag
                data[9] = (byte)crc; //crc included with flag, may be used for padding if needed
               */
                
                //crc checksum, xor transmission with divisor, crc is remainder
                //cut off header and trailer on server side
                //check trailer with recalculated crc on server side, if both remainders are the same, the checksum is correct
                
                Console.WriteLine("encoded message to bytes");

                // Send the data through the socket.
                int bytesSent = sender.Send(msg);
                Console.WriteLine("sent to socket");

                // Receive the response from the remote device.
                int bytesRec = sender.Receive(bytes);
                Console.WriteLine("Echoed test = {0}",
                    Encoding.ASCII.GetString(bytes, 0, bytesRec));
                Console.WriteLine("received response from server");

                // Release the socket.
                Console.WriteLine("releasing socket and shutting down\n");
                sender.Shutdown(SocketShutdown.Both);
                sender.Close();

            }
            catch (ArgumentNullException ane)
            {
                Console.WriteLine("ArgumentNullException : {0}", ane.ToString());
            }
            catch (SocketException se)
            {
                Console.WriteLine("SocketException : {0}", se.ToString());
            }
            catch (Exception e)
            {
                Console.WriteLine("Unexpected exception : {0}", e.ToString());
            }

        }
        catch (Exception e)
        {
            Console.WriteLine(e.ToString());
        }
    }

    public static int Main(String[] args)
    {
        WriteTextFile();
        bool done = false;
        while (!done)
        {
            Console.WriteLine("Do you want to send a message?");
            string question = Console.ReadLine();
            switch (question)
            {
                case ("yes"):
                case ("y"):
                    StartClient();
                    break;

                case ("no"):
                case ("n"):
                    done = true;
                    break;
            }
        }
        return 0;
    }
}
