
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


/ TIME JOINS
/ Q has some specialized time joins. 
/ The joins aren’t restricted to time fields (any numeric type will work) but that is what they are predominantly used for. 
/ The first, aj (asof join) is used to align two tables, aligning the prevailing value from the value table with each record in the source table
q)aj[`id`time;calls;computer]
time                          id  severity cpu
----------------------------------------------
2017.10.29D18:51:54.881921608 990 1        35 
2017.10.29D18:51:58.094738621 33  2        27 
2017.10.29D18:51:58.547562558 843 1        38 
2017.10.29D18:53:18.236327667 16  2        41 
2017.10.29D18:56:08.735201705 776 3        29 
2017.10.29D18:58:31.818915654 529 3        24 
2017.10.29D19:02:19.367973108 766 1        31 
2017.10.29D19:06:24.135504860 547 1        30 
2017.10.29D19:07:13.837307293 198 3        30 
2017.10.29D19:08:19.320959348 897 3        20 
2017.10.29D19:12:12.003764857 834 2        37 
2017.10.29D19:13:41.693783302 10  1        30 
2017.10.29D19:15:39.492681671 510 1        21 
2017.10.29D19:15:42.182266761 708 3        32 
2017.10.29D19:17:24.456204075 222 2        27 
2017.10.29D19:18:15.795696277 128 1        27 
2017.10.29D19:19:16.831675816 688 2        27 
2017.10.29D19:20:18.115692634 349 1        51 
2017.10.29D19:30:12.429407287 576 2        34 
2017.10.29D19:36:07.095558394 587 1        26 
..

/ Q also has a window join wj
/ A window join is a generalization of an asof join
/ Instead of selecting the prevailing value, it allows you to apply any aggregation within a window around a source record.
/ e.g. work out the maximum and average CPU usage for each computer in a window around the call time
/ we can specify a window of 10-minutes-before to 2-minutes-after each call, and calculate the maximum and average CPU usage
q)wj[-0D00:10 0D00:02+\:calls.time;`id`time; calls; (update `p#id from `id xasc  computer;(max;`cpu);(avg;`cpu))]                                                                 
time                          id  severity cpu cpu     
-------------------------------------------------------
2014.05.09D12:28:29.436601608 990 1        37  35.6    
2014.05.09D12:28:32.649418621 33  2        29  27.6    
2014.05.09D12:28:33.102242558 843 1        38  36.8    
2014.05.09D12:29:52.791007667 16  2        42  41.14286
2014.05.09D12:32:43.289881705 776 3        31  29.55556
2014.05.09D12:35:06.373595654 529 3        29  26.5    
2014.05.09D12:38:53.922653108 766 1        40  35.23077
time                          id  severity cpu cpu     
-------------------------------------------------------
2017.10.29D18:51:54.881921608 990 1        37  35.83333
2017.10.29D18:51:58.094738621 33  2        29  27.5    
2017.10.29D18:51:58.547562558 843 1        38  36.66667
2017.10.29D18:53:18.236327667 16  2        42  41.14286
2017.10.29D18:56:08.735201705 776 3        31  29.6    
2017.10.29D18:58:31.818915654 529 3        29  26.5    
2017.10.29D19:02:19.367973108 766 1        40  35.23077
2017.10.29D19:06:24.135504860 547 1        32  29      
2017.10.29D19:07:13.837307293 198 3        32  30.07692
2017.10.29D19:08:19.320959348 897 3        29  24      
2017.10.29D19:12:12.003764857 834 2        40  37.61538
2017.10.29D19:13:41.693783302 10  1        32  28.76923
2017.10.29D19:15:39.492681671 510 1        24  21.76923
2017.10.29D19:15:42.182266761 708 3        33  31.23077
2017.10.29D19:17:24.456204075 222 2        30  27.23077
2017.10.29D19:18:15.795696277 128 1        30  28.07692
2017.10.29D19:19:16.831675816 688 2        28  25.23077
2017.10.29D19:20:18.115692634 349 1        53  50.84615
2017.10.29D19:30:12.429407287 576 2        36  32.38462
2017.10.29D19:36:07.095558394 587 1        26  24.92308
..














