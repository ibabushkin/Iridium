#include <stdio.h>
#include <stdlib.h>

int main(){
	int i;
	int size = 20;
	int *array;
	array=(int *) malloc(size*sizeof(int));
	for(i=0;i<20;i++){
		*(array+i) = i;
	}
	printf("%d", i);
	free(array);
	return 0;
}
