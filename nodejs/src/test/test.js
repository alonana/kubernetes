process.env.NODE_ENV = 'test';

var chai = require('chai');
var chaiHttp = require('chai-http');
var server = require('../main/server');
var should = chai.should();
let expect = chai.expect;


chai.use(chaiHttp);
//Our parent block
describe('health check', () => {
  it('it should return something', (done) => {
    chai.request(server)
        .get('/')
        .end((err, res) => {
              res.should.have.status(200);
          done();
        });
  });
});

describe('get event details', () => {
  it('it should return event', (done) => {
    id='543435'
    chai.request(server)
        .post('/events/details')
        .send({
            id:id,
        })
        .end((err, res) => {
              res.should.have.status(200);
              expect(res.body.message.includes(id)).to.be.true;
          done();
        });
  });
});