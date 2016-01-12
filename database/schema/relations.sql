CREATE TABLE IF NOT EXISTS epsiodes_participants (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  episode_id INTEGER,
  participants_id INTEGER,
  role TEXT,

  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (episode_id) REFERENCES episodes (id),
  FOREIGN KEY (participants_id) REFERENCES participants (id)
);

CREATE TRIGGER IF NOT EXISTS epsiodes_participants_updated_at_trigger
  BEFORE UPDATE ON epsiodes_participants BEGIN
    UPDATE epsiodes_participants SET updated_at = CURRENT_TIMESTAMP;
  END;


CREATE TABLE IF NOT EXISTS movies_participants (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  movie_id INTEGER,
  participants_id INTEGER,
  role TEXT,

  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (movie_id) REFERENCES movies (id),
  FOREIGN KEY (participants_id) REFERENCES participants (id)
);

CREATE TRIGGER IF NOT EXISTS movies_participants_updated_at_trigger
  BEFORE UPDATE ON movies_participants BEGIN
    UPDATE movies_participants SET updated_at = CURRENT_TIMESTAMP;
  END;

CREATE TABLE IF NOT EXISTS movies_genres (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  movie_id INTEGER,
  genre_id INTEGER,

  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (movie_id) REFERENCES movies (id),
  FOREIGN KEY (genre_id) REFERENCES genres (id)
);

CREATE TRIGGER IF NOT EXISTS movies_genres_updated_at_trigger
  BEFORE UPDATE ON movies_genres BEGIN
    UPDATE movies_genres SET updated_at = CURRENT_TIMESTAMP;
  END;


CREATE TABLE IF NOT EXISTS series_genres (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  series_id INTEGER,
  genre_id INTEGER,

  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (series_id) REFERENCES series (id),
  FOREIGN KEY (genre_id) REFERENCES genres (id)
);

CREATE TRIGGER IF NOT EXISTS series_genres_updated_at_trigger
  BEFORE UPDATE ON series_genres BEGIN
    UPDATE series_genres SET updated_at = CURRENT_TIMESTAMP;
  END;
  
CREATE TABLE IF NOT EXISTS series_seasons (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    series_id INTEGER,
    season_id INTEGER,
    
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  
    FOREIGN KEY (series_id) REFERENCES series (id),
    FOREIGN KEY (season_id) REFERENCES seasons (id)
);

CREATE TRIGGER IF NOT EXISTS series_seasons_updated_at_trigger
  BEFORE UPDATE ON series_genres BEGIN
    UPDATE series_seasons SET updated_at = CURRENT_TIMESTAMP;
  END;