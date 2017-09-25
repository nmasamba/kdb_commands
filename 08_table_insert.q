
/ Rows can be added to a table using the insert or upsert functions
/ Note: The name of the table is passed into these functions as a symbol, otherwise a type error will be shown
q)family insert (`Moi; 100; `Burkina)
'type
  [0]  family insert (`Moi; 100; `Burkina)
              ^
q)`family insert (`Moi; 100; `Burkina)
,4
q)family
name  age country 
------------------
Nash  20  Zim     
Beatz 23  Thai    
Mum   26  Gerimani
Dad   29  Kwese   
Moi   100 Burkina 

/ The result from insert is a list of the row indices that have been added to the table
/ The result from upsert, however, is simply the name of the modified table
q)`family upsert (`Moi; 100; `Burkina)
`family
q)family
name  age country 
------------------
Nash  20  Zim     
Beatz 23  Thai    
Mum   26  Gerimani
Dad   29  Kwese   
Moi   100 Burkina 

/ For the unkeyed table family, insert and upsert, though returning different results, produced the same outcome – they both added a row to the family table.
/ Type out the following code and see what happens when you insert or upsert into a keyed table
/`keyedtab insert (`p;10;20)
/`keyedtab insert (`i;11;12)
/`keyedtab upsert (`i;11;12)
/`keyedtab upsert (`j;13;20)
q)q)keyedtab:([a:`f`y`i] b:3 4 5; c:6 7 8)
q)keyedtab
a| b c
-| ---
f| 3 6
y| 4 7
i| 5 8
q)`keyedtab insert (`p;10;20)
,3
q)keyedtab
a| b  c 
-| -----
f| 3  6 
y| 4  7 
i| 5  8 
p| 10 20
q)`keyedtab insert (`i;11;12)
'insert
  [0]  `keyedtab insert (`i;11;12)
                 ^
q)q)keyedtab:([a:`f`y`i] b:3 4 5; c:6 7 8)
q)keyedtab
a| b c
-| ---
f| 3 6
y| 4 7
i| 5 8
q)`keyedtab upsert (`i;11;12)
`keyedtab
q)keyedtab
a| b  c 
-| -----
f| 3  6 
y| 4  7 
i| 11 12
q)`keyedtab upsert (`j;13;20)
`keyedtab
q)keyedtab
a| b  c 
-| -----
f| 3  6 
y| 4  7 
i| 11 12
j| 13 20

/ What just happened?
/ The first statement `keyedtab insert (`p;10;20) inserted a new record under the key `p, and returned its row: 3.
/ The second statement `keyedtab insert (`i;11;12) attempted to insert a new record with the key `i. But that key already existed. So insert failed with an error message.
/ The third statement `keyedtab upsert (`i;11;12) found its key `i already in use and updated the corresponding record, returning the name of the modified table.
/ The fourth statement `keyedtab upsert (`j;13;20) inserted a record under the new key `j.
/ In a keyed table, insert creates new table records, while upsert inserts or creates them.










