-- Find the title and artist who recorded the song 'Alison'.

SELECT title, artist
  FROM album JOIN track
         ON (album.asin=track.album)
 WHERE song = 'Alison'


-- Which artist recorded the song 'Exodus'?

SELECT artist
  FROM album JOIN track
         ON (album.asin=track.album)
 WHERE song = 'Exodus'

-- Show the song for each track on the album 'Blur'

SELECT song
  FROM album JOIN track
         ON (album.asin=track.album)
 WHERE album.title = 'Blur'

-- We can use the aggregate functions and GROUP BY expressions on the joined table.
-- For each album show the title and the total number of track.

SELECT title, COUNT(*)
  FROM album JOIN track ON (asin=album)
 GROUP BY title

-- For each album show the title and the total number of tracks containing the word 'Heart' (albums with no such tracks need not be shown).

SELECT album.title, COUNT(*)
  FROM album JOIN track
  ON album.asin = track.album
  WHERE track.song LIKE '%Heart%'
  GROUP BY album.title;

-- A "title track" is where the song is the same as the title. Find the title tracks.

SELECT track.song AS title_track
  FROM album JOIN track
  ON album.asin = track.album
  WHERE album.title = track.song;


-- An "eponymous" album is one where the title is the same as the artist (for example the album 'Blur' by the band 'Blur'). Show the eponymous albums.

SELECT album.title
  FROM album 
  WHERE album.title = album.artist

-- Find the songs that appear on more than 2 albums. Include a count of the number of times each shows up.

SELECT track.song, COUNT(DISTINCT track.album)
  FROM album JOIN track
  ON album.asin = track.album
  GROUP BY track.song

HAVING COUNT(DISTINCT track.album) > 2;

-- A "good value" album is one where the price per track is less than 50 pence. Find the good value album - show the title, the price and the number of tracks.

SELECT title, price, COUNT(song)
  FROM album JOIN track ON (album.asin = track.album)
  GROUP BY title, price
  HAVING price / COUNT(song) < 0.50;

-- Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101 tracks.

-- List albums so that the album with the most tracks is first. Show the title and the number of tracks
-- Where two or more albums have the same number of tracks you should order alphabetically
SELECT title, COUNT(asin)
  FROM album 
  JOIN track ON (asin = album)
  GROUP BY title, asin
  HAVING COUNT(asin) > 0
  ORDER BY COUNT(asin) DESC, title ASC;

