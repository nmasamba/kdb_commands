
/ Create a table cities with columns city and state, keyed to city.
q)cities: ([city:`NewYork`LosAngeles`Detroit]; state:`NY`CA`MI)
q)cities
city      | state
----------| -----
NewYork   | NY   
LosAngeles| CA   
Detroit   | MI 

/ Create an unkeyed table sales with columns city and sale.
q)sales:([] city:`NewYork`Delaware`Miami; sale:200 100 50)
q)sales
city     sale
-------------
NewYork  200 
Delaware 100 
Miami    50  

/ Join the tables to show the state for each sale. Your result will be an unkeyed table with columns city, sale, and state.
q)sales lj cities
city     sale state
-------------------
NewYork  200  NY   
Delaware 100       
Miami    50 

q)sales ij cities
city    sale state
------------------
NewYork 200  NY

/ Report the total sales, by state. Your result will be a table with columns state and sale, keyed to state, with a row for each unique state in the result from (3).
q)agg1: select sale by state from sales ij cities
q)agg1
state| sale
-----| ----
NY   | 200 
q)agg2: select sum sale by state from agg1
q)agg2
state| sale
-----| ----
NY   | 200 