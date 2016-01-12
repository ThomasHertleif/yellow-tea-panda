CREATE VIEW IF NOT EXISTS movies_with_language
  (id, name, language) AS
  SELECT movies.id AS id, movies.name AS name, languages.code AS language
    FROM movies
    INNER JOIN languages ON movies.language_id = languages.id;


CREATE VIEW IF NOT EXISTS series_with_seasons
    (id, name, language, creator, network) AS
    SELECT series.id AS id, series.name AS name, 
    language.code AS language, series.creator AS creator, 
    series.network AS network
        FROM series
        INNER JOIN language ON series.language_id = language_id;
        
CREATE VIEW IF NOT EXISTS episodes_with_date
    (id, name, released) AS        
    SELECT episodes.id AS id, episodes.name AS name, episodes.released AS released; 
        
-- CREATE VIEW IF NOT EXISTS movies_with_genre
--     (id, name, genre)
--     SELECT movies.id AS id, movies.name AS name, movie_genre.genre AS genre
--         FROM movies
--         INNER JOIN genre ON movies_genre.genre = genre.id;                