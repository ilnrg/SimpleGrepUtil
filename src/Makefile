all: main

main: clang-format simple_grep

simple_grep: simple_grep.c
	gcc -Wall -Werror -Wextra -std=c11 -o simple_grep simple_grep.c

clang-format:
	clang-format -i *.c

test:
	chmod +x grep_test.sh
	./grep_test.sh
	rm -rf 0
	rm -rf grep.txt
	rm -rf simple_grep.txt

clean:
	rm -rf *.out
	rm -rf simple_grep

rebuild: clean clang-format all