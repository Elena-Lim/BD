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

CREATE TABLE IF NOT EXISTS Songs (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	duration INTEGER,
	Album_id INTEGER REFERENCES Album(id)
);

CREATE TABLE IF NOT EXISTS Collection (
	id SERIAL PRIMARY KEY,
	name VARCHAR(40) NOT NULL,
	year_of INTEGER NOT NULL,
);

CREATE TABLE IF NOT EXISTS SongsCollection (
	Songs_id INTEGER REFERENCES Songs(id),
	Collection_id INTEGER REFERENCES Collection(id),
	CONSTRAINT pk_SongsCollection PRIMARY KEY (Songs_id, Collection_id)
);
