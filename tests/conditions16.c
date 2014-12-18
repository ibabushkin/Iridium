#include <stdio.h>

int main(){
	int a, b;
	do{
		a++;
		++b;
		if(a == b){
			printf("LIL");
		}
	}while(a != 9 || b == 7);
}
