/*global cordova*/

var exec = require("cordova/exec");

var Discover = function(){};

Discover.prototype.greet = function (name, successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, "Discover", "greet", [name]);
};

module.exports = new Discover();
