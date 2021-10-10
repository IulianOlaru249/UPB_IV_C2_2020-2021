#!/usr/bin/python3

import sys

def factorial(n, level):
	recursion_limit = sys.getrecursionlimit()
	if level ==  recursion_limit - 100:
    		sys.setrecursionlimit(recursion_limit + 100)

	if n == 0:
		return 1 
	else: 
		return n * factorial(n - 1, level + 1)

if __name__ == '__main__':
    print()

    big_number = int(sys.argv[1])

    for i in range(1, big_number + 1):
        print('factorial(%d) = %d' % (i, factorial(i, 0)))
