/**
 * SUBJECT: Daily Sales Variance Analysis (Period-over-Period)
 * DESCRIPTION:
 * Uses the LAG function to compare today's revenue with yesterday's.
 * This identifies daily growth or decline trends.
 */


 /* Step 1: Aggregate daily revenue from the 'big_sales' dataset.
  * Step 2: Use LAG to access the previous day's revenue for variance calculation.
  * Step 3: Calculate both absolute variance and percentage growth for insights.
  */


WITH daily_revenue AS (
    SELECT 
        sale_date::DATE as sales_date,
        SUM(price) as daily_total
    FROM big_sales
    GROUP BY 1
), cte_variance_calculation AS (
    SELECT 
        sales_date,
        daily_total,
        -- Get the previous day's revenue using LAG
        LAG(daily_total) OVER (ORDER BY sales_date) as prev_day_revenue
    FROM daily_revenue
), cte_final_output AS (
    SELECT 
        sales_date,
        daily_total,
        prev_day_revenue,
        -- Calculate the absolute variance
        daily_total - prev_day_revenue as variance,
        -- Calculate the percentage growth
        ROUND(
            (daily_total - prev_day_revenue) / 
            NULLIF(prev_day_revenue, 0) * 100, 
        2) as percentage_growth
    FROM cte_variance_calculation
)
SELECT  sales_date,
        daily_total,
        prev_day_revenue,
        variance,
        percentage_growth
FROM cte_final_output
ORDER BY sales_date;