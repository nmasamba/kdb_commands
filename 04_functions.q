
/ Use the factorial function f above to evaluate (10!)/(6! × 4!).
q)f[10] % f[6] * f[4]
210f

/ Write your own function, which takes the parameters n, k to calculate (n!)/(k! × (n-k)!).
q)myfunc:{[n;k] f[n] % f[k] * f[n-k]}

/ Write a function without any inputs at all!
q)noinputs:{"no take, just throw"}
q)noinputs []
"no take, just throw"

/ Write a function which returns all of the even numbers up to the input
q)even_nums:{2 * 1 + til x div 2}