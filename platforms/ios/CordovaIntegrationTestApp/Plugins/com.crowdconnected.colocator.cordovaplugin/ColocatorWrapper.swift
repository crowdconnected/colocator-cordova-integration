import CCLocation

@objc(ColocatorWrapper) class ColocatorWrapper: CDVPlugin, CCLocationDelegate {

var locationUpdatesLastCommand: CDVInvokedUrlCommand? = nil

// Start
  @objc(start:)
  func start(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let appKey = command.arguments[0] as? String ?? ""

    if appKey.count == 8 {
        CCLocation.sharedInstance.start(apiKey: appKey)
        CCLocation.sharedInstance.delegate = self

        pluginResult = CDVPluginResult(
          status: CDVCommandStatus_OK,
          messageAs: "Colocator Started successfully"
        )
    }

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

// Stop
  @objc(stop:)
  func stop(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    CCLocation.sharedInstance.stop()

    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: "Colocator Stopped successfully"
    )
    
    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

// Get Device ID
@objc(getDeviceId:)
  func getDeviceId(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let id = CCLocation.sharedInstance.getDeviceId()

    if id != nil {
      pluginResult = CDVPluginResult(
        status: CDVCommandStatus_OK,
        messageAs: id
      )
    }
    
    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

// Add Alias
  @objc(addAlias:)
  func addAlias(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let key = command.arguments[0] as? String ?? ""
    let value = command.arguments[1] as? String ?? ""

    if key.count != 0 && value.count != 0 {
        CCLocation.sharedInstance.addAlias(key: key, value: value)

        pluginResult = CDVPluginResult(
          status: CDVCommandStatus_OK,
          messageAs: "Alias added successfully"
        )
    }

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

  // Trigger Bluetooth Permission PopUp
  @objc(triggerBluetoothPermissionPopUp:)
  func triggerBluetoothPermissionPopUp(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    CCLocation.sharedInstance.triggerBluetoothPermissionPopUp()

    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: "Permission triggered successfully"
    )
  
    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

  // Trigger Motion Permission PopUp
  @objc(triggerMotionPermissionPopUp:)
  func triggerMotionPermissionPopUp(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    CCLocation.sharedInstance.triggerMotionPermissionPopUp()

    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: "Permission triggered successfully"
    )
  
    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

  // Request Location
  @objc(requestLocation:)
  func requestLocation(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    CCLocation.sharedInstance.requestLocation()
    locationUpdatesLastCommand = command
    
    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: "Location requested successfully"
    )

    pluginResult?.setKeepCallbackAs(true)
  
    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

  // Register Location Listener
  @objc(registerLocationListener:)
  func registerLocationListener(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    CCLocation.sharedInstance.registerLocationListener()
    locationUpdatesLastCommand = command

    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: "Registered for location updates successfully"
    )

    pluginResult?.setKeepCallbackAs(true)
  
    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

  // Unregister Location Listener
  @objc(unregisterLocationListener:)
  func unregisterLocationListener(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    CCLocation.sharedInstance.unregisterLocationListener()
    locationUpdatesLastCommand = nil

    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: "Unregistered from location updates successfully"
    )
  
    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

// Test Library Integration
  @objc(testLibraryIntegration:)
  func testLibraryIntegration(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let res = CCLocation.sharedInstance.testLibraryIntegration()

    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: res
    )
  
    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

  // Set Service Notification Info
  @objc(setServiceNotificationInfo:)
  func setServiceNotificationInfo(command: CDVInvokedUrlCommand) {
    let pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: "Method valid only for Android"
    )
  
    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

  // CCLocation Delegate methods

  func didFailToUpdateCCLocation() { }
    
  func ccLocationDidConnect() { }
    
  func ccLocationDidFailWithError(error: Error) { }
    
  func didReceiveCCLocation(_ location: LocationResponse) {
    var locationDisctionary: [String: Any] = [:]
    locationDisctionary.updateValue(location.latitude, forKey: "latitude")
    locationDisctionary.updateValue(location.longitude, forKey: "longitude")
    locationDisctionary.updateValue(location.headingOffSet, forKey: "headingOffSet")
    locationDisctionary.updateValue(location.error, forKey: "error")
    locationDisctionary.updateValue(location.timestamp, forKey: "timestamp")

    let pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: locationDisctionary
    )
     
    pluginResult?.setKeepCallbackAs(true)
    
    if locationUpdatesLastCommand != nil {
         self.commandDelegate!.send(
              pluginResult,
              callbackId: locationUpdatesLastCommand!.callbackId
         )
    }
  }
}