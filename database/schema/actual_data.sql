CREATE TABLE IF NOT EXISTS movies (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT DEFAULT "" NOT NULL,
  lenght INTEGER,
  language_id INTEGER,
  released DATE,

  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (language_id) REFERENCES languages (id)
);

CREATE TRIGGER IF NOT EXISTS movies_updated_at_trigger
  BEFORE UPDATE ON movies BEGIN
    UPDATE movies SET updated_at = CURRENT_TIMESTAMP;
  END;


CREATE TABLE IF NOT EXISTS series (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT DEFAULT "" NOT NULL,
  language_id INTEGER,
  creator_id INTEGER,
  network TEXT DEFAUL "" NOT NULL,

  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (language_id) REFERENCES languages (id),
  FOREIGN KEY (creator_id) REFERENCES participants (id)
);

CREATE TRIGGER IF NOT EXISTS series_updated_at_trigger
  BEFORE UPDATE ON series BEGIN
    UPDATE series SET updated_at = CURRENT_TIMESTAMP;
  END;
  
  CREATE TABLE IF NOT EXISTS seasons (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      number INTEGER,
      series_id INTEGER,
      
      created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
      updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
      
      FOREIGN KEY (series_id) REFERENCES series(id)
  );
  
  CREATE TRIGGER IF NOT EXISTS seasons_updated_at_trigger
  BEFORE UPDATE ON series BEGIN
    UPDATE series SET updated_at = CURRENT_TIMESTAMP;
  END;
  
  CREATE TABLE IF NOT EXISTS episodes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      series_id INTEGER,
      season_id INTEGER,
      name TEXT DEFAULT "" NOT NULL,
      number INTEGER,
      released DATE,
      
      created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
      updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
      
      FOREIGN KEY (series_id) REFERENCES series(id),
      FOREIGN KEY (season_id) REFERENCES seasons(id)
);

CREATE TRIGGER IF NOT EXISTS episodes_updated_at_trigger
BEFORE UPDATE ON series BEGIN
    UPDATE series SET updated_at = CURRENT_TIMESTAMP;
END;
  