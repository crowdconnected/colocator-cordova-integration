package com.crowdconnected.colocator.cordovaplugin;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import net.crowdconnected.androidcolocator.CoLocator;
import net.crowdconnected.androidcolocator.LocationCallback;
import net.crowdconnected.androidcolocator.connector.LocationResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.List;

/**
 * This class echoes a string called from JavaScript.
 */
public class ColocatorWrapper extends CordovaPlugin {

    @Override
     public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
         if (action.equals("start")) {
             String arg0 = args.getString(0);
             this.start(arg0, callbackContext);
             return true;
         }
         if (action.equals("stop")) {
             this.stop(callbackContext);
             return true;
         }
         if (action.equals("getDeviceId")) {
             this.getDeviceId(callbackContext);
             return true;
         }
         if (action.equals("addAlias")) {
             String arg0 = args.getString(0);
             String arg1 = args.getString(1);
             this.addAlias(arg0, arg1, callbackContext);
             return true;
         }
         if (action.equals("requestLocation")) {
             this.requestLocation(callbackContext);
             return true;
         }
         if (action.equals("registerLocationListener")) {
             this.registerLocationListener(callbackContext);
             return true;
         }
         if (action.equals("unregisterLocationListener")) {
             this.unregisterLocationListener(callbackContext);
             return true;
         }
         if (action.equals("setServiceNotificationInfo")) {
             String arg0 = args.getString(0);
             int arg1 = args.getInt(1);
             String arg2 = args.getString(2);
             this.setServiceNotificationInfo(arg0, arg1, arg2, callbackContext);
             return true;
         }
         if (action.equals("triggerBluetoothPermissionPopUp")) {
             this.triggerBluetoothPermissionPopUp(callbackContext);
             return true;
         }
         if (action.equals("triggerMotionPermissionPopUp")) {
             this.triggerMotionPermissionPopUp(callbackContext);
             return true;
         }
         if (action.equals("testLibraryIntegration")) {
             this.testLibraryIntegration(callbackContext);
             return true;
         }
         return false;
     }

    public void start(String appKey, CallbackContext callbackContext) {
        if (appKey != null && appKey.length() == 8) {
            if (CoLocator.instance() != null) {
                CoLocator.instance().stop();
            }
            CoLocator.start(this.cordova.getActivity().getApplication(), appKey);

            callbackContext.success("Colocator Started successfully");
        } else {
            callbackContext.error("Error");
        }
    }

    public void stop(CallbackContext callbackContext) {
        if (CoLocator.instance() != null) {
            CoLocator.instance().stop();
            callbackContext.success("Colocator Stopped successfully");
        } else {
            callbackContext.error("No instance of Colocator");
        }
    }

    public void getDeviceId(CallbackContext callbackContext) {
        if (CoLocator.instance() != null) {
            String id = CoLocator.instance().getDeviceId();
            callbackContext.success(id);
        } else {
            callbackContext.error("No instance of Colocator");
        }
    }

    public void addAlias(String key, String value, CallbackContext callbackContext) {
        if (key != null && key.length() > 0 && value != null && value.length() > 0 ) {
            if (CoLocator.instance() != null) {
                CoLocator.instance().addAlias(key, value);
                callbackContext.success("Alias Added Successfully");
            } else {
                callbackContext.error("No instance of Colocator");
            }
        } else {
            callbackContext.error("Invalid key and value provided");
        }
    }

    public void requestLocation(CallbackContext callbackContext) {
        if (CoLocator.instance() != null) {
            CoLocator.instance().requestLocation(new LocationCallback() {

                @Override
                public void onLocationReceived(LocationResponse clientLocationResponse) {
                    try {
                        JSONObject locationDictionary = new JSONObject();

                        locationDictionary.put("latitude", clientLocationResponse.getLatitude());
                        locationDictionary.put("longitude", clientLocationResponse.getLongitude());
                        locationDictionary.put("headingOffSet", clientLocationResponse.getHeadingOffset());
                        locationDictionary.put("error", clientLocationResponse.getError());
                        locationDictionary.put("timestamp", clientLocationResponse.getTimestamp());

                        callbackContext.success(locationDictionary);

                    } catch (Exception e) {
                        System.out.println("Exception occurred");
                    }
                }

                @Override
                public void onLocationsReceived(List<LocationResponse> list) { }
            });
        } else {
            callbackContext.error("No instance of Colocator");
        }   
    }

    public void registerLocationListener(CallbackContext callbackContext) {
        if (CoLocator.instance() != null) {
            CoLocator.instance().registerLocationListener(new LocationCallback() {

                @Override
                public void onLocationReceived(LocationResponse clientLocationResponse) { }

                @Override
                public void onLocationsReceived(List<LocationResponse> list) { 
                    for (LocationResponse response : list) {
                        try {
                            JSONObject locationDictionary = new JSONObject();
    
                            locationDictionary.put("latitude", response.getLatitude());
                            locationDictionary.put("longitude", response.getLongitude());
                            locationDictionary.put("headingOffSet", response.getHeadingOffset());
                            locationDictionary.put("error", response.getError());
                            locationDictionary.put("timestamp", response.getTimestamp());
    
                            callbackContext.success(locationDictionary);
    
                        } catch (Exception e) {
                            System.out.println("Exception occurred");
                        }
                    }
                }
            });
        } else {
            callbackContext.error("No instance of Colocator");
        }   
    }
    
    public void unregisterLocationListener(CallbackContext callbackContext) {
        if (CoLocator.instance() != null) {
            CoLocator.instance().unregisterLocationListener();
            callbackContext.success("Location Updates Stopped successfully");
        } else {
            callbackContext.error("No instance of Colocator");
        }
    }

    public void triggerBluetoothPermissionPopUp(CallbackContext callbackContext) {
        callbackContext.success("Method valid only for iOS");
    }

    public void triggerMotionPermissionPopUp(CallbackContext callbackContext) {
        callbackContext.success("Method valid only for iOS");
    }

    public void testLibraryIntegration(CallbackContext callbackContext) {
        callbackContext.success("Method valid only for iOS");
    }

    public void setServiceNotificationInfo(String title, int icon, String channelId, CallbackContext callbackContext) {
        if (title != null) {
            if (CoLocator.instance() != null) {
                CoLocator.setServiceNotificationInfo(this.cordova.getActivity().getApplication(), title, icon, channelId);
                callbackContext.success("Foreground Service Started Successfully");
            } else {
                callbackContext.error("No instance of Colocator");
            }
        } else {
            callbackContext.error("Invalid title provided");
        }
    }
}
