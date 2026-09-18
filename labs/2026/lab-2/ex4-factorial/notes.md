## Exercise 4 — Factorial Procedure

Computes factorial of N=5 using a procedure.
Registers: a0 = argument/return value, s0 = n, t0 = result, t1 = i.
Stack frame: saves ra and s0 before the loop, restores before ret.
ra must be saved because main called factorial with jal.
s0 is callee-saved so it must be preserved across the call.
Result: 5! = 120.