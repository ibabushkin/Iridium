#include <stdio.h>

int main(){
	int i, j;
	for(i=0;i<10;i++){
		for(j=0;j<10;j++){
			if ((i == 7) && (j == 3)){
				printf("%d:%d", i, j);
			}
			else if ((i == 5) && (j == 8)){
				puts("elseif");
			}
			else{
				puts("else");
			}
		}
	}
	return 0;
}
