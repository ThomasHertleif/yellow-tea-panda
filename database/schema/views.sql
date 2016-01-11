DROP VIEW movies_with_language;

CREATE VIEW IF NOT EXISTS movies_with_language
  (id, name, language) AS
  SELECT movies.id AS id, movies.name AS name, languages.code AS language
    FROM movies
    INNER JOIN languages ON movies.language_id = languages.id;
