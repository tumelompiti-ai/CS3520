## Exercise 5 — GCD Procedure

Computes GCD of 48 and 18 using Euclid's algorithm.
Registers: a0 = a, a1 = b, t0 = remainder.
Loop exits when b == 0 using beq.
Uses rem instruction for modulo operation.
ra saved on stack because gcd is called with jal.
Result: GCD(48, 18) = 6.