CREATE TABLE IF NOT EXISTS Genre (
	id SERIAL PRIMARY KEY,
	name VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Musician (
	id SERIAL PRIMARY KEY,
	name VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS GenreMusician (
	Genre_id INTEGER REFERENCES Genre(id),
	Musician_id INTEGER REFERENCES Musician(id),
	CONSTRAINT pk_GenreMusician PRIMARY KEY (Genre_id, Musician_id)
);

CREATE TABLE IF NOT EXISTS Album (
	id SERIAL PRIMARY KEY,
	name VARCHAR (30) NOT NULL,
	year_of INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS AlbumMusician (
	Album_id INTEGER REFERENCES Album(id),
	Musician_id INTEGER REFERENCES Musician(id),
	CONSTRAINT pk_AlbumMusician PRIMARY KEY (Album_id, Musician_id)
);


--insert
INSERT INTO Genre
(name)
VALUES
('Rap'), 
('Pop'), 
('Rock'), 
('Punk');

INSERT INTO Musician
(name)
VALUES
('Ramstein'), 
('Linkin Park'), 
('Король и шут'), 
('Баста'), 
('Zivert');

INSERT INTO GenreMusician
(Genre_id, Musician_id)
VALUES
(1, 5),
(2, 4),
(3, 1),
(4, 3),
(3, 2);

INSERT INTO Album
(name, year_of)
VALUES
('Будь как дома путник', 1997),
('БАСТА 1', 2006), 
('Vinyl #2', 2021), 
('Rammstein', 2019), 
('Meteora', 2003);

INSERT INTO Songs
(name, duration, Album_id)
VALUES
('Forever Young', 180, 3), 
('Я устал', 228, 1), 
('Rammstein', 206, 4), 
('Pushing My Away', 191, 5), 
('Вечно молодой Мой', 268, 2), 
('Numb', 187, 5);

INSERT INTO AlbumMusician
(Musician_id, Album_id)
VALUES
(1, 4), 
(2, 5), 
(3, 1), 
(5, 3), 
(4, 2);

INSERT INTO Collection
(name, year_of)
VALUES
('Наивные песни', 2005), 
('Поколение Брат', 2022), 
('Lost Highway', 1997), 
('Valentine', 2001);

INSERT INTO SongsCollection
(Collection_id, Songs_id)
VALUES
(1, 1), 
(2, 2), 
(3, 4), 
(4, 5);


--select_1

SELECT name, duration
FROM Songs
WHERE duration = (SELECT MAX(duration) FROM Songs);

SELECT name, duration
FROM Songs
WHERE duration >= 210;

SELECT name, year_of 
FROM Collection
WHERE year_of BETWEEN 2018 AND 2022;

SELECT name
FROM Musician
WHERE name NOT LIKE '% %';

SELECT name
FROM Songs
WHERE LOWER(name) LIKE 'мой %' OR LOWER(name) LIKE '% мой' OR LOWER(name) LIKE '% мой %' OR LOWER(name) LIKE 'мой' 
OR LOWER(name) LIKE 'my %' OR LOWER(name) LIKE '% my' OR LOWER(name) LIKE '% my %' OR LOWER(name) LIKE 'my';


--select_2

SELECT albumname, COUNT(genrename) FROM album al
JOIN artistalbum aa ON al.albumid = aa.albumid
JOIN artist ar ON aa.artistid = ar.artistid
JOIN genreartist ga ON ar.artistid = ga.artistid
JOIN genre g ON ga.genreid = g.genreid
GROUP BY albumname
HAVING COUNT(genrename) > 1

SELECT name, COUNT (name) FROM Musician e
JOIN GenreMusician ge  ON e.Musician_id = ge.Musician_id 
JOIN Genre g ON ge.Genre_id = g.Genre_id 
GROUP BY g.Genre_id;

SELECT COUNT(name) FROM Songs t 
JOIN Album a ON a.Album_id = t.Album_id 
WHERE a.year_of BETWEEN 2019 AND 2020;

SELECT name, AVG(duration) FROM Songs t 
JOIN Album a ON a.Album_id = t.Album_id 
gROUP BY a.name;

SELECT name FROM Musician e 
WHERE name NOT IN (
SELECT name FROM Album a 
JOIN AlbumMusician ea ON a.Album_id = ea.Album_id 
JOIN Musician e ON ea.Musician_id = e.Musician_id
WHERE a.year_of = 2020);

SELECT name FROM Collection c 
JOIN SongsCollection ct ON c.Collection_id = ct.collection_id   
JOIN Songs t ON ct.Songs_id = t.Songs_id 
JOIN Album a ON t.Album_id = a.Album_id 
JOIN AlbumMusician ea ON a.Album_id = ea.Album_id 
JOIN Musician e ON ea.Musician_id = e.Musician_id 
WHERE e.name LIKE 'Ramstein';


CREATE TABLE IF NOT EXISTS Songs (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	duration INTEGER,
	Album_id INTEGER REFERENCES Album(id) 
);

CREATE TABLE IF NOT EXISTS Collection (   
	id SERIAL PRIMARY KEY,
	name VARCHAR(40) NOT NULL,
	year_of INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS SongsCollection (
	Songs_id INTEGER REFERENCES Songs(id),
	Collection_id INTEGER REFERENCES Collection(id),
	CONSTRAINT pk_SongsCollection PRIMARY KEY (Songs_id, Collection_id)
);
