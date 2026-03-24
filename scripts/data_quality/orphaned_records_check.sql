/**
 * TEST: Referential Integrity
 * DESCRIPTION: Finds sales tied to non-existent TrackIds.
 */
SELECT 
    s.track_id,
    COUNT(*) as orphan_count
FROM big_sales s
LEFT JOIN tracks t ON s.track_id = t.TrackId
WHERE t.TrackId IS NULL
GROUP BY 1;