--Movies

CREATE VIEW IF NOT EXISTS movies_with_language
  (id, name, language) AS
  SELECT movies.id AS id, movies.name AS name, languages.code AS language
    FROM movies
    INNER JOIN languages ON movies.language_id = languages.id;
    
CREATE VIEW IF NOT EXISTS genres_for_movie
    (id, movie_id, genre_id, genre_name) AS
    SELECT movies_genres.id AS id, movie_id, genre_id, genres.name AS genre_name
        FROM movies_genres
        INNER JOIN genres ON movies_genres.genre_id = genres.id;

--Shows

CREATE VIEW IF NOT EXISTS shows_with_seasons
    (id, name, language, creator, network) AS
    SELECT series.id AS id, series.name AS name, 
    languages.code AS language, participants.name AS creator, 
    series.network AS network
        FROM series
        INNER JOIN languages ON series.language_id = languages.id
        INNER JOIN participants ON series.creator_id = participants.id;
        
CREATE VIEW IF NOT EXISTS episodes_with_date
    (id, name, released) AS        
    SELECT episodes.id AS id, episodes.name AS name, episodes.released AS released; 
        
        
CREATE VIEW IF NOT EXISTS episodes_with_seasons
    (id, series_id, name, season, number, released) AS
    SELECT episodes.id AS id, episodes.series_id AS series_id,  episodes.name AS name, episodes.season_id AS season,
    episodes.number AS number, episodes.released AS released
        FROM episodes
        INNER JOIN seasons ON episodes.season_id = seasons.number;         