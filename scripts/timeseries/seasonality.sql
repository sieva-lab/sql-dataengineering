/**
 * SUBJECT: Time Series Aggregation (Seasonality Analysis)
 * DESCRIPTION: 
 * Grouping 1M+ rows into monthly and weekly buckets to identify 
 * high-level sales trends using DATE_TRUNC.
 */

-- 1. Monthly Trend
SELECT 
    date_trunc('month', sale_date) as sales_month,
    COUNT(*) as total_transactions,
    SUM(price) as monthly_revenue,
    -- Average transaction value for the month
    AVG(price) as avg_transaction_value
FROM big_sales
GROUP BY 1
ORDER BY 1;

-- 2. Day of the Week Analysis (Is it busier on weekends?)
SELECT 
    dayname(sale_date) as day_of_week,
    count(*) as total_sales
FROM big_sales
GROUP BY 1, dayofweek(sale_date)
ORDER BY dayofweek(sale_date);