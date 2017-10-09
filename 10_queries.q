
/ The simplest way of accessing data contained in a table is using a select statement
q)family
name  age country 
------------------
Nash  20  Zim     
Beatz 23  Thai    
Mum   26  Gerimani
Dad   29  Kwese   
q)select from family where name=`Nash
name age country
----------------
Nash 20  Zim    
q)select name,country from family where age=26
name country 
-------------
Mum  Gerimani


/ The by clause allows you to perform aggregations or group the results based on a particular column or columns
q)`family insert (`Moi; 100; `Zim)
,4
q)family
name  age country 
------------------
Nash  20  Zim     
Beatz 23  Thai    
Mum   26  Gerimani
Dad   29  Kwese   
Moi   100 Zim     
q)select avg age by country from family
country | age
--------| ---
Gerimani| 26 
Kwese   | 29 
Thai    | 23 
Zim     | 60 


/ Select statements always return a table. It can be useful to return a list or dictionary instead – for this we use exec.
/ Notice that the result is a list if only one column is specified, but a dictionary (with column names as keys) when multiple columns are specified.
q)exec name from family where country = `Zim
`Nash`Moi
q)exec name, age from family where country = `Zim
name| Nash Moi
age | 20   100