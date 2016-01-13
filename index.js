var express = require('express');
var bodyParser = require('body-parser');
var sqlite3 = require('co-sqlite3');

var create_db = require('./database/create.js');

var db; // Access to database
var app = express(); // HTTP server
app.set('view engine', 'hbs'); // HTML templating

var urlencodedParser = bodyParser.urlencoded({ extended: false })

// Answer HTTP stuff

app.get('/', function start_page (req, res) {
    res.render('index', {
        title: 'Start'
    });
});

// Movies

app.get('/movies', function movies_page(req, res, next) {
    Promise.all([
        db.all('SELECT id, name, length, language FROM movies_all'),
        db.all('SELECT movie_id, genre_name FROM genres_for_movie')
    ])
    .then(function (results) {
        var movies = results[0];
        var genre = results[1];

        res.render('movies/list', {
            movies: movies,
            genre: genre
        });
    }).catch(next);
});

app.get('/movie/:movie_id', function movie_detail_page(req, res, next) {
    Promise.all([
        db.get('SELECT name, length, language FROM movies_all WHERE id = ?', req.params.movie_id),
        db.get('SELECT genre_name FROM genres_for_movie WHERE movie_id = ?', req.params.movie_id)
    ])
    .then(function (results) {
        var movie = results[0];
        var genre = results[1];

        res.render('movies/details', {
            movie: movie,
            genre: genre
        });
    }).catch(next);
    // .catch(function (err) {
    //     res.status(404).render('404', {error: err});
    // });
});

//Shows

app.get('/shows', function shows_page(req, res, next) {
    db.all('SELECT id, name, language, creator, network FROM shows_with_seasons')
    .then(function (shows) {
        res.render('shows/list', {
            shows: shows
        });
    }).catch(next);
});

app.get('/show/:show_id', function series_detail_page(req, res, next) {
    Promise.all([
        db.all('SELECT id, name, season, number, released FROM episodes_with_seasons'),
        db.get('SELECT id, name, language, creator, network FROM shows_with_seasons WHERE id = ?', req.params.show_id )
    ])
    .then(function (results) {
        var episodes = results[0];
        var series = results[1];

        res.render('shows/details', {
            episodes: episodes,
            series: series
        });
    }).catch(next);
});

app.get('/show/:show_id/:season/:number', function episode_detail_page(req, res, next) {
    Promise.all([
        db.get('SELECT id, name, language, creator, network FROM shows_with_seasons WHERE id = ?', req.params.show_id ),
        db.all('SELECT id, name, season, number, released FROM episodes_with_seasons')
    ])
    .then(function (results) {
        var series = results[0];
        var episodes = results[1];

        res.render('shows/episode', {
            series: series,
            episodes: episodes
        });
    }).catch(next);
});

//Inputs

app.get('/edit_tables', function edit_tables(req, res, next) {
    Promise.all([
        db.all('SELECT id, name, language, creator, network FROM shows_with_seasons')
    ])
    .then(function (results) {
        var shows = results[0];

        res.render('edit_tables', {
            shows: shows
        });
    }).catch(next);
});

app.get('/add_movie', function create_movie_page(req, res, next) {
    Promise.all([
        db.all('SELECT id, name FROM genres'),
        db.all('SELECT id, code FROM get_all_languages')
    ])
    .then(function (results) {
        var genres = results[0];
        var languages = results[1];

        res.render('forms/add_movie', {
            title: 'New movies are good movies',
            genres: genres,
            languages: languages
        });
    }).catch(next);
});

app.post('/add_movie/validate', urlencodedParser, function create_movie(req, res, next) {
    console.log("i got dis", req.body);
    // TODO: Validate inputs
    // TODO: Read other entries; make sure order is correct.
    var movie = req.body;
    db.run('INSERT INTO movies (name, language_id, length) VALUES ($name, $language, $length)', {
        $name: movie.name,
        $language: movie.language,
        $length: movie.length
    })
    .then(function (result) {
        var new_movie_id = result.lastID;
        var genre_ids = req.body.genres;

        var set_genres = genre_ids.map(function (genre_id) {
            return db.run('INSERT INTO movies_genres (movie_id, genre_id) VALUES ($movie_id, $genre_id)', {
                $movie_id: new_movie_id,
                $genre_id: genre_id
            });
        });

        return Promise.all(set_genres);
    })
    .then(function () {
        res.redirect('/');
    }).catch(next);
});

// Open DB, start server.

sqlite3('xenosaurus.db')
.then(function (db_access) {
    db = db_access;
    return db.exec(create_db);
}).then(function start_server() {
    app.listen(4020, function () {
        console.log('Server started. Yay!');
    });
});

app.use(express.static('static'));
