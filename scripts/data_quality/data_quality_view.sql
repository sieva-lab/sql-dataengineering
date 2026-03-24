/**
 * VIEW: v_data_quality_report
 * DESCRIPTION: Persistent data quality monitor for the 1M record set.
 * LOGIC: Uses scalar subqueries to aggregate multiple quality metrics into one row.
 */
CREATE OR REPLACE VIEW v_data_quality_report AS
SELECT 
    SUM(CASE WHEN price < 0 OR price IS NULL THEN 1 ELSE 0 END) as invalid_prices,
    SUM(CASE WHEN sale_date > now() OR sale_date IS NULL THEN 1 ELSE 0 END) as future_sales,
    COUNT(DISTINCT track_id) as unique_tracks_sold
FROM big_sales;

SELECT * from v_data_quality_report;