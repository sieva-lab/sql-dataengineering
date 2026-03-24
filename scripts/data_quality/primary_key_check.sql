/**
 * TEST: Duplicate Primary Keys
 * EXPECTATION: Zero rows returned.
 */
SELECT 
    sale_id, 
    COUNT(*) as occurrences
FROM big_sales
GROUP BY sale_id
HAVING COUNT(*) > 1;