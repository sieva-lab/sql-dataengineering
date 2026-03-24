WITH daily_stats AS (
    SELECT 
        sale_date::DATE as datum,
        ROUND(SUM(price), 2) as omzet
    FROM big_sales
    GROUP BY 1
)
SELECT 
    datum,
    LAG(omzet)  OVER (ORDER BY datum) as gisteren,
    omzet                             as vandaag,
    LEAD(omzet) OVER (ORDER BY datum) as morgen,
    -- Verschil met gisteren
    omzet - LAG(omzet) OVER (ORDER BY datum) as verschil_euro
FROM daily_stats
ORDER BY datum
LIMIT 10;