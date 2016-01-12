INSERT INTO languages (code) VALUES ("EN");
INSERT INTO languages (code) VALUES ("DE");
INSERT INTO movies (id, name, lenght, language_id) VALUES (1, "Ali G", 90, 1);

INSERT INTO genres (id, name) VALUES (1, "ACTIONFUN");
INSERT INTO movies_genres (movie_id, genre_id) VALUES (1, 1); 
