#include <stdio.h>

int main(){
	int a, b;
	for(a = 0, b = 2; a < b;a++, b++){
		if(a < b || b == 2){
			printf("True1");
			a++;
		}
		else if(a == 7){
			printf("True2");
		}
		else{
			printf("False");
		}
	}
	return 0;
}
