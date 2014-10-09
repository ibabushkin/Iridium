#include <stdio.h>

int main(){
	int a = 0, b = 1;
	while(a == 0){
		b++;
		if(b == 7){
			a = 1;
		}
	}
	printf("%d", b);
	return 0;
}
