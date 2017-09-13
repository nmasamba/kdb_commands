
/ Create a short, p. Check that its type is correct. 
q)p: 5
q)type p
-7h

/ Cast p to each of the following datatypes:
/int:
q)`int$p
5i
/float:
q)`float$p
5f
/date:
q)`date$p
2000.01.06
/string:
q)string p
,"5"

/ Cast a string to a symbol and back again.
q)mystring: "ndiniuyo"
q)type mystring
10h
q)mysymbol: `$mystring
q)type mysymbol
-11h
q)backtostr: string mysymbol
q)type backtostr
10h

/ Can you figure out when the kdb+ epoch is? (e.g. Which date corresponds to 0?) What happens to earlier dates?
q)epoch: `date$0
q)type epoch
-14h
q)epoch
2000.01.01

/ What is happening here? How would we get the desired outcome of 28i?
/ q)`int$"28"
/ Answer: Characters are stored using their ASCII code, and this is what the cast operator returns by default. Use string notation with a capital letter to get the desired result.
/ Desired outcome: q)"I"$"28"

/ Copy out the following code:
/ q)x:2 3 5 2 4 7 2 1i
/ q)x=2
/ What datatype is returned? Can you see what is happening?
/ Answer: 10010010b
/ Explanation: The result is a boolean list. The = operator compares each element of x to 2. If equal, it returns 1b (true), otherwise it returns 0b (false). The resulting list is the same length as x.









