
/ Ensure that the smartmeterDB has been built (see 17_on_disk_queries for instructions)
/ The Smart-Meter demo includes a basic UI intended for Business Intelligence-type usage. 
/ It is intended as a simple example of an HTML5 front end talking directly to the q database. 
/ It is not intended as a demonstration of capability in building advanced BI tools or complex GUIs. 
/ It is to show the performance of q slicing and dicing the data in different ways directly from the raw dataset, and the q language
/ the whole report is done in one function, usagereport. There isn’t any caching of data; there aren't any tricks.

/ The report allows for 3 things:
	/ filtering of the data by date, customer type and region
	/ grouping (aggregating) by different combinations of dimensions. If no grouping is selected, the raw usage for every meter is displayed
	/pivoting of the data by a chosen field. If the data is pivoted then the totalusage value is displayed.

/ To access the UI, start the smart-meter demo database on port 5600 and point your browser (Chrome or Firefox only please!) at http://localhost:5600/smartmeter.html. 
/ If the date range becomes large, the query will take more time and memory. Similarly, grouping by hour can increase the time taken.
$ q smartmeterdemo.q -s 2 -p 5600
KDB+ 3.5 2017.09.06 Copyright (C) 1993-2017 Kx Systems
m32/ 8()core 8192MB nashmasamba nashs-mbp-2.lan 192.168.1.215 NONEXPIRE  

Welcome to kdb+ 32bit edition
For support please see http://groups.google.com/d/forum/personal-kdbplus
Tutorials can be found at http://code.kx.com/wiki/Tutorials
To exit, type \\
To remove this startup msg, edit q.q

DATABASE INFO
-------------
This database consists of 5 tables.
It is using 2 slaves.
There are 61 date partitions.

table        rowcount 
----------------------
meter        878400000
payment      19000    
static       10000    
basicpricing 3        
timepricing  3        

The schema of each table is:
(c = column; t = type; f = foreign key field; a = attribute)

basicpricing:
c       | t f a
--------| -----
custtype| s    
price   | f    

meter:
c      | t f a
-------| -----
date   | d    
meterid| j   p
time   | p    
usage  | f    

payment:
c      | t f a
-------| -----
date   | d    
meterid| j    
amount | f    

static:
c       | t f a
--------| -----
meterid | j   u
custtype| s   g
region  | s   g

timepricing:
c       | t f a
--------| -----
custtype| s    
time    | U    
price   | F    


The meter table contains the updates from the smart meters.
The usage value is the total cumulative usage to date.
The time is the time the update was received.
The static table contains the associated lookup data for each meter.
Each meter belongs to a specific customer type in a specific region.

The customer type distribution is:
custtype   | number
-----------| ------
commercial | 1500  
industrial | 500   
residential| 8000  

The region distribution is:
region       | number
-------------| ------
carnmoney    | 3496  
glengormley  | 3963  
mallusk      | 963   
templepatrick| 1578  

The basicpricing table contains price-per-unit information for each customer type
for different periods of the day
custtype   | price
-----------| -----
residential| 1    
commercial | 0.8  
industrial | 0.5  

The timepricing table contains price-per-unit information for each customer type
for different periods of the day
custtype   | time                                      price                 ..
-----------| ----------------------------------------------------------------..
residential| 00:00 08:00 11:15 12:00 17:00 18:00 22:15 0.6 1.2 1.1 1 1.1 1.4 ..
commercial | 00:00 09:00 17:00 20:00                   0.6 0.9 0.8 0.6       ..
industrial | 00:00 08:00 17:00                         0.4 0.6 0.4           ..

SMART METER DEMO
----------------
These examples allows you to see some examples of q code and the corresponding
performance on your system. Please note that the performance is dependent on
your hardware.  Depending on the query, big performance gains can be seen
when using multiple disks and when running the database process with slave processes
on multicore systems e.g. -s 4
You may want to experiment with slaves, and running each example several
times. The performance may improve as the database and file system warm up.
Note though that using slaves increases memory usage, and if you are using the trial
version of kdb+ you are limited to 32bit physical memory (approx 4GB).
The function definitions displayed here will be displayed without comments.  Please see
the function source file for comments and more description of how it works.
At any point you can inspect the database tables by running select statements on them.
You can re-run the functions with different parameters.  You can create your own
functions.  Please experiment!

Turning garbage collection on after each query will lower the total memory usage
but may degrade the query performance.
Garbage collection is currently ON
You are currently using the 32bit version of kdb+

See http://code.kx.com for reference on the q language.

Run .tut.help[] to redisplay the below instructions
Start by running .tut.n[].

.tut.n[]     : run the Next example
.tut.p[]     : run the Previous example
.tut.c[]     : run the Current example
.tut.f[]     : go back to the First example
.tut.j[n]    : Jump to the specific example
.tut.db[]    : print out database statistics
.tut.res     : result of last run query
.tut.gcON[]  : turn garbage collection on after each query
.tut.gcOFF[] : turn garbage collection off after each query
.tut.help[]  : display help information
\\           : quit


/ NOW RUN FROM BROWSER TO INVOKE UI: http://localhost:5600/smartmeter.html




