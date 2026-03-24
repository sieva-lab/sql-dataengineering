-- Who are the top 3 artists per genre based on the number of tracks they have in the database?
-- In case of ties, it orders by ArtistId to ensure consistent results.
WITH artist_track_counts AS (
    SELECT
        a.ArtistId as artist_id,
        a.Name AS artist_name,
        g.GenreId as genre_id,
        g.Name AS genre_name,
        COUNT(t.TrackId) AS track_count
    FROM artists a
    JOIN albums al ON a.ArtistId = al.ArtistId
    JOIN tracks t ON al.AlbumId = t.AlbumId
    JOIN genres g ON t.GenreId = g.GenreId
    GROUP BY a.ArtistId, a.Name, g.GenreId, g.Name
),
ranked_artists AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY genre_id ORDER BY track_count DESC, artist_id ASC) AS rownumber
    FROM artist_track_counts
)
SELECT
    genre_name,
    artist_name,
    track_count
FROM ranked_artists
WHERE rownumber <= 3
ORDER BY genre_name, track_count DESC;