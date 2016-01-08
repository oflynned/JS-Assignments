Protocol description
********************

1.Message from transmitter to receiver.

The frame is 10 bytes long.
Consists from
- header: 1 byte (always a space - " ")
- data frame: 8 bytes of data
- trailer: 1 byte of checksum (using CRC-CCIT-16 algorithm) converted into char.

2.Message from Receiver to transmitter.

If the message consists from "0" characters: "0000000000", that means the receiver requests 
to repeat transfer of the frame again - NEGATIVE ACKNOWLEDGEMENT.
Any other text message treated as positive - ACKNOWLEDGEMENT.


Implementation description
**************************
The project consists from three executable files: 
1. data file creator
2. transmitter
3. receiver

A program which creates a randomly populated ASCII data file containing 1024 alphanumeric characters implemented.
The receiver application (based on [1]) starts first and waits for a connection.
Transmitter application  (based on [1]) connects to the receiver, opens a data file, reads it in by chunks of 8 bytes.
Data bytes are wrapped into header (always ' ' charachter) and trailer which is a calculated checksum (based on [2]).
Thus, the data frame consists of 10 bytes as per protocol description.
Then the transmitter sends the frame to the receiver through the connection using the protocol described earlier in this document.
The Bit-stuffing function is implemented. 
There is a Gremlin() function implemented which emulates problems with data transfer. 
It breaks the CRC byte, stored in trailer, with probability of 5%.
Receiver checks the checksum transmitted within the trailer against checksum calculated from the received frame.
In case if checksums are not equal the receiver sends request to transmitter to repeat the data transfer of this frame again. 
The correct data frames extracted from messages are written by the receiver one by one into a .txt file.

Refferences
***********
[1] https://msdn.microsoft.com/en-us/library/windows/desktop/ms737889
[2] http://stackoverflow.com/questions/10564491/function-to-calculate-a-crc16-checksum