/* 
 * This query identifies the top 3 most expensive tracks for each album in the Chinook database.
 * It demonstrates the use of ROW_NUMBER, RANK, and DENSE_RANK window functions to handle ties in pricing.
 * The results are ordered by AlbumId, window function type, TrackId, UnitPrice, and rank number.

Step 1: Use a Common Table Expression (CTE) to calculate the row number, rank, and dense rank for tracks within each album based on their UnitPrice.
Step 2: Combine the results from the three window functions using UNION to get the top 3 tracks per album for each ranking method.
Step 3: Select and order the final results for analysis.


Row_NUMBER: Assigns a unique sequential integer to rows within a partition, even if there are ties in UnitPrice.
RANK: Assigns the same rank to rows with the same UnitPrice, but skips subsequent ranks for ties (e.g., if two tracks are tied for 1st place, the next track will be ranked 3rd).
DENSE_RANK: Similar to RANK, but does not skip ranks after ties (e.g., if two tracks are tied for 1st place, the next track will be ranked 2nd).

*/

with cte_tracks_rownumber as (
    select 
        tracks.TrackId, 
        albums.AlbumId, 
        tracks.UnitPrice,
        -- In case of ties in UnitPrice, we order by TrackId to ensure consistent results.
        ROW_NUMBER() OVER (PARTITION BY tracks.AlbumId ORDER BY tracks.UnitPrice DESC, tracks.TrackId ASC) as row_num,
        RANK() OVER (PARTITION BY tracks.AlbumId ORDER BY tracks.UnitPrice DESC, tracks.TrackId ASC) as rank_num,
        DENSE_RANK() OVER (PARTITION BY tracks.AlbumId ORDER BY tracks.UnitPrice DESC, tracks.TrackId ASC) as dense_rank_num
    from chinook_dev.tracks tracks
    join chinook_dev.albums albums on albums.AlbumId = tracks.AlbumId
),
cte_result as (
select  TrackId, AlbumId, UnitPrice, row_num as num, 'ROW_NUMBER' as window_function from cte_tracks_rownumber
where row_num <= 3
UNION
select  TrackId, AlbumId, UnitPrice, rank_num as num, 'RANK' as window_function from cte_tracks_rownumber
where rank_num <= 3
UNION
select  TrackId, AlbumId, UnitPrice, dense_rank_num as num, 'DENSE_RANK' as window_function from cte_tracks_rownumber
where dense_rank_num <= 3
)
select AlbumId, window_function, TrackId, UnitPrice, num from cte_result
order by AlbumId, window_function, TrackId, UnitPrice, num ASC;
