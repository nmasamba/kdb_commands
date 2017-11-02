
/ First of all, load the tables from lesson 15_in_memory_queries.q

/ Joins are very fast in q. Most q databases do not rely heavily on pre-defined foreign-key relationships between tables, as is common in standard RDMSs. 
/ Instead, ad-hoc joins are used. 
/ As an example, lj (left join) can be used join the computerlookup table to either the computer or calls table to show the static data on each computer id.
q)calls lj computerlookup
time                          id  severity dept        os   
------------------------------------------------------------
2017.10.28D17:20:46.231310608 990 1        hoopjumping win7 
2017.10.28D17:20:49.444127621 33  2        telesales   win8 
2017.10.28D17:20:49.896951558 843 1        management  win7 
2017.10.28D17:22:09.585716667 16  2        management  win7 
2017.10.28D17:25:00.084590705 776 3        packing     vista
2017.10.28D17:27:23.168304654 529 3        management  vista
2017.10.28D17:31:10.717362108 766 1        hoopjumping win7 
2017.10.28D17:35:15.484893860 547 1        telesales   win7 
2017.10.28D17:36:05.186696293 198 3        packing     osx  
2017.10.28D17:37:10.670348348 897 3        packing     osx  
2017.10.28D17:41:03.353153857 834 2        management  win8 
2017.10.28D17:42:33.043172302 10  1        trading     win7 
2017.10.28D17:44:30.842070671 510 1        finance     vista
2017.10.28D17:44:33.531655761 708 3        hoopjumping vista
2017.10.28D17:46:15.805593075 222 2        logistics   vista
2017.10.28D17:47:07.145085277 128 1        finance     vista
2017.10.28D17:48:08.181064816 688 2        hoopjumping osx  
2017.10.28D17:49:09.465081634 349 1        telesales   win8 
2017.10.28D17:59:03.778796287 576 2        management  vista
2017.10.28D18:04:58.444947394 587 1        management  win8 
..

/ We can then perform aggregations using this static data – for example, count calls by severity and department
q)select callcount:count i by severity, dept from calls lj computerlookup 
severity dept       | callcount
--------------------| ---------
1        finance    | 152      
1        hoopjumping| 148      
1        logistics  | 127      
1        management | 152      
1        packing    | 162      
1        telesales  | 122      
1        trading    | 130      
2        finance    | 148      
2        hoopjumping| 163      
2        logistics  | 137      
2        management | 136      
2        packing    | 127      
2        telesales  | 140      
2        trading    | 144      
3        finance    | 147      
3        hoopjumping| 133      
3        logistics  | 154      
3        management | 140      
3        packing    | 152      
3        telesales  | 136      
3        trading    | 150    

/ Alternatively, we can enforce a foreign-key relationship and use that
q)update `computerlookup$id from `calls
`calls
q)select callcount:count i by id.os, id.dept, severity from calls
os  dept        severity| callcount
------------------------| ---------
osx finance     1       | 41       
osx finance     2       | 48       
osx finance     3       | 39       
osx hoopjumping 1       | 44       
osx hoopjumping 2       | 49       
osx hoopjumping 3       | 37       
osx logistics   1       | 29       
osx logistics   2       | 32       
osx logistics   3       | 34       
osx management  1       | 32       
osx management  2       | 33       
osx management  3       | 34       
osx packing     1       | 41       
osx packing     2       | 32       
osx packing     3       | 42       
osx telesales   1       | 31       
osx telesales   2       | 44       
osx telesales   3       | 48       
osx trading     1       | 29       
osx trading     2       | 25       
..















