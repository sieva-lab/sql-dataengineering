/**
 * SUBJECT: 7-Day Rolling Average Analysis
 * * DESCRIPTION:
 * This script calculates a moving average to smooth out daily volatility (noise)
 * and identify underlying trends within the high-volume 'big_sales' dataset.
 * * LOGIC:
 * 1. Aggregation: Summarize raw transactional data into daily revenue totals.
 * 2. Windowing: Apply a sliding window to calculate the mean over a 7-day period.
 * * WINDOW FRAME MECHANICS (e.g., 3-day window):
 * - Day 1: Avg([D1])
 * - Day 2: Avg([D1, D2])
 * - Day 3: Avg([D1, D2, D3])
 * - Day 4: Avg([D2, D3, D4]) -> The window "slides" forward.
 * * SQL SYNTAX:
 * ROWS BETWEEN 6 PRECEDING AND CURRENT ROW defines a frame consisting of 
 * the 6 prior rows plus the active record, totaling 7 data points.
 */

 /* Step 1: Aggregate daily revenue from the 'big_sales' dataset.
  * Step 2: Calculate the 7-day moving average using a window function.
  * Step 3: Output the results for analysis.
*/  


WITH cte_daily_revenue AS (
    SELECT
        DATE(sale_date) AS transaction_date,
        SUM(price) AS total_revenue
    FROM big_sales
    GROUP BY DATE(sale_date)
),cte_price_moving_average AS (
    SELECT
        transaction_date,
        total_revenue,
        AVG(total_revenue) OVER (
            ORDER BY transaction_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS seven_day_moving_avg
    FROM cte_daily_revenue
)
SELECT * FROM price_moving_average;
