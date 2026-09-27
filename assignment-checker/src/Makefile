CC ?= gcc
CFLAGS = -Wall -Wextra -O2

.PHONY: all clean

all: stats

stats: stats.c
	$(CC) $(CFLAGS) -o $@ $^

clean:
	-rm -f stats
