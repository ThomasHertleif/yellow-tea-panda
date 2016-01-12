var express = require('express');
var sqlite3 = require('co-sqlite3');

var create_db = require('./database/create.js');

var db; // Access to database
var app = express(); // HTTP server
app.set('view engine', 'hbs'); // HTML templating

// Answer HTTP stuff

app.get('/', function start_page (req, res) {
    res.render('index', {
        title: 'Start'
    });
});

// Movies

app.get('/movies', function movies_page(req, res, next) {
    db.all('SELECT id, name, lenght, language FROM movies_all')
    .then(function (movies) {
        res.render('movies/list', {
            movies: movies
        });
    }).catch(next);
});

app.get('/movie/:movie_id', function movie_detail_page(req, res, next) {
    Promise.all([
        db.get('SELECT name, lenght, language FROM movies_all WHERE id = ?', req.params.movie_id),
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
        db.all('SELECT name, season, number, released FROM episodes_with_seasons'),
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

// app.get('/show/:show_id/:season/:number');

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
