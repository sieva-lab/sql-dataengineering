-- This query retrieves the top 3 most expensive tracks for each album in the Chinook database.
-- In case of ties in UnitPrice, it orders by TrackId to ensure consistent results.
with cte_ranked_tracks as (
    select 
        tracks.TrackId, 
        albums.AlbumId, 
        tracks.UnitPrice,
        ROW_NUMBER() OVER (PARTITION BY albums.AlbumId ORDER BY tracks.UnitPrice DESC, tracks.TrackId ASC) as row_num
    from chinook_dev.albums albums
    join chinook_dev.tracks tracks on albums.AlbumId = tracks.AlbumId
)
select  * from cte_ranked_tracks
where row_num <= 3
