#include <stdio.h>

int main(){
	int a=1, b=2;
	do{
		if(a==1)
			b--;
		if(b==1)
			printf("%d", a-b);
	}while(a!=b);
}
