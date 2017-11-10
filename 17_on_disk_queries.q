
/ Build an on-disk database and run some queries against it
/ The idea is to allow you to see some of the q language and performance

/ Use the buildsmartmeterdb.q script in the cookbook/tutorial directory
/ You can vary the number of days of data to build, and the number of customer records per day

/ To start up q and build the smart meter database from bash commend line, type this: q buildsmartmeterdb.q
$ q buildsmartmeterdb.q
KDB+ 3.5 2017.09.06 Copyright (C) 1993-2017 Kx Systems
m32/ 8()core 8192MB nashmasamba nashs-mbp-2.lan 192.168.1.215 NONEXPIRE  

Welcome to kdb+ 32bit edition
For support please see http://groups.google.com/d/forum/personal-kdbplus
Tutorials can be found at http://code.kx.com/wiki/Tutorials
To exit, type \\
To remove this startup msg, edit q.q
This process is set up to save a daily profile across 61 days for 10000 random customers with a sample every 1 minute(s).
This will generate 14.40 million rows per day and 878.40 million rows in total
Uncompressed disk usage will be approximately 330 MB per day and 20130 MB in total
Compression is switched OFF
Data will be written to :./smartmeterDB

To modify the volume of data change either the number of customers, the number of days, or the sample period of the data.  Minimum sample period is 1 minute
These values, along with compression settings and output directory, can be modified at the top of this file (buildsmartmeterdb.q)

To proceed, type go[]

/ To proceed with building the db, type go[] as instructed
q)go[]
2017.11.10T20:17:28.065 Saving static data table to :./smartmeterDB/static
2017.11.10T20:17:28.069 Saving pricing tables to :./smartmeterDB/basicpricing and :./smartmeterDB/timepricing
2017.11.10T20:17:28.070 Generating random data for date 2013.08.01
2017.11.10T20:17:29.965 Saving to hdb :./smartmeterDB
2017.11.10T20:17:31.519 Save complete
2017.11.10T20:17:31.519 Generating random data for date 2013.08.02
2017.11.10T20:17:33.390 Saving to hdb :./smartmeterDB
2017.11.10T20:17:34.806 Save complete
2017.11.10T20:17:34.806 Generating random data for date 2013.08.03
2017.11.10T20:17:36.671 Saving to hdb :./smartmeterDB
2017.11.10T20:17:38.067 Save complete
2017.11.10T20:17:38.067 Generating random data for date 2013.08.04
2017.11.10T20:17:39.922 Saving to hdb :./smartmeterDB
2017.11.10T20:17:41.411 Save complete
2017.11.10T20:17:41.411 Generating random data for date 2013.08.05
2017.11.10T20:17:43.242 Saving to hdb :./smartmeterDB
2017.11.10T20:17:44.750 Save complete
2017.11.10T20:17:44.750 Generating random data for date 2013.08.06
2017.11.10T20:17:46.726 Saving to hdb :./smartmeterDB
2017.11.10T20:17:48.205 Save complete
2017.11.10T20:17:48.205 Generating random data for date 2013.08.07
2017.11.10T20:17:50.213 Saving to hdb :./smartmeterDB
2017.11.10T20:17:51.777 Save complete
2017.11.10T20:17:51.777 Generating random data for date 2013.08.08
2017.11.10T20:17:53.702 Saving to hdb :./smartmeterDB
2017.11.10T20:17:55.225 Save complete
2017.11.10T20:17:55.225 Generating random data for date 2013.08.09
2017.11.10T20:17:57.335 Saving to hdb :./smartmeterDB
2017.11.10T20:17:58.845 Save complete
... snip ...
2017.11.10T20:21:07.079 Saving payment table to :./smartmeterDB/payment/


2017.11.10T20:21:07.080 HDB successfully built in directory :./smartmeterDB
2017.11.10T20:21:07.080 Time taken to generate and store 878.40 million rows was 00:03:39
2017.11.10T20:21:07.080 or 4.01 million rows per second

/ After the database is built, the q environment is automatically exited (enabled by the script)
/ Once the database has been built, you can query it by running smartmeterdemo.q
/ If you modified the database directory from the default specified in buildsmartmeter.q, 
/ you will need to launch the script specifying the new path e.g: q smartmeterdemo.q /my/new/path/to/database
/ If you made no changes, run the demo script: q smartmeterdemo.q -p 5600
$ q smartmeterdemo.q -p 5600
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
It is using 0 slaves.
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

/ To start running queries, execute .tut.n[]
q).tut.n[]

**********  Example 0  **********

Total meter usage for every customer over a 10 day period

Function meterusage has definition:

{[startdate; enddate]

 /- calculate the usage at the start and the end
 start:select first usage by meterid from meter where date=startdate;
 end:select last usage by meterid from meter where date=enddate;

 /- subtract the two
 end-start}

2017.11.10T20:35:20.137 Running: meterusage[2013.08.01;2013.08.10]
2017.11.10T20:35:24.212 Function executed in 4074ms using 384.4 MB of memory

Result set contains 10000 rows.
First 10 element(s) of result set:

meterid | usage   
--------| --------
10000000| 4253.383
10000001| 3257.84 
10000002| 3005.543
10000003| 2467.343
10000004| 3592.205
10000005| 3724.91 
10000006| 3065.635
10000007| 2590.093
10000008| 2699.449
10000009| 3364.171

Garbage collecting...

*********************************











