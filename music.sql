CREATE TABLE IF NOT EXISTS genres (
	genre_id serial PRIMARY KEY,
	genre_name varchar(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS musicians (
	musician_id serial PRIMARY KEY,
	musician_name varchar(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS genres_musicians (
	genre_musician_id serial PRIMARY KEY,
	genre_id int REFERENCES genres(genre_id),
	musician_id int REFERENCES musicians(musician_id)
);

CREATE TABLE IF NOT EXISTS albums (
	album_id serial PRIMARY KEY,
	album_name varchar(50) NOT NULL,
	album_year int NOT NULL
);

CREATE TABLE IF NOT EXISTS musicians_albums (
	musician_album_id serial PRIMARY KEY,
	musician_id int REFERENCES musicians(musician_id),
	album_id int REFERENCES albums(album_id)
);

CREATE TABLE IF NOT EXISTS tracks (
	track_id serial PRIMARY KEY,
	track_name varchar(50) NOT NULL,
	track_duration int NOT NULL,
	album_id int REFERENCES albums(album_id)
);

CREATE TABLE IF NOT EXISTS collections (
	collection_id serial PRIMARY KEY,
	collection_name varchar(50) NOT NULL,
	collection_year int NOT NULL
);

CREATE TABLE IF NOT EXISTS collections_tracks (
	collections_tracks_id serial PRIMARY KEY,
	collection_id int REFERENCES collections(collection_id),
	track_id int REFERENCES tracks(track_id)
);


--insert

INSERT INTO genres
(genre_name)
VALUES
('Rap'), 
('Pop'), 
('Rock'), 
('Punk');

INSERT INTO musicians
(musician_name)
VALUES
('Ramstein'), 
('Linkin Park'), 
('Король и шут'), 
('Баста'), 
('Zivert');

INSERT INTO genres_musicians
(genre_id, musician_id)
VALUES
(1, 5),
(2, 4),
(3, 1),
(4, 3),
(3, 2);

INSERT INTO albums
(album_name, album_year)
VALUES
('Будь как дома путник', 1997),
('БАСТА 1', 2006), 
('Vinyl #2', 2021), 
('Rammstein', 2019), 
('Meteora', 2003);

INSERT INTO tracks
(track_name, track_duration, album_id)
VALUES
('Forever Young', 180, 3), 
('Я устал', 228, 1), 
('Rammstein', 206, 4), 
('Pushing My Away', 191, 5), 
('Вечно молодой Мой', 268, 2), 
('Numb', 187, 5);

INSERT INTO musicians_albums
(musician_id, album_id)
VALUES
(1, 4), 
(2, 5), 
(3, 1), 
(5, 3), 
(4, 2);

INSERT INTO collections
(collection_name, collection_year)
VALUES
('Наивные песни', 2005), 
('Поколение Брат', 2022), 
('Lost Highway', 1997), 
('Valentine', 2001);

INSERT INTO collections_tracks
(collection_id, track_id)
VALUES
(1, 1), 
(2, 2), 
(3, 4), 
(4, 5);

--select_1

SELECT track_name, track_duration
FROM tracks
WHERE track_duration = (SELECT MAX(track_duration) FROM tracks);

SELECT track_name, track_duration
FROM tracks
WHERE track_duration >= 210;

SELECT collection_name, collection_year 
FROM collections
WHERE collection_year BETWEEN 2018 AND 2022;

SELECT musician_name
FROM musicians
WHERE musician_name NOT LIKE '% %';

SELECT track_name
FROM tracks
WHERE LOWER(track_name) LIKE 'мой %' or LOWER(track_name) LIKE '% мой' OR LOWER(track_name) LIKE '% мой %' or lower(track_name) LIKE 'мой' 
OR LOWER(track_name) LIKE 'my %' or lower(track_name) LIKE '% my' OR LOWER(track_name) LIKE '% my %' or lower(track_name) LIKE 'my';


--select_2

SELECT genre_name, COUNT (musician_name) FROM musicians m 
JOIN genres_musicians gm  ON m.musician_id = gm.musician_id 
JOIN genres g ON gm.genre_id = g.genre_id 
GROUP BY g.genre_id;

SELECT COUNT(track_name) FROM tracks t 
JOIN albums a on a.album_id = t.album_id 
WHERE a.album_year BETWEEN 2019 AND 2020;

SELECT album_name, AVG(track_duration) FROM tracks t 
JOIN albums a ON a.album_id = t.album_id 
GROUP BY a.album_name;

SELECT musician_name FROM musicians m 
WHERE musician_name NOT IN (
SELECT musician_name FROM albums a 
JOIN musicians_albums ma ON a.album_id = ma.album_id 
JOIN musicians m ON ma.musician_id = m.musician_id
WHERE a.album_year = 2020);

select collection_name from collections c 
join collections_tracks ct on c.collection_id = ct.collection_id 
join tracks t on ct.track_id = t.track_id 
join albums a on t.album_id = a.album_id 
join musicians_albums ma on a.album_id = ma.album_id 
join musicians m on ma.musician_id = m.musician_id 
where m.musician_name = 'Ramstein'
