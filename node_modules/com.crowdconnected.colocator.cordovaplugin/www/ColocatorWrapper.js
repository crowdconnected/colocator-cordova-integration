var exec = require('cordova/exec');

/**
 * Starts the Colocator library.
 * 
 * @param {String}     appKey     Your unique Application Key for Colocator.
 */
exports.start = function(appKey, success, error) {
    exec(success, error, "ColocatorWrapper", "start", [appKey]);
};

/**
 * Stops the Colocator library.
 */
exports.stop = function(success, error) {
    exec(success, error, "ColocatorWrapper", "stop", []);
}

/**
 * Returns the unique Device ID, used by the Colocator library.
 */
exports.getDeviceId = function(success, error) {
  exec(success, error, "ColocatorWrapper", "getDeviceId", []);
}

/**
 * Save and send a pair (key, value) for this device.
 * 
 * @param {String}     key     Your pair key.
 * @param {String}     value   Your pair value.
 */
exports.addAlias = function(key, value, success, error) {
  exec(success, error, "ColocatorWrapper", "addAlias", [key, value]);
}

/**
 * Requests the last location update from the Colocator server.
 * 
 * The callback response is of JSON type.
 */
exports.requestLocation = function(success, error) {
  exec(success, error, "ColocatorWrapper", "requestLocation", []);
}

/**
 * Requests continuous location updates from the Colocator server.
 * 
 * The callback responsees are of JSON type.
 */
exports.registerLocationListener = function(success, error) {
  exec(success, error, "ColocatorWrapper", "registerLocationListener", []);
}

/**
 * Stops listening for location updates from the Colocator server.
 */
exports.unregisterLocationListener = function(success, error) {
  exec(success, error, "ColocatorWrapper", "unregisterLocationListener", []);
}

/**
 * Only on iOS
 * 
 * Triggers the OS pop-up asking for Bluetooth permission.
 */
exports.triggerBluetoothPermissionPopUp = function(success, error) {
  exec(success, error, "ColocatorWrapper", "triggerBluetoothPermissionPopUp", []);
}

/**
 * Only on iOS
 * 
 * Triggers the OS pop-up asking for Fitness&Motion permission.
 */
exports.triggerMotionPermissionPopUp = function(success, error) {
  exec(success, error, "ColocatorWrapper", "triggerMotionPermissionPopUp", []);
}

/**
 * Only on iOS
 * 
 * Returns the library integration status as String.
 */
exports.testLibraryIntegration = function(success, error) {
  exec(success, error, "ColocatorWrapper", "testLibraryIntegration", []);
}

/**
 * Only on Android
 * 
 * Configures and starts the Foreground Service.
 * 
 * @param {String}     title       The text to be displayed with the foreground service notification.
 * @param {int}        icon        The icon id to be displayed with the foreground service notification.
 * @param {String}     channelId   The channed ID used for the foreground service.
 */
exports.setServiceNotificationInfo = function(title, icon, channelId, success, error) {
  exec(success, error, "ColocatorWrapper", "setServiceNotificationInfo", [title, icon, channelId]);
}
