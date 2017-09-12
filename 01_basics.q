
/ 1. Calculate the following mathematical expression in q using as few parentheses as possible
/(((2+5)×(3×100)) / ((38×2)+24)) = 21
/ Hint: the division operator in q is % and there is no order of operator prececence so everything is evaluated from RIGHT TO LEFT
q)(2+5) * 3*100 % 24+38*2
21f

/ Define a list d.
q)d: 1 2 5 8

/ Multiply each element of d by 2 and add the result to d.
q)d_two: d + d*2

/ Add 1 to each element of d. Call this e. Multiply each element of e by itself.
q)e: d + 1
q)e_by_e: e * e

/ Join d and e.
q)d
1 2 5 8
q)e
2 3 6 9
q)d, e
1 2 5 8 2 3 6 9
