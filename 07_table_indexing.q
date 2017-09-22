
/Indexing usually refers to accessing elements

/Unkeyed tables are like lists: rows are numbered starting with 0.
q)family
name  age country 
------------------
Nash  20  Zim     
Beatz 23  Thai    
Mum   26  Gerimani
Dad   29  Kwese   

q)family 0 2
name age country 
-----------------
Nash 20  Zim     
Mum  26  Gerimani

q)family 1
name   | `Beatz
age    | 23
country| `Thai

/Keyed tables are dictionaries, and so their rows are indexed by keys instead of numbers.
q)keyed: 1!family
q)keyed `Nash
age    | 20
country| `Zim 

/We can also access the columns of an unkeyed table as if it were a dictionary:
q)family `country
`Zim`Thai`Gerimani`Kwese

