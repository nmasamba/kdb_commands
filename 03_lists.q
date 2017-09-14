
/ Create a string of your own name. Find the last letter of that string.
q)surname: "masamba"
q)first surname

/ Copy the following list into your q process.
/ t:`b`i`i`n`o`b`k`h`l`m`m`c`e`f`m`m`e`o`c`o
/Find the first place/index the symbol `o occurs
q)t?`o
4
/Find all of the indices where the symbol `o occurs
q)where t=`o
4 17 19
/How many elements of t are later in the alphabet than the letter j? What are those elements?
q)where t>`j
3 4 6 8 9 10 14 15 17 19
q)after_j: t where t>`j
q)count after_j
10

/ Create your own mixed list and check that its type is 0h.
q)mixed:( "mac"; "linux"; `i; 22; 5 1 988)
q)type mixed
0h

/ Create a list i of ints, and a list s of symbols. Join i and s to form a new list, m.
q)i: 9 10 12 2 34 1032 5 9
q)s: `a`b`c`d`e`f`z 
q)m: i,s
q)m
9
10
12
2
34
1032
5
9
`a
`b
`c
`d
`e
`f
`z

/ Create a nested list n (AKA a list of lists), with two elements: i and s.
q)n: (i;s)
q)n
9 10 12 2 34 1032 5 9
`a`b`c`d`e`f`z

/ Type out the following
/ mylist:("hello";"world";1 2 3 4 5;101b)
/Use first to get the first element of each element
q)first each mylist
"h"
"w"
1
1b
/Use indexing to get the first element of each element
q)mylist[0 1 2 3;0]
"h"
"w"
1
1b












