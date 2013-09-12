cordova.define("cordova/plugin/backgroundTask", function(require, exports, module) {
    var exec = require('cordova/exec');

    var BackgroundTask = function() {};

    BackgroundTask.prototype.begin = function(successCallback,failureCallback) {
        exec(successCallback, failureCallback, 'BackgroundTask', 'begin', []);
    }

    BackgroundTask.prototype.end = function(successCallback,failureCallback) {
        exec(successCallback, failureCallback, 'BackgroundTask', 'end', []);
    }

    var backgroundTask = new BackgroundTask();
    module.exports = backgroundTask;
});