//Esidor Pashaj --- Stud.No: 12302561 --- TokenRingGUI

#pragma once
#include <cstdlib> 
#include <iostream>
#include <sstream>
#include <Windows.h>

using namespace std;

namespace TokenRingGUI {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Collections::Generic;
	using namespace System::Windows::Forms;
	using namespace System::Windows;
	using namespace System::Data;
	using namespace System::Drawing;
	
	using namespace System;
	using namespace System::IO;
	using namespace System::Net;
	using namespace System::Net::Sockets;
	using namespace System::Text;
	using namespace System::Diagnostics;

	int leftPort;
	int rightPort;


	//Summary for Form1
	public ref class Form1 : public System::Windows::Forms::Form
	{
	public:
		Form1(void)
		{
			InitializeComponent();
		}

	protected:
		//Clean up any resources being used.
		~Form1()
		{
			if (components)
			{
				delete components;
			}
		}
	private: System::Windows::Forms::TextBox^  tbDataFrame;
	private: System::Windows::Forms::TextBox^  tbNodeNumber;

	private: System::Windows::Forms::Label^  lblNodeNumLabel;

	private: System::Windows::Forms::Label^  lblDataframe;
	private: System::Windows::Forms::Button^  btnSetNodeNumber;
	private: System::Windows::Forms::Label^  lblNodeNumber;
	private: System::Windows::Forms::CheckBox^  cbIsMonitor;

	private: System::Windows::Forms::Button^  btnStart;
	private: System::Windows::Forms::TextBox^  tbLog;
	private: System::Windows::Forms::Button^  btnSendToken;
	private: System::Windows::Forms::Button^  btnSendDataframe;
	private: System::Windows::Forms::Label^  lblNdNmbr;
	private: System::Windows::Forms::TextBox^  tbReceivedData;
	private: System::Windows::Forms::Label^  lblReceivedData;

	protected: 

	protected: 

	private:
		System::ComponentModel::Container ^components;

#pragma region Windows Form Designer generated code
		//Required method for Designer support to initalise everything used
		void InitializeComponent(void)
		{
			this->tbDataFrame = (gcnew System::Windows::Forms::TextBox());
			this->tbNodeNumber = (gcnew System::Windows::Forms::TextBox());
			this->lblNodeNumLabel = (gcnew System::Windows::Forms::Label());
			this->lblDataframe = (gcnew System::Windows::Forms::Label());
			this->btnSetNodeNumber = (gcnew System::Windows::Forms::Button());
			this->lblNodeNumber = (gcnew System::Windows::Forms::Label());
			this->cbIsMonitor = (gcnew System::Windows::Forms::CheckBox());
			this->btnStart = (gcnew System::Windows::Forms::Button());
			this->tbLog = (gcnew System::Windows::Forms::TextBox());
			this->btnSendToken = (gcnew System::Windows::Forms::Button());
			this->btnSendDataframe = (gcnew System::Windows::Forms::Button());
			this->lblNdNmbr = (gcnew System::Windows::Forms::Label());
			this->tbReceivedData = (gcnew System::Windows::Forms::TextBox());
			this->lblReceivedData = (gcnew System::Windows::Forms::Label());
			this->SuspendLayout();

			// tbDataFrame
			this->tbDataFrame->Location = System::Drawing::Point(110, 82);
			this->tbDataFrame->Margin = System::Windows::Forms::Padding(2);
			this->tbDataFrame->Name = L"tbDataFrame";
			this->tbDataFrame->Size = System::Drawing::Size(190, 20);
			this->tbDataFrame->TabIndex = 5;
			this->tbDataFrame->Text = L"Send something here..";

			// tbNodeNumber
			this->tbNodeNumber->Location = System::Drawing::Point(84, 21);
			this->tbNodeNumber->Margin = System::Windows::Forms::Padding(2);
			this->tbNodeNumber->Name = L"tbNodeNumber";
			this->tbNodeNumber->Size = System::Drawing::Size(19, 20);
			this->tbNodeNumber->TabIndex = 0;

			// lblNodeNumLabel
			this->lblNodeNumLabel->AutoSize = true;
			this->lblNodeNumLabel->Location = System::Drawing::Point(4, 24);
			this->lblNodeNumLabel->Margin = System::Windows::Forms::Padding(2, 0, 2, 0);
			this->lblNodeNumLabel->Name = L"lblNodeNumLabel";
			this->lblNodeNumLabel->Size = System::Drawing::Size(76, 13);
			this->lblNodeNumLabel->TabIndex = 50;
			this->lblNodeNumLabel->Text = L"Node Number:";

			// lblDataframe
			this->lblDataframe->AutoSize = true;
			this->lblDataframe->Location = System::Drawing::Point(11, 85);
			this->lblDataframe->Margin = System::Windows::Forms::Padding(2, 0, 2, 0);
			this->lblDataframe->Name = L"lblDataframe";
			this->lblDataframe->Size = System::Drawing::Size(97, 13);
			this->lblDataframe->TabIndex = 53;
			this->lblDataframe->Text = L"Dataframe to send:";

			// btnSetNodeNumber
			this->btnSetNodeNumber->Location = System::Drawing::Point(107, 13);
			this->btnSetNodeNumber->Margin = System::Windows::Forms::Padding(2);
			this->btnSetNodeNumber->Name = L"btnSetNodeNumber";
			this->btnSetNodeNumber->Size = System::Drawing::Size(67, 36);
			this->btnSetNodeNumber->TabIndex = 1;
			this->btnSetNodeNumber->Text = L"Set Node Number";
			this->btnSetNodeNumber->UseVisualStyleBackColor = true;
			this->btnSetNodeNumber->Click += gcnew System::EventHandler(this, &Form1::btnSetNodeNumber_Click);

			// lblNodeNumber
			this->lblNodeNumber->AutoSize = true;
			this->lblNodeNumber->Font = (gcnew System::Drawing::Font(L"Microsoft Sans Serif", 28.2F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point, 
				static_cast<System::Byte>(0)));
			this->lblNodeNumber->Location = System::Drawing::Point(255, 10);
			this->lblNodeNumber->Margin = System::Windows::Forms::Padding(2, 0, 2, 0);
			this->lblNodeNumber->Name = L"lblNodeNumber";
			this->lblNodeNumber->Size = System::Drawing::Size(0, 44);
			this->lblNodeNumber->TabIndex = 5;

			// cbIsMonitor
			this->cbIsMonitor->AutoSize = true;
			this->cbIsMonitor->Location = System::Drawing::Point(192, 162);
			this->cbIsMonitor->Margin = System::Windows::Forms::Padding(2);
			this->cbIsMonitor->Name = L"cbIsMonitor";
			this->cbIsMonitor->Size = System::Drawing::Size(108, 17);
			this->cbIsMonitor->TabIndex = 2;
			this->cbIsMonitor->Text = L"Select as Monitor";
			this->cbIsMonitor->UseVisualStyleBackColor = true;

			// btnStart
			this->btnStart->Enabled = false;
			this->btnStart->Location = System::Drawing::Point(14, 204);
			this->btnStart->Margin = System::Windows::Forms::Padding(2);
			this->btnStart->Name = L"btnStart";
			this->btnStart->Size = System::Drawing::Size(286, 33);
			this->btnStart->TabIndex = 3;
			this->btnStart->Text = L"Start Listening";
			this->btnStart->UseVisualStyleBackColor = true;
			this->btnStart->Click += gcnew System::EventHandler(this, &Form1::btnStart_Click);

			// tbLog
			// this is the box that displays the messages on the console ------------------------------------------------------------------------
			this->tbLog->Location = System::Drawing::Point(320, 13);
			this->tbLog->Margin = System::Windows::Forms::Padding(2);
			this->tbLog->Multiline = true;
			this->tbLog->Name = L"tbLog";
			this->tbLog->ReadOnly = true;
			this->tbLog->ScrollBars = System::Windows::Forms::ScrollBars::Vertical;
			this->tbLog->Size = System::Drawing::Size(309, 295);
			this->tbLog->TabIndex = 8;

			// btnSendToken
			this->btnSendToken->Enabled = false;
			this->btnSendToken->Location = System::Drawing::Point(14, 253);
			this->btnSendToken->Margin = System::Windows::Forms::Padding(2);
			this->btnSendToken->Name = L"btnSendToken";
			this->btnSendToken->Size = System::Drawing::Size(134, 36);
			this->btnSendToken->TabIndex = 4;
			this->btnSendToken->Text = L"Send Token";
			this->btnSendToken->UseVisualStyleBackColor = true;
			this->btnSendToken->Click += gcnew System::EventHandler(this, &Form1::btnSendToken_Click);

			// btnSendDataframe
			this->btnSendDataframe->Enabled = false;
			this->btnSendDataframe->Location = System::Drawing::Point(167, 253);
			this->btnSendDataframe->Margin = System::Windows::Forms::Padding(2);
			this->btnSendDataframe->Name = L"btnSendDataframe";
			this->btnSendDataframe->Size = System::Drawing::Size(133, 36);
			this->btnSendDataframe->TabIndex = 6;
			this->btnSendDataframe->Text = L"Send Dataframe";
			this->btnSendDataframe->UseVisualStyleBackColor = true;
			this->btnSendDataframe->Click += gcnew System::EventHandler(this, &Form1::btnSendDataframe_Click);

			// lblNdNmbr
			this->lblNdNmbr->AutoSize = true;
			this->lblNdNmbr->Location = System::Drawing::Point(178, 24);
			this->lblNdNmbr->Margin = System::Windows::Forms::Padding(2, 0, 2, 0);
			this->lblNdNmbr->Name = L"lblNdNmbr";
			this->lblNdNmbr->Size = System::Drawing::Size(76, 13);
			this->lblNdNmbr->TabIndex = 51;
			this->lblNdNmbr->Text = L"Node Number:";

			// tbReceivedData
			this->tbReceivedData->Location = System::Drawing::Point(97, 115);
			this->tbReceivedData->Margin = System::Windows::Forms::Padding(2);
			this->tbReceivedData->Name = L"tbReceivedData";
			this->tbReceivedData->Size = System::Drawing::Size(203, 20);
			this->tbReceivedData->TabIndex = 54;

			// lblReceivedData
			this->lblReceivedData->AutoSize = true;
			this->lblReceivedData->Location = System::Drawing::Point(11, 118);
			this->lblReceivedData->Margin = System::Windows::Forms::Padding(2, 0, 2, 0);
			this->lblReceivedData->Name = L"lblReceivedData";
			this->lblReceivedData->Size = System::Drawing::Size(82, 13);
			this->lblReceivedData->TabIndex = 55;
			this->lblReceivedData->Text = L"Received Data:";

			// Form1
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(641, 319);
			this->Controls->Add(this->lblReceivedData);
			this->Controls->Add(this->tbReceivedData);
			this->Controls->Add(this->lblNdNmbr);
			this->Controls->Add(this->btnSendDataframe);
			this->Controls->Add(this->btnSendToken);
			this->Controls->Add(this->tbLog);
			this->Controls->Add(this->btnStart);
			this->Controls->Add(this->cbIsMonitor);
			this->Controls->Add(this->lblNodeNumber);
			this->Controls->Add(this->btnSetNodeNumber);
			this->Controls->Add(this->lblDataframe);
			this->Controls->Add(this->lblNodeNumLabel);
			this->Controls->Add(this->tbNodeNumber);
			this->Controls->Add(this->tbDataFrame);
			this->Margin = System::Windows::Forms::Padding(2);
			this->Name = L"Form1";
			this->Text = L"Esidor's TokenRingGUI";
			this->ResumeLayout(false);
			this->PerformLayout();

		}
#pragma endregion

//This is function that sets the node number on the console
//this was taken from the internet and implemented to work with the rest of the code
private: System::Void btnSetNodeNumber_Click(System::Object^  sender, System::EventArgs^  e) {

			 int nodeNumber;
			 try
			 {
				 nodeNumber = System::Convert::ToInt32(this->tbNodeNumber->Text);
				 if (nodeNumber == 2 || nodeNumber == 3 || nodeNumber == 4 || nodeNumber == 5)
				 {
					 this->lblNodeNumber->Text = System::Convert::ToString(nodeNumber);
					 this->btnStart->Enabled = true;
					 this->btnSendToken->Enabled = true;
					 this->btnSendDataframe->Enabled = true;

				 } else {
					 //this is when the input is not between 2-5, basically to alert the user of invalid input
					 MessageBox::Show("INVALID INPUT!!! Node number must be between 2-5");
					 this->tbNodeNumber->Text = "";
				 }
				 this->tbNodeNumber->Text = "";
			 } catch(System::FormatException ^ e) {
				 //this is when the input is not between 2-5, basically to alert the user of invalid input
				 MessageBox::Show("INVALID INPUT!!! Node number must be between 2-5");
					 this->tbNodeNumber->Text = "";
			 }


		 }

private: System::Void btnStart_Click(System::Object^  sender, System::EventArgs^  e) {
			config();
 			this->tbReceivedData->Text = Listener(leftPort);
		}

//This is function that sends the token from one node to another
//this was taken from the internet and implemented to work with the rest of the code
private: System::Void btnSendToken_Click(System::Object^  sender, System::EventArgs^  e) {
			config();

			if(this->tbReceivedData->Text == "Token") // check for TOKEN
			{
				this->tbLog->Text += "Node: " + this->lblNodeNumber->Text +" Token received on port: " + leftPort + "\r\n";
				
			} else {
				//this is where the dataframes that were received are displayed on the console
				//this->tbLog->Text += "Data Frame received: " + "\r\n" + this->tbReceivedData->Text + "\r\n";
				}
			Connect(rightPort, "Token");
		 }
//This is function that send the dataframe from one node to another
//this was taken from the internet and implemented to work with the rest of the code
private: System::Void btnSendDataframe_Click(System::Object^  sender, System::EventArgs^  e) {
			config();
			if(this->tbReceivedData->Text == "Token") //check for token
			{
				this->tbLog->Text += "Node: " + this->lblNodeNumber->Text +" Token received on port!: " + leftPort + "\r\n";
				
			} else {
				//this is where the dataframes that were received are displayed on the console
				//this->tbLog->Text += "Data Frame received: " + "\r\n" + this->tbReceivedData->Text + "\r\n";
				}
			Connect(rightPort, this->tbDataFrame->Text);
		 }

private: void config()
		{
			Int32 nodeNumber;
			nodeNumber = System::Convert::ToInt32(this->lblNodeNumber->Text);
			 
			Debug::Flush();
			Debug::WriteLine(String::Concat("Start button pressed..."));
			Debug::WriteLine(String::Concat( this->tbNodeNumber->Text));
			if (this->cbIsMonitor->Checked) Debug::WriteLine(String::Concat("This node is now the Monitor!"));
			
			//if nodeNumber is 2, pass messages from Node2 to Node3
			if ( nodeNumber == 2 ) 
			{
				leftPort  = 22;
				rightPort = 333;
			}
			//if nodeNumber is 2, pass messages from Node3 to Node4
			if ( nodeNumber == 3 ) 
			{
				leftPort  = 333;
				rightPort = 4444;
			}
			//if nodeNumber is 2, pass messages from Node4 to Node5
			if ( nodeNumber == 4 ) 
			{
				leftPort  = 4444;
				rightPort = 55555;
			}
			//if nodeNumber is 2, pass messages from Node5 to Node2
			if ( nodeNumber == 5 ) 
			{
				leftPort  = 55555;
				rightPort = 22;
			}

		 }

		//This is the Listener function
		//this was taken from the internet and implemented to work with the rest of the code
		private: System::String^ Listener(Int32 port)
		{
		   try
		   {
				IPAddress^ localAddr = IPAddress::Parse( "127.0.0.1" );

				TcpListener^ server = gcnew TcpListener( localAddr,port );

				//this is where it starts listening for requests
				server->Start();

				//buffer for reading data 
				array<Byte>^bytes = gcnew array<Byte>(256);
				String^ data = nullptr;
				String^ dataUpper = nullptr;

			    //prepare to listen and wait until a conection is established
				this->tbLog->Text += "Waiting to connect..." + "\r\n";

				//perform a blocking call to accept requests. 
				TcpClient^ client = server->AcceptTcpClient();
				this->tbLog->Text += " " + "\r\n";
				this->tbLog->Text += "-----------------------------------" + "\r\n";
				this->tbLog->Text += "!!!!!!!Connected!!!!!!! " + "\r\n";
				this->tbLog->Text += "-----------------------------------" + "\r\n";
				this->tbLog->Text += " " + "\r\n";
				data = nullptr;

				//get a stream Object* for reading and writing
				NetworkStream^ stream = client->GetStream();
				Int32 i;

				//loop to receive all the data sent by the client. 
				while ( i = stream->Read( bytes, 0, bytes->Length ) )
				{

				this->tbLog->Text += "-----------------------------------------------------------------------------" + "\r\n";
				//translate data bytes to a ASCII String*.
				data = Encoding::ASCII->GetString( bytes, 0, i );
				this->tbLog->Text += "Received data from node: " + data + "\r\n";
				//process the data sent by the client.
				array<Byte>^msg = Encoding::ASCII->GetBytes( data );

				//just separating the two functions on the display
				this->tbLog->Text += "-----------------------------------------------------------------------------" + "\r\n";

				//send back a response.
				stream->Write( msg, 0, msg->Length );
				//to receive it in uppercase just change 'data' to 'dataUpper'
				//this is to send confirmation to the other node that the data is received
				this->tbLog->Text += "Confirmation of data sent: " + data + "\r\n";
				this->tbLog->Text += "-----------------------------------------------------------------------------" + "\r\n" + "\r\n";
				}

				//shutdown & end connection
				client->Close();
				server->Stop();
				return data;
		   }
		   catch ( SocketException^ e ) 
		   {
			  this->tbLog->Text += "Listener: SocketException: " + e  + "\r\n";
		   }

		} //end of Listener()


		private: System::Void Connect( Int32 port, String^ message )
		{
		   try
		   {
			  //Create a TcpClient. 
			  //Note, for this client to work you need to have a TcpServer  
			  //connected to the same address as specified by the server, port combination.
			  
			  String^ server = "127.0.0.1";
			  TcpClient^ client = gcnew TcpClient( server, port );

			  //translate the passed message into ASCII and store it as a Byte array. 
			  array<Byte>^data = Encoding::ASCII->GetBytes( message );

			  NetworkStream^ stream = client->GetStream();

			  //send the message to the connected TcpServer. 
			  stream->Write( data, 0, data->Length );

			  this->tbLog->Text += "Sent: " + message + "\r\n";

			  //buffer to store the response bytes.
			  data = gcnew array<Byte>(256);

			  //string to store the response ASCII representation.
			  String^ responseData = String::Empty;

			  //read the first batch of the TcpServer response bytes.
			  Int32 bytes = stream->Read( data, 0, data->Length );
			  responseData = Encoding::ASCII->GetString( data, 0, bytes );
			  this->tbLog->Text += "Received responce: " + responseData + "\r\n" + "\r\n";

			  //close everything in the end
			  client->Close();
			  stream->Close();
		   }
		   catch ( ArgumentNullException^ e ) 
		   {
			  this->tbLog->Text += "ArgumentNullException: " + e  + "\r\n";
		   }
		   catch ( SocketException^ e ) 
		   {
			  this->tbLog->Text += "SocketException: " + e  + "\r\n";
		   }
		} //end of Connect()
};
}

