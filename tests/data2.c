#include <stdio.h>

int main(){
	int *a;
	int b = 7;
	a = &b;
	printf("%x", a);
	return 0;
}
