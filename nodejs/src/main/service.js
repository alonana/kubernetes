const elasticSearch = require('elasticsearch');

const elasticClient = produceElasticClient();


module.exports = {
    health,
    dbPing,
    eventDetails,
    eventsList,
    accessList,
};

function produceElasticClient() {
    const env = process.env;
    const user = env.ES_USER;
    const password = env.ES_PASSWORD;
    const port = env.ES_PORT;
    const host = env.ES_HOST;

    const url = `https://${user}:${password}@${host}:${port}`;

    // never leave this in production :)
    // console.log("connecting to elastic on url " + url);

    return new elasticSearch.Client({
        hosts: [url]
    });
}


function health(req, res) {
    res.json({
        message: 'Welcome to backend',
        status: 0
    });
}

function dbPing(req, res) {
    elasticClient.ping({
        requestTimeout: 30000,
    }, function (error) {
        if (error) {
            res.json({
                message: error.message,
                status: 500
            });
        } else {
            res.json({
                message: "ES up",
                status: 0
            });
        }
    });
}

function eventsList(req, res) {
    return list(req, res, "print");
}

function accessList(req, res) {
    return list(req, res, "access");
}

function list(req, res, indexName) {
    const list = [];
    return elasticClient.search({
        index: `${indexName}*`,
        // q: 'sequence:1'
        body: {
            size: 100,
            sort: [
                {
                    "@timestamp": {
                        "order": "desc",
                    }
                },
            ]
        }
    }).then(function (elasticResponse) {
        elasticResponse.hits.hits.forEach(
            (hit) => {
                list.push(hit._source);
            }
        );
        res.json({
            list: list,
            status: 0
        });

    }, function (error) {
        res.json({
            message: error.message,
            status: 500
        });
    });
}


function eventDetails(req, res) {
    id = req.body.id;
    elasticClient.search({
        index: 'print*',
        q: `sequence:${id}`,
        body: {
            size: 1,
        }
    }).then(function (elasticResponse) {
        elasticResponse.hits.hits.forEach(
            (hit) => {
                res.json({
                    details: hit._source,
                    status: 0
                });
            }
        );

    }, function (error) {
        res.json({
            message: error.message,
            status: 500
        });
    });
}
