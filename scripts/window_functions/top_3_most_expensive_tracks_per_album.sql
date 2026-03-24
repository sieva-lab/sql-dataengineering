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
