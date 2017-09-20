
/Create a simple unkeyed table
q)family:([] name:`Nash`Beatz`Mum`Dad; age: 20 23 26 29; country: `Zim`Thai`Gerimani`Kwese)
q)family
name  age country 
------------------
Nash  20  Zim     
Beatz 23  Thai    
Mum   26  Gerimani
Dad   29  Kwese 

/Create the same table with name as the key
q)family:([name:`Nash`Beatz`Mum`Dad]; age: 20 23 26 29; country: `Zim`Thai`Gerimani`Kwese)
q)family
name | age country 
-----| ------------
Nash | 20  Zim     
Beatz| 23  Thai    
Mum  | 26  Gerimani
Dad  | 29  Kwese 

/Make the first 2 columns the keys in the table
q)`name`age xkey family
name  age| country 
---------| --------
Nash  20 | Zim     
Beatz 23 | Thai    
Mum   26 | Gerimani
Dad   29 | Kwese   

/Remove keys
q)0!family
name  age country 
------------------
Nash  20  Zim     
Beatz 23  Thai    
Mum   26  Gerimani
Dad   29  Kwese 

/Make the first two columns keys again
q)2!family
name  age| country 
---------| --------
Nash  20 | Zim     
Beatz 23 | Thai    
Mum   26 | Gerimani
Dad   29 | Kwese   