const bodyParser = require('body-parser');
const express = require("express");
const service = require('./service');


function produceRouter() {
    const router = express.Router();

    router.get('/', service.health);
    router.post('/api/db/ping', service.dbPing);
    router.post('/api/events/details', service.eventDetails);
    router.post('/api/events/list', service.eventsList);
    router.post('/api/access/list', service.accessList);

    return router;
}

const app = express();
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.use('/', produceRouter());

const port = process.env.PORT;
const server = app.listen(port, () => {
    console.log("NodeJS started, see http://localhost:" + port);
});

module.exports = server;