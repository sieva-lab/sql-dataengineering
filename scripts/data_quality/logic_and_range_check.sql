/**
 * TEST: Out-of-Bounds Values
 * DESCRIPTION: Checks for negative prices or future-dated sales.
 */
SELECT 
    'Negative Price' as issue_type,
    COUNT(*) as issue_count
FROM big_sales 
WHERE COALESCE(price,-1) < 0

UNION ALL

SELECT 
    'Future Sale Date',
    COUNT(*)
FROM big_sales 
WHERE COALESCE(sale_date, '9999-12-31') > now();