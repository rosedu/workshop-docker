#include <stdio.h>
#include <stdlib.h>

/*
 * Read integers from standard input, one per line, and print their count,
 * their sum and their minimum and maximum value.
 */
int main(void)
{
	long value, sum = 0, min = 0, max = 0;
	size_t count = 0;

	while (scanf("%ld", &value) == 1) {
		if (count == 0 || value < min)
			min = value;
		if (count == 0 || value > max)
			max = value;
		sum += value;
		count++;
	}

	if (count == 0) {
		printf("no values\n");
		return 0;
	}

	printf("count: %zu\n", count);
	printf("sum: %ld\n", sum);
	printf("min: %ld\n", min);
	printf("max: %ld\n", max);

	return 0;
}
