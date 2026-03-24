-- Calculate the daily sales revenue and use LAG and LEAD to find the revenue of yesterday and tomorrow

WITH daily_stats AS (
    SELECT 
        sale_date::DATE as sale_date,
        ROUND(SUM(price), 2) as revenue
    FROM big_sales
    GROUP BY 1
)
SELECT 
    sale_date,
    LAG(revenue)  OVER (ORDER BY sale_date) as yesterday,
    revenue                             as today,
    LEAD(revenue) OVER (ORDER BY sale_date) as tomorrow

FROM daily_stats
ORDER BY sale_date
