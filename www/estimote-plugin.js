/*global cordova*/

var exec = require("cordova/exec");

var Estimote = function(){};

Estimote.prototype.greet = function (name, successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, "Estimote", "greet", [name]);
};

module.exports = new Estimote();
