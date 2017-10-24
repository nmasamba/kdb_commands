
/ Create a simple table called tab which contains 1mil rows, 4 columns of random time series data 
q)n:1000000;
q)item:`apple`banana`orange`pear;
q)city:`beijing`chicago`london`paris;
q)tab: ([]time:asc n?0D0; n?item; amount:n?100; n?city);

/ Find all rows from the table where the item sold is a banana.
/ Note that all columns in the table are returned in the result when there is no column explicitly mentioned.
q)select from tab where item=`banana
time                 item   amount city   
------------------------------------------
0D00:00:00.048360228 banana 62     beijing
0D00:00:00.159745663 banana 27     london 
0D00:00:00.480262935 banana 40     london 
0D00:00:00.548035651 banana 32     chicago
0D00:00:00.705146044 banana 22     paris  
0D00:00:00.712388008 banana 98     london 
0D00:00:00.958473980 banana 48     paris  
0D00:00:01.071770489 banana 40     london 
0D00:00:01.319606602 banana 4      beijing
0D00:00:01.370139420 banana 65     chicago
0D00:00:01.408984512 banana 83     london 
0D00:00:01.890353858 banana 76     paris  
0D00:00:02.232053875 banana 63     beijing
0D00:00:02.458868175 banana 65     chicago
0D00:00:02.878721058 banana 80     paris  
0D00:00:03.401349484 banana 18     london 
0D00:00:03.690867125 banana 39     beijing
0D00:00:03.877729922 banana 62     chicago
0D00:00:04.152683168 banana 90     chicago
0D00:00:04.457911849 banana 65     paris  

/ AGGREGATE QUERY
/ Calculate the sum of the amounts sold of all items by each city
q)select sum amount by city from tab
city   | amount  
-------| --------
beijing| 12418161
chicago| 12342736
london | 12367712
paris  | 12383797

/ TIME SERIES AGGREGATE QUERY
/ Show the sum of the amount of each item sold by hour during the day.
hh item  | amount
---------| ------
0  apple | 526212
0  banana| 507660
0  orange| 502360
0  pear  | 511619
1  apple | 513634
1  banana| 508256
1  orange| 523457
1  pear  | 516540
2  apple | 505669
2  banana| 512270
2  orange| 513962
2  pear  | 523245
3  apple | 523114
3  banana| 511499
3  orange| 510569
3  pear  | 517673
4  apple | 521745
4  banana| 516055
4  orange| 518225
4  pear  | 513618
..




