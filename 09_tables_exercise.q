

/ 1. Make an unkeyed table with 3 columns: one for the days of the week (as symbols), one for the temperature (integers) and the last with string describing the weather
q)forecast:([] Day: `Mon`Tue`Wed; Temp: 12 15 20; Weather: `cloudy`clear`sunny) 
q)forecast
Day Temp Weather
----------------
Mon 12   cloudy 
Tue 15   clear  
Wed 20   sunny  

/2. Key the your table on the day columnn.
q)forecast: `Day xkey forecast
q)forecast
Day| Temp Weather
---| ------------
Mon| 12   cloudy 
Tue| 15   clear  
Wed| 20   sunny 

/3. Add a row to your (keyed) table with a fictional day of the week.
q)`forecast upsert (`Myhappyday; 25; `perfect)
`forecast
q)forecast
Day       | Temp Weather
----------| ------------
Mon       | 12   cloudy 
Tue       | 15   clear  
Wed       | 20   sunny  
Myhappyday| 25   perfect

/4. Replace the entry for Monday with a temperature of 1000 and the description "appallingly wet".
q)`forecast upsert (`Mon; 1000; `$"appallingly wet")
`forecast
q)forecast
Day       | Temp Weather        
----------| --------------------
Mon       | 1000 appallingly wet
Tue       | 15   clear          
Wed       | 20   sunny          
Myhappyday| 25   perfect 
