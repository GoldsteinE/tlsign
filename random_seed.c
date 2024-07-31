#include <stdio.h>
#include <unistd.h>

int main(void) {
	unsigned long long seed;
	if (getentropy(&seed, sizeof(seed)) == -1) {
		perror("getentropy");
		return 1;
	}
	printf("%llu", seed);
	return 0;
}
