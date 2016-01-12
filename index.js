var express = require("express");
var sqlite3 = require("co-sqlite3");

var create_db = require("./database/create.js");

var db; // Access to database
var app = express(); // HTTP server
app.set('view engine', 'hbs'); // HTML templating

// Answer HTTP stuff

app.get('/', function start_page (req, res) {
    db.all('SELECT id, name, language FROM movies_with_language')
    .then(function (movies) {
        res.render('index', {        
        });
    });
});

// Movies

app.get('/movie/movie_detail/:movie_id', function movie_detail_page(req, res, next) {
    db.get('SELECT name, language FROM movies_with_language WHERE id = ?', req.params.movie_id)
    .then(function (movie) {
        res.render('movies/movies', {
            movie: movie
        });
    }).catch(next);
    // .catch(function (err) {
    //     res.status(404).render('404', {error: err});
    // });
});

//Shows

app.get('/shows/shows', function shows_page(req, res, next) {
    db.all('SELECT id, name, language, creator, network FROM shows_with_seasons')
    .then(function (shows) {
        res.render('shows/shows', {
            shows: shows
        });
    });
});

app.get('/shows/series_detail/:series_id', function series_detail_page(req, res, next) {
    db.get('SELECT id, name, language, creator, network FROM shows_with_seasons WHERE id = ?', req.params.series_id)
    .then(function (series) {
        res.render('shows/series_detail', {
            series: series
        })
    }).catch(next);
});

// Open DB, start server.

sqlite3('xenosaurus.db')
.then(function (db_access) {
    db = db_access;
    return db.exec(create_db);
}).then(function start_server() {
    app.listen(4020, function () {
        console.log("Server started. Yay!");
    });
});
