var exec = require('cordova/exec');

exports.start = function(arg0, success, error) {
    exec(success, error, "ColocatorWrapper", "start", [arg0]);
};

exports.stop = function(success, error) {
    exec(success, error, "ColocatorWrapper", "stop", []);
}

exports.getDeviceId = function(success, error) {
  exec(success, error, "ColocatorWrapper", "getDeviceId", []);
}

exports.addAlias = function(key, value, success, error) {
  exec(success, error, "ColocatorWrapper", "addAlias", [key, value]);
}

exports.requestLocation = function(success, error) {
  exec(success, error, "ColocatorWrapper", "requestLocation", []);
}

exports.registerLocationListener = function(success, error) {
  exec(success, error, "ColocatorWrapper", "registerLocationListener", []);
}

exports.unregisterLocationListener = function(success, error) {
  exec(success, error, "ColocatorWrapper", "unregisterLocationListener", []);
}

// Only iOS
exports.triggerBluetoothPermissionPopUp = function(success, error) {
  exec(success, error, "ColocatorWrapper", "triggerBluetoothPermissionPopUp", []);
}

// Only iOS
exports.triggerMotionPermissionPopUp = function(success, error) {
  exec(success, error, "ColocatorWrapper", "triggerMotionPermissionPopUp", []);
}

// Only iOS
exports.testLibraryIntegration = function(success, error) {
  exec(success, error, "ColocatorWrapper", "testLibraryIntegration", []);
}

// Only Android
exports.setServiceNotificationInfo = function(title, icon, channelId, success, error) {
  exec(success, error, "ColocatorWrapper", "setServiceNotificationInfo", [title, icon, channelId]);
}
