

/ delete returns a modified version of the table with specified information deleted
/ Tip: Be very careful with deletes, you don't want accidentally to delete your entire in-memory database!
q)delete country from family
name  age
---------
Nash  20 
Beatz 23 
Mum   26 
Dad   29 
Moi   100

/ update also returns an updated modified version of the table
/ Note: we say a modified version is returned because the actual family table is actually unchanged
/ The queries have not modified the table, but have simply returned a result
q)update age:age+5 from family where name in `Nash`Beatz
name  age country 
------------------
Nash  25  Zim     
Beatz 28  Thai    
Mum   26  Gerimani
Dad   29  Kwese   
Moi   100 Zim   

/ To modify the actual table, we need to pass a reference to the table
q)update surname: `Masamba from `family
`family
q)family
name  age country  surname
--------------------------
Nash  20  Zim      Masamba
Beatz 23  Thai     Masamba
Mum   26  Gerimani Masamba
Dad   29  Kwese    Masamba
Moi   100 Zim      Masamba
q)delete from `family where name in `Dad
`family
q)family
name  age country  surname
--------------------------
Nash  20  Zim      Masamba
Beatz 23  Thai     Masamba
Mum   26  Gerimani Masamba
Moi   100 Zim      Masamba