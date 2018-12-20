let express = require('express');
let app = express();
// make express look in the public directory for assets (css/js/img)
app.use(express.static(__dirname + '/public'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

// set the port of our application
// process.env.PORT lets the port be set by Heroku
let port = process.env.PORT || 8080;
let current_rotation = "rest";

// set the view engine to ejs
app.set('view engine', 'ejs');

// set the home page route
app.get('/', function(req, res) {
	res.render('index');
});

app.get('/api/rotate', function(req, res){
	res.send(current_rotation);
});

app.post('/api/rotate', function(req, res){
    console.log(req.body);
	current_rotation = req.body.position_to_rotate;
	res.send("OK");
});

app.listen(port, function() {
	console.log('Our app is running on http://localhost:' + port);
});
