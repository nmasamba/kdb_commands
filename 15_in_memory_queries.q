
/ Prepend with \t to time the performance of an operation
q)tab: ([] name:`You`Me`Them; gender:`Unknown`Male`UnknownAgain)
q)\t select name from tab
0
q)select name from tab
name
----
You 
Me  
Them


/ IN-MEMORY QUERY TABLES
/ Generate some random computer statistics (cpu usage only)
/ You can modify n (number of unique computers), timerange (how long the data is for)
/ freq (how often a computer publishes a statistic) and calls (the number of logged calls)
q)n:1000; timerange:5D; freq:0D00:01; calls:3000;
q)depts:`finance`packing`logistics`management`hoopjumping`trading`telesales; startcpu:(til n)!25+n?20; fcn:n*fc:`long$timerange%freq;
q)computer:([]time:(-0D00:00:10 + fcn?0D00:00:20)+fcn#(.z.p - timerange)+freq*til fc; id:raze fc#'key startcpu)
q)\t computer:([]time:(-0D00:00:10 + fcn?0D00:00:20)+fcn#(.z.p - timerange)+freq*til fc; id:raze fc#'key startcpu)
188

q)depts
`finance`packing`logistics`management`hoopjumping`trading`telesales

q)computer:update `g#id from `time xasc update cpu:{100&;3|startcpu[first x]+sums(count x)?-2 -1 -1 0 0 1 1 2}[id] by id from computer
q)\t computer:update `g#id from `time xasc update cpu:{100&;3|startcpu[first x]+sums(count x)?-2 -1 -1 0 0 1 1 2}[id] by id from computer
3998

q)computer
time                          id  cpu
-------------------------------------
2017.10.22D10:48:18.945650534 566 24 
2017.10.22D10:48:18.969909466 477 39 
2017.10.22D10:48:18.970450345 328 41 
2017.10.22D10:48:19.031174123 692 38 
2017.10.22D10:48:19.097137079 157 33 
2017.10.22D10:48:19.107845142 997 33 
2017.10.22D10:48:19.111524705 780 43 
2017.10.22D10:48:19.158021138 77  40 
2017.10.22D10:48:19.212157159 523 33 
2017.10.22D10:48:19.212855572 452 27 
2017.10.22D10:48:19.217836895 787 34 
2017.10.22D10:48:19.225486429 336 26 
2017.10.22D10:48:19.272974795 304 35 
2017.10.22D10:48:19.285642175 139 44 
2017.10.22D10:48:19.331287263 737 36 
2017.10.22D10:48:19.355113637 333 37 
2017.10.22D10:48:19.397874750 769 32 
2017.10.22D10:48:19.398948258 828 29 
2017.10.22D10:48:19.423751706 141 31 
2017.10.22D10:48:19.471307742 547 26
..


/ And generate some random logged calls
q)calls:([] time:(.z.p - timerange)+asc calls?timerange; id:calls?key startcpu; severity:calls?1 2 3)
q)\t calls:([] time:(.z.p - timerange)+asc calls?timerange; id:calls?key startcpu; severity:calls?1 2 3)
0
q)calls
time                          id  severity
------------------------------------------
2017.10.22D11:08:42.018613608 990 1       
2017.10.22D11:08:45.231430621 33  2       
2017.10.22D11:08:45.684254558 843 1       
2017.10.22D11:10:05.373019667 16  2       
2017.10.22D11:12:55.871893705 776 3       
2017.10.22D11:15:18.955607654 529 3       
2017.10.22D11:19:06.504665108 766 1       
2017.10.22D11:23:11.272196860 547 1       
2017.10.22D11:24:00.973999293 198 3       
2017.10.22D11:25:06.457651348 897 3       
2017.10.22D11:28:59.140456857 834 2       
2017.10.22D11:30:28.830475302 10  1       
2017.10.22D11:32:26.629373671 510 1       
2017.10.22D11:32:29.318958761 708 3       
2017.10.22D11:34:11.592896075 222 2       
2017.10.22D11:35:02.932388277 128 1       
2017.10.22D11:36:03.968367816 688 2       
2017.10.22D11:37:05.252384634 349 1       
2017.10.22D11:46:59.566099287 576 2       
2017.10.22D11:52:54.232250394 587 1       
..


/ create a lookup table of computer information
q)computerlookup
id| dept        os   
--| -----------------
0 | trading     win8 
1 | trading     osx  
2 | management  win7 
3 | finance     vista
4 | packing     win8 
5 | telesales   vista
6 | hoopjumping win8 
7 | trading     vista
8 | finance     vista
9 | hoopjumping win7 
10| trading     win7 
11| trading     win8 
12| packing     osx  
13| finance     win7 
14| trading     vista
15| telesales   win7 
16| management  win7 
17| telesales   win7 
18| telesales   win7 
19| finance     win8 
..


/ Counts for the number of values in each table
q)tables[]!count each value each tables[]
calls         | 3000
computer      | 7200000
computerlookup| 1000

/ IN-MEMORY QUERYING
/ Q is much used to aggregate across large datasets
/ For these examples, we will use simple aggregators (max, min, avg) and concentrate on doing complex things in the by-clause
/ One of the most powerful aspects of q is its ability to extend the query language with user-defined functions – so users can easily build custom aggregators

/ QUERY1: calculate the max, min and average CPU usage for every machine
q)select mxc:max cpu, mnc:min cpu, avc:avg cpu by id from computer
id| mxc mnc avc     
--| ----------------
0 | 63  3   22.92236
1 | 42  3   4.679444
2 | 37  3   4.239167
3 | 130 3   43.28028
4 | 164 3   90.65319
5 | 56  3   6.349028
6 | 96  3   30.41361
7 | 128 3   23.44333
8 | 38  3   5.708611
9 | 34  3   4.087083
10| 277 22  182.6868
11| 100 3   34.71819
12| 86  3   23.56208
13| 41  3   4.525556
14| 98  3   42.19194
15| 69  3   17.41194
16| 114 3   57.37722
17| 200 38  106.2444
18| 157 3   79.74806
19| 62  3   21.31347
..

/ QUERY2: We can also do this for every date, by extracting the date component from the time field
q)select mxc: max cpu, mnc: min cpu, avc: avg cpu by id, time.date from computer 
id date      | mxc mnc avc     
-------------| ----------------
0  2017.10.27| 42  17  28.23311
0  2017.10.28| 34  3   13.42222
0  2017.10.29| 10  3   3.145732
0  2017.10.30| 58  3   35.33773
0  2017.10.31| 63  8   34.42292
0  2017.11.01| 48  9   28.3243 
1  2017.10.27| 42  20  31.28041
1  2017.10.28| 29  3   3.471528
1  2017.10.29| 9   3   3.081944
1  2017.10.30| 7   3   3.051389
1  2017.10.31| 20  3   4.977793
1  2017.11.01| 3   3   3       
2  2017.10.27| 37  5   18.39731
2  2017.10.28| 23  3   6.020139
2  2017.10.29| 3   3   3       
2  2017.10.30| 3   3   3       
2  2017.10.31| 3   3   3       
2  2017.11.01| 3   3   3       
3  2017.10.27| 40  3   22.65203
3  2017.10.28| 48  3   15.72014
..

/ QUERY3: combine the aggregations to aggregate across each hour in each date separately
q)select mxc: max cpu, mnc: min cpu, avc: avg cpu by id, time.date, time.hh from computer
id date       hh| mxc mnc avc     
----------------| ----------------
0  2017.10.27 19| 42  25  34.53571
0  2017.10.27 20| 26  17  22.36667
0  2017.10.27 21| 32  20  25.53333
0  2017.10.27 22| 38  30  34.13333
0  2017.10.27 23| 38  19  25.01667
0  2017.10.28 0 | 25  15  20.7    
0  2017.10.28 1 | 33  22  28.42623
0  2017.10.28 2 | 30  8   18.9322 
0  2017.10.28 3 | 17  6   9.95082 
0  2017.10.28 4 | 27  14  20.71186
0  2017.10.28 5 | 26  17  21.08333
0  2017.10.28 6 | 31  17  25.11667
0  2017.10.28 7 | 19  8   12.95   
0  2017.10.28 8 | 18  11  14.08333
0  2017.10.28 9 | 22  9   16.76667
0  2017.10.28 10| 34  19  27.04918
0  2017.10.28 11| 32  14  18.66102
0  2017.10.28 12| 19  11  14.88333
0  2017.10.28 13| 18  7   13.46667
0  2017.10.28 14| 17  3   8.916667
..

/ QUERY4: use the xbar keyword to break the time list into buckets of any size
/ This is equivalent to the by id,time.date,time.hh query above, but is more efficient and has extra flexibility – the bucketing can be any size, 
/ all the way down to nanoseconds
q))select mxc:max cpu,mnc:min cpu,avc:avg cpu by id,0D01:00:00.0 xbar time from computer
id time                         | mxc mnc avc     
--------------------------------| ----------------
0  2017.10.27D19:00:00.000000000| 42  25  34.53571
0  2017.10.27D20:00:00.000000000| 26  17  22.36667
0  2017.10.27D21:00:00.000000000| 32  20  25.53333
0  2017.10.27D22:00:00.000000000| 38  30  34.13333
0  2017.10.27D23:00:00.000000000| 38  19  25.01667
0  2017.10.28D00:00:00.000000000| 25  15  20.7    
0  2017.10.28D01:00:00.000000000| 33  22  28.42623
0  2017.10.28D02:00:00.000000000| 30  8   18.9322 
0  2017.10.28D03:00:00.000000000| 17  6   9.95082 
0  2017.10.28D04:00:00.000000000| 27  14  20.71186
0  2017.10.28D05:00:00.000000000| 26  17  21.08333
0  2017.10.28D06:00:00.000000000| 31  17  25.11667
0  2017.10.28D07:00:00.000000000| 19  8   12.95   
0  2017.10.28D08:00:00.000000000| 18  11  14.08333
0  2017.10.28D09:00:00.000000000| 22  9   16.76667
0  2017.10.28D10:00:00.000000000| 34  19  27.04918
0  2017.10.28D11:00:00.000000000| 32  14  18.66102
0  2017.10.28D12:00:00.000000000| 19  11  14.88333
0  2017.10.28D13:00:00.000000000| 18  7   13.46667
0  2017.10.28D14:00:00.000000000| 17  3   8.916667
..

/QUERY5: Another approach to breaking up the day might be to define a set of “daily periods”, 
/ e.g. early morning is from 00:00 to 07:00, midmorning is from 07:00 to 12:00, lunch is from 12:00 to 13:30, afternoon is from 13:30 to 17:00 and evening is after 17:00. 
/ We can aggregate the data according to these groupings by creating a function to map a minute value to a period of the day. 
/ This user-defined function drops in to the select statement in the same way as any built-in function.
q)select mxc:max cpu,mnc:min cpu,avc:avg cpu by id, time.date, tod:timeofday[time.minute] from computer
id date       tod       | mxc mnc avc     
------------------------| ----------------
0  2017.10.27 4evening  | 42  17  28.23311
0  2017.10.28 0earlymorn| 33  6   20.7    
0  2017.10.28 1midmorn  | 34  8   17.93   
0  2017.10.28 2lunch    | 19  7   14.20879
0  2017.10.28 3afternoon| 19  3   11.20476
0  2017.10.28 4evening  | 12  3   3.840095
0  2017.10.29 0earlymorn| 3   3   3       
0  2017.10.29 1midmorn  | 3   3   3       
0  2017.10.29 2lunch    | 3   3   3       
0  2017.10.29 3afternoon| 10  3   3.895238
0  2017.10.29 4evening  | 7   3   3.052257
0  2017.10.30 0earlymorn| 47  3   19.91169
0  2017.10.30 1midmorn  | 58  29  47.45183
0  2017.10.30 2lunch    | 56  41  48.31461
0  2017.10.30 3afternoon| 56  22  38.20379
0  2017.10.30 4evening  | 57  21  37.86158
0  2017.10.31 0earlymorn| 63  31  49.23571
0  2017.10.31 1midmorn  | 44  11  26.86711
0  2017.10.31 2lunch    | 18  8   13.10112
0  2017.10.31 3afternoon| 33  16  24.02381
..

/QUERY6: We can also generate an average usage profile in the date range for each time of day across all desktop machines. 
/ First, we aggregate the data and calculate the totals for each day in each time period. 
/ Then, we re-aggregate the data to get an average usage across all days.
q))select avc:sum[cpu]%sum samplecount by tod from select sum cpu, samplecount:count cpu by time.date, tod:timeofday[time.minute] from computer
tod       | avc     
----------| --------
0earlymorn| 47.85624
1midmorn  | 49.49552
2lunch    | 50.5449 
3afternoon| 51.07913
4evening  | 48.29326

















