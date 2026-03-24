# Window functions


## LAG and LEAD

### Use cases:  
  * 1. Daily Performance Tracking: Monitor day-to-day revenue changes.
  * 2. Trend Analysis: Identify patterns in sales growth or decline.
  * 3. Anomaly Detection: Spot unusual spikes or drops in daily sales.
  * 4. Business Insights: Inform strategic decisions based on revenue trends.



## Difference between ROWS and OFFSET

###  1. Physical frames (ROWS BETWEEN)
 * Used for: Aggregates like AVG(), SUM(), COUNT().
 * Logic: Defines a "pool" of multiple rows. The function calculates 
 * one value based on all rows inside that pool.
 * Example: ROWS BETWEEN 6 PRECEDING AND CURRENT ROW (A 7-row bucket).
 
 ### 2. Relative offsets (LEAD / LAG)
 * Used for: Navigation functions.
 * Logic: Points to exactly ONE specific row at a fixed distance. 
 * It does not care about the rows in between.
 * Example: LAG(column, 1) looks exactly 1 row back.
 