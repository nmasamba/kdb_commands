
/1. Create the populations dictionary (above). Find the ratio of the population of California to the population of Texas.
q)populations:`Texas`Florida`NewYork`Illinois`California!26448193 19552860 26448193 12882135 38332521
q)cal_pop: populations[`California]
q)tex_pop: populations[`Texas]
q)cal_pop % tex_pop
1.449344

/2. Find the state with the largest population. (max will return the largest value from a list or dictionary.)
q)populations?max populations
`California

/3. Create the following dictionary which maps numbers to strings:
q)jobs:(13+til 5)!("open";"closed";"pending";"cancelled";"stuck")
q)jobs
13| "open"
14| "closed"
15| "pending"
16| "cancelled"
17| "stuck"

/4. Edit jobs so that the values are now simply the first letter of each word:
q)jobs: first each jobs
q)jobs
13| o
14| c
15| p
16| c
17| s

/5. Create the following dictionary which has only one key-value pair.
/q)d
/a| "test"
q)d:(enlist `a)!enlist "test"
q)d
a| "test"