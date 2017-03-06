var express = require("express");
var path = require("path");
var mysql = require("mysql");
var app = express();

var dbconn = mysql.createConnection({
  "host": "testdb.cuicpsblup3n.us-west-2.rds.amazonaws.com",
  "user": "admin",
  "password": "password123"
});

dbconn.query("USE testdb");

app.set("port", 3000);
app.set("view engine", "pug");
app.set("views", path.join(__dirname, "views"));

app.use(express.static(path.join(__dirname, "public")));

app.get("/", function (req, res) {
  dbconn.query("SELECT * FROM players", function (err, rows) {
    if (err) {
      console.log(err.stack);
    }
    res.render("index", {players: rows});
  });
});

app.listen(app.get("port"));
console.log("Server running on port " + app.get("port") + "...");
