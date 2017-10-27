
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











