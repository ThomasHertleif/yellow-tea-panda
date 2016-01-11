var express = require("express");
var sqlite3 = require("co-sqlite3");

var create_db = require("./database/create.js");

var db; // Access to database
var app = express(); // HTTP server
app.set('view engine', 'hbs'); // HTML templating

// Answer HTTP stuff

app.get('/', function start_page (req, res) {
    db.all('SELECT name, language FROM movies_with_language')
    .then(function (movies) {
        // movies = [{name: "Ali G", language: 'en'}]
        res.render('index', {
            title: 'Panda', msg: 'Nein das ist Patrick', movies: movies
        });
    });
});

app.get('/movie/:movie_id', function movie_page(req, res, next) {
    db.get('SELECT name, language FROM movies_with_language WHERE id = ?', req.params.movie_id)
    .then(function (movie) {
        res.render('movie', {
            movie: movie
        });
    }).catch(next);
    // .catch(function (err) {
    //     res.status(404).render('404', {error: err});
    // });
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
