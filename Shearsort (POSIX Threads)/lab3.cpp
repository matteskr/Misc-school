#include<iostream>
#include<fstream>
#include<pthread.h>

#define N 4 							 //n length of side in square matrix
#define MAX_THREADS 4 					 //Max Number of Threads
#define MAX_PHASES 5 					 //# of Phases

int rc = 0; 							 //Global Switch between row and col sort
int array[N][N]; 						 //Make NxN array	
int rcount = 0;
int ccount = 0;
pthread_mutex_t mut;					 //Mutual Exclusion for shared array
pthread_mutex_t rProt;					 //BSemaphore to protect from doing col bubble sort
pthread_mutex_t cProt; 					 //BSemaphore to protect from doing row bubble sort

using namespace std;


int input(istream& in=cin){
	int x;
	in >> x;
	return x;
}


void inputArray(int n){					//Populates square array with numbers
	ifstream fin;
	fin.open("input.txt");

	for(int i=0; i<n; i++){ 
		for(int j=0; j<n; j++){ 
			array[i][j] = input(fin);
		
		}	
	}
	
	fin.close();
}

void printArray(int n){					//Prints out square array
	cout << "~~~~~~~~~~~" << endl;
	for (int i=0; i<n; i++){ 
		for (int j=0; j<n; j++){
			cout << array[i][j] << " ";
		}	
		cout << endl;	
	}

	cout << "~~~~~~~~~~~" << endl;
}





void rowBubblesort(int n, int row){			// Row Bubble Sort
	int num1, num2;
	bool swap = true;	
	
	if ((row % 2) == 0){		//Sort direction -> if even row
		while (swap){
			swap = false;
			for (int j=0; j<(n-1); j++){
				pthread_mutex_lock(&mut);           // If the mutex is already locked, the calling 
				num1 = array[row][j];				// thread blocks until the mutex becomes available
				num2 = array[row][j+1];
				pthread_mutex_unlock(&mut);		    //		
				
				if (num2 < num1){
					pthread_mutex_lock(&mut);       //
					array[row][j] = num2;			
					array[row][j+1] = num1;
					swap = true;
					pthread_mutex_unlock(&mut);	    //
				}
			}
		}	
	}
	else if ((row % 2) == 1){	//Sort direction -> if odd row
		while (swap){
			swap = false;
			for (int j=0; j<(n-1); j++){
				pthread_mutex_lock(&mut);			
				num1 = array[row][j];
				num2 = array[row][j+1];
				pthread_mutex_unlock(&mut);			

				if (num1 < num2){
					pthread_mutex_lock(&mut);		
					array[row][j] = num2;
					array[row][j+1] = num1;
					swap = true;
					pthread_mutex_unlock(&mut);		
				}
			}
		}
	}
	
	pthread_mutex_lock(&mut);
	rcount++;
	pthread_mutex_unlock(&mut);
}

void colBubblesort(int n, int col){ //Column Bubble Sort
	int num1, num2;
	bool swap = true;	

	while (swap){
		swap = false;
		for (int i=0; i<(n-1); i++){
			pthread_mutex_lock(&mut);		
			num1 = array[i][col];
			num2 = array[i+1][col];
			pthread_mutex_unlock(&mut);		
		
			if (num2 < num1){
				pthread_mutex_lock(&mut);	
				array[i][col] = num2;			
				array[i+1][col] = num1;
				swap = true;	
				pthread_mutex_unlock(&mut);	
			}
			
		}
	pthread_mutex_lock(&mut);
	ccount++;
	pthread_mutex_unlock(&mut);
	}	
}

void check(int phase){
	int chk = phase % 2;

	if (rcount >= N){
		pthread_mutex_unlock(&cProt); rcount = 0;
		} 											//Switch from row to col sort
	if (ccount >= N){
		pthread_mutex_unlock(&rProt);
		ccount = 0;} 								//Switch from col to row sort
	
	if (chk == 0){rc = 0; pthread_mutex_lock(&cProt);}	// Lock other type sort (rProt and cProt)
	else if (chk == 1) {
		rc = 1; 
		pthread_mutex_lock(&rProt);
		}
	
}

void *phaseSort(void *thread){		//Determining Switch between row and col sort
	long t = (long) thread;

	if (rc == 0){
		rowBubblesort(N, t);
	}
	else if (rc == 1) {
		colBubblesort(N, t);
	}
	
}

int main(){
	void *status;

	inputArray(N);
	
	cout << "Initial Matrix" << endl;
	printArray(N);
	
	pthread_mutex_init(&mut, NULL); //initialize the mutex referenced by mutex
	pthread_mutex_init(&rProt, NULL);
	pthread_mutex_init(&cProt, NULL);
	pthread_t threads[MAX_THREADS]; 
	
	for (int phase=0; phase<MAX_PHASES; phase++){
		for (long t=0; t<MAX_THREADS; t++)
			pthread_create(&threads[t], NULL, phaseSort, (void*) t); //creates a new thread and makes it executable

		for (long t=0; t<MAX_THREADS; t++)
			pthread_join(threads[t], &status); //suspends execution of the calling thread until the target thread terminates

		check(phase+1);
		cout << "Phase ";
		cout << phase+1 ;
		cout << ": " << endl;
		printArray(N);
	}
	
	cout << "Sorted Matrix" << endl; 
	printArray(N);
	

	pthread_mutex_destroy(&mut);
	pthread_mutex_destroy(&rProt);
	pthread_mutex_destroy(&cProt);
	pthread_exit(NULL);
	return 0;
}


