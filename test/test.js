var expect = require("chai").expect;
var request = require("request");
var url = "http://localhost:3000"

describe("Basic tests", function () {
  describe("Page load", function () {
    it("Page loads successfully with HTTP 200", function (done) {
      request(url, function (error, response, body) {
        if (error) {
          console.log(error.stack);
        }
        expect(response.statusCode).to.equal(200);
        done();
      });
    });
    it("DIV with id=container exists", function (done) {
      request(url, function (error, response, body) {
        if (error) {
          console.log(error.stack);
        }
        expect(response.body).to.contain('<div id="container">');
        done();
      });
    });
  });
  describe("Content", function () {
    it("List of names loads successfully", function (done) {
      request(url, function (error, response, body) {
        if (error) {
          console.log(error.stack);
        }
        expect(response.body).to.contain("Stephen Curry");
        expect(response.body).to.contain("Klay Thompson");
        expect(response.body).to.contain("Draymond Green");
        expect(response.body).to.contain("Kevin Durant");
        expect(response.body).to.contain("Zaza Pachulia");
        done();
      });
    });
  });
});
