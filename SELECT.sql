SELECT genre_id, COUNT(genre_id) FROM GenrePerformer
     GROUP BY genre_id;

SELECT Song.name, year_of_issue FROM Song 
JOIN Album ON Song.id = Album.id WHERE year_of_issue >= 2000; 

SELECT Album.name, AVG(Song.duration) FROM Album
JOIN Song ON Album.id = album_id
GROUP BY Album.id

SELECT Performer.name, Album.year_of_issue FROM Performer
JOIN AlbumPerformer ON Performer.id = performer_id
JOIN Album ON album_id = Album.id
WHERE NOT Album.year_of_issue BETWEEN 1990 AND 2010;

SELECT Collection.name, Performer.name FROM Collection
JOIN SongCollection ON Collection.id = collection_id
JOIN Song ON song_id = Song.id
JOIN Album ON Song.album_id = Album.id
JOIN AlbumPerformer ON Album.id = AlbumPerformer.album_id
JOIN Performer ON performer_id = Performer_id
WHERE Performer.name = 'Frank Sinatra'

SELECT Album.name, Performer.name, Genre.name FROM ALBUM
JOIN AlbumPerformer as AP ON Album.id = AP.album_id
JOIN Performer ON AP.performer_id = Performer.id
JOIN GenrePerformer as GP ON Performer.id = GP.performer_id
JOIN Genre ON GP.genre_id = Genre.id
WHERE GP.performer_id = 
	(SELECT performer_id FROM GenrePerformer
		GROUP BY performer_id
		HAVING COUNT(performer_id) > 1);

SELECT Song.name, SC.collection_id FROM Song
LEFT JOIN SongCollection as SC ON Song.id = SC.song_id
WHERE SC.collection_id IS NULL;

SELECT Performer.name, Song.name, Song.duration FROM Performer
JOIN AlbumPerformer as AP ON Performer.id = AP.performer_id
JOIN Album ON AP.album_id = Album.id
JOIN Song ON Album.id = Song.album_id
WHERE Song.duration = 
		(SELECT MIN(duration) FROM SONG);

SELECT DISTINCT Album.name FROM Album
LEFT JOIN Song ON Song.album_id = Album.id
WHERE Song.album_id IN (
	SELECT album_id FROM Song
	GROUP BY album_id
	HAVING COUNT(id) = (
		SELECT COUNT(id) FROM Song
		GROUP BY album_id
		ORDER BY COUNT DESC
		LIMIT 1
	)
)
ORDER BY Album.name;
