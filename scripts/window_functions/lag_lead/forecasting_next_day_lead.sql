/**
 * SUBJECT: Next-Day Forecast Variance (Using LEAD)
 * DESCRIPTION: 
 * Compares current daily totals with the subsequent day's results.
 * Useful for identifying upcoming trends or preparation for sales shifts.
 */


/* Step 1: Aggregate daily revenue from the 'big_sales' dataset.
 * Step 2: Use LEAD to access the next day's revenue for forecasting.
 * Step 3: Calculate both absolute and percentage changes for insights.
*/

WITH daily_revenue AS (
    SELECT 
        sale_date::DATE as sales_date,
        SUM(price) as daily_total
    FROM big_sales
    GROUP BY 1
),
cte_forward_comparison AS (
    SELECT 
        sales_date,
        daily_total,
        -- Get tomorrow's revenue using LEAD
        LEAD(daily_total) OVER (ORDER BY sales_date) as next_day_revenue
    FROM daily_revenue
)
SELECT 
    sales_date,
    daily_total as today_revenue,
    next_day_revenue as tomorrow_forecast,
    -- Difference between today and tomorrow
    next_day_revenue - daily_total as absolute_change,
    -- Percentage change towards tomorrow
    ROUND(
        (next_day_revenue - daily_total) / 
        NULLIF(daily_total, 0) * 100, 
    2) as projected_growth_pct
FROM cte_forward_comparison
ORDER BY sales_date;