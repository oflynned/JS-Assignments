//Esidor Pashaj -- 12302561

#include <fstream>
#include <iostream>
#include <time.h>

using namespace std;

int RandGen()  // generates a random alphanumeric character
{
	int num = 0;
	num = rand()%3;    // random sub-range
 
	if (num == 0)      // range0: numeric
	{
		return (rand()%10)+48;
	}   
	if (num == 1)       // range1: upper characters
	{
		return (rand()%26)+65;
	}
	if (num == 2)        // range2: lower characters
	{
		return (rand()%26)+97;
	}
 
 
}


int main()
{
    
    ofstream out;     // declare the 'out' stream

    out.open("data_file.txt");  // open data file
      
    if(out.fail())              // check if opened
    { 
		cout << "unable to open data_file.txt" << endl;
		return 1; 
    } 
    srand((unsigned)time(0));
	for(int i = 0;i<1024;i++)   // the loop outputs 1024 alphanumeric characters into the stream
    {
		// casting from a number to a character
        out << static_cast<char>(RandGen());           
    }

    
    out.close();

    system("PAUSE");

	return 0;    

}
