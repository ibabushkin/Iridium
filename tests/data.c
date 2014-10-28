#include <stdio.h>

int main(){
	int a, b;
	int c[10];
	int d[20];
	for(a=0, b=0;b<20;a++, b++){
		if(a<10){
			c[a] = a;
		}
		d[b] = b;
	}
	printf("Lol! DATA....");
}
