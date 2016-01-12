INSERT INTO languages (code) VALUES ("EN");
INSERT INTO languages (code) VALUES ("DE");

INSERT INTO participants (name) VALUES ("J. J. Abrams");

INSERT INTO series (name, language_id, creator_id, network) 
    VALUES ("Lost", 1, 1, "ABC");
    
INSERT INTO seasons (number, series_id) VALUES (1, 1);

-- YYYY-MM-DD HH:MM:SS.SSS 

INSERT INTO episodes (series_id, season_id, name, number, released) 
    VALUES (1, 1, "Pilot: Part 1/2", 1, "2004-09-22");

INSERT INTO episodes (series_id, season_id, name, number, released) 
    VALUES (1, 1, "Pilot: Part 2/2", 2, "2004-09-29");
    
INSERT INTO episodes (series_id, season_id, name, number, released) 
    VALUES (1, 1, "Tabula Rasa", 3, "2004-10-06");
    
INSERT INTO episodes (series_id, season_id, name, number, released) 
    VALUES (1, 1, "Walkabout", 4, "2004-10-13");
       