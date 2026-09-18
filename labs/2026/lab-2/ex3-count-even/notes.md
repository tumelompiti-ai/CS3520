## Exercise 3 — Count Even Elements

Counts even numbers in array {1,2,3,4,5,6}.
Registers: t0 = array pointer, t1 = n, t2 = count, t3 = i, t4 = current element.
Uses andi t5, t4, 1 to test LSB — if 0 the number is even.
Array pointer advances by 4 bytes per iteration