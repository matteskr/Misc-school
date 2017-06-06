#include <cmath>
#include <iostream>
#include <vector>              // including appropriate librairy's
#include <string>
#include <iomanip>

using namespace std;

int main(float argc, char* argv[])
{
	int input;
	vector<int> list;
	while (cin >> input) {       //While loop storing inputs in a vector
		list.push_back(input);  
		std::string s = std::to_string(input); // Converting input to string 
		if (string(s) == "#")  // if statement to break for loop if "#" is inputed
			break;
	}
	int i;
	//finding average
	float size= (float)list.size();  //determining size of vector
	float xbar = 0.0;
	for (i = 0; i < size; i++) 
		xbar = xbar + (float)list[i]; //applying appropriate mean average formula

	xbar = xbar / (size);
	cout << "The average is " << setprecision(2) << fixed << xbar << endl;

	// finding the standard deviation
	float numerator = 0.0;
	float denominator = size;

	for (i = 0; i < size; i++)
		numerator = numerator + pow(((float)list[i] - xbar),2.0); // applying standard deviation formula
	
	float standard_deviation = sqrt(numerator /(denominator));
	cout << "The standard deviation for the given data is "
		<< setprecision(2) << fixed << standard_deviation << endl; // Outputing appropiriate decimal points
	getchar(0)
	return 0;
	
}
