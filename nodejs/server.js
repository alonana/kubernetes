var bodyParser = require('body-parser');
var express = require("express");
var app = express();
var elasticsearch = require('elasticsearch');

var client = new elasticsearch.Client({
   hosts: [ 'https://nginx:nginx@192.168.99.116:30001']
});

client.ping({
    requestTimeout: 30000,
}, function(error) {
    if (error) {
        console.error('elasticsearch cluster is down!');
    } else {
        console.log('Everything is ok');
    }
});

client.search({
    index: 'print*',
    q: 'sequence:1'
}).then(function(resp) {
    console.log(resp);
    console.log(resp.hits.hits);
    resp.hits.hits.forEach(
        (hit)=>{
            console.log(`HIT ${JSON.stringify(hit._source)}`);
        }
    );
}, function(err) {
    console.trace(err.message);
});



app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var port = process.env.PORT || 8080;

var router = express.Router();

router.get('/', function(req, res) {
    res.json({
        message: 'Welcome to backend',
        status: 0
    });
});

router.post('/events/details', function(req, res) {
    res.json({
        message: 'details of ID '+req.body.id,
        status: 0
    });
});

app.use('/', router);

var server = app.listen(port, () => {
 console.log("Server running on http://localhost:"+port);
});

module.exports = server