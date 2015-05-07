#include <stdio.h>

int main(){
	char a, b;
	int c, c_max, d, d_max;
	char buf[20];
	puts("Eingabe in Buffer (20 Zeichen): ");
	scanf("%20s", buf);
	puts("Anzahl Schleifendurchläufe: ");
	scanf("%d", &c_max);
	for (c=0; c<c_max; c++){
		puts("Anzahl innerer Schleifendurchläufe: ");
		scanf("%d", &d_max);
		for (d=0; d<d_max; d++){
			if (d%2 == 0)
				puts("d gerade.");
			else
				puts("d ungerade.");
		}
	}
	return 0;
}
