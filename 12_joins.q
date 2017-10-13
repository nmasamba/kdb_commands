
/ There are many ways of joining tables in KDB/Q, and only a subset are dealt with in this tutorial
/ First we create a couple of tables
q)students:([] id:140 265 204 212 367 197 329 242; class:`green`blue`green`orange`green`blue`green`green)
q)mentors:([] class:`green`blue`violet; mentor_name:("Julia Johnson";"Teddy Rowles";"Gerald Carlier"))
q)mentors
class  mentor_name     
-----------------------
green  "Julia Johnson" 
blue   "Teddy Rowles"  
violet "Gerald Carlier"
q)students
id  class 
----------
140 green 
265 blue  
204 green 
212 orange
367 green 
197 blue  
329 green 
242 green 

/ The simplest kind of join just pastes the rows of one table onto the end of the other
/ If the schemas (lists of column names) are identical, we join them using a simple comma
/ If not, the join operation fails, as the two tables do not have matching schemas
q)students, students
id  class 
----------
140 green 
265 blue  
204 green 
212 orange
367 green 
197 blue  
329 green 
242 green 
140 green 
265 blue  
204 green 
212 orange
367 green 
197 blue  
329 green 
242 green 
q)mentors, students
'mismatch
  [0]  mentors, students
              ^


/ Left join takes two tables as inputs: the second table must be keyed, and the first table must contain those keyed columns
/ The resulting left join contains all of the rows from students
/ Syntax: <table> lj <keyed_table>
q)students lj 1!mentors
id  class  mentor_name    
--------------------------
140 green  "Julia Johnson"
265 blue   "Teddy Rowles" 
204 green  "Julia Johnson"
212 orange ""             
367 green  "Julia Johnson"
197 blue   "Teddy Rowles" 
329 green  "Julia Johnson"
242 green  "Julia Johnson"

/ Inner join also takes two tables as inputs: the second table must be keyed, and the first table must contain those keyed columns
/ The resulting inner join contains only those rows matching the class column in mentors
/ Syntax: <table> ij <keyed_table>
q)students ij 1!mentors
id  class mentor_name    
-------------------------
140 green "Julia Johnson"
265 blue  "Teddy Rowles" 
204 green "Julia Johnson"
367 green "Julia Johnson"
197 blue  "Teddy Rowles" 
329 green "Julia Johnson"
242 green "Julia Johnson"

/ To join the two tables without matching rows, we use the union join
/ Syntax: <table> lj <table>
q)students uj mentors
id  class  mentor_name     
---------------------------
140 green  ""              
265 blue   ""              
204 green  ""              
212 orange ""              
367 green  ""              
197 blue   ""              
329 green  ""              
242 green  ""              
    green  "Julia Johnson" 
    blue   "Teddy Rowles"  
    violet "Gerald Carlier"


/ For the union join either neither table will be keyed, or the tables will have the same keys
q)students uj 1!mentors
'nyi
  [0]  students uj 1!mentors
                ^

q)keyed_stu: `class xkey students
q)keyed_stu
class | id 
------| ---
green | 140
blue  | 265
green | 204
orange| 212
green | 367
blue  | 197
green | 329
green | 242
q)keyed_ment: `class xkey mentors
q)keyed_ment
class | mentor_name     
------| ----------------
green | "Julia Johnson" 
blue  | "Teddy Rowles"  
violet| "Gerald Carlier"
q)keyed_stu uj keyed_ment
class | id  mentor_name     
------| --------------------
green | 140 "Julia Johnson" 
blue  | 265 "Teddy Rowles"  
orange| 212 ""              
violet|     "Gerald Carlier"
q)keyed_ment uj keyed_stu
class | mentor_name      id 
------| --------------------
green | "Julia Johnson"  140
blue  | "Teddy Rowles"   265
violet| "Gerald Carlier"    
orange| ""               212









