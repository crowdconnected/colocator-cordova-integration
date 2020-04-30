/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  AppDelegate.m
//  CordovaIntegrationTestApp
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import <CCLocation/CCLocation-Swift.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    self.viewController = [[MainViewController alloc] init];
    [CCLocation.sharedInstance startWithApiKey:@"YOUR_APP_KEY" urlString:@"URL_STRING"];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // At background refresh, the CCLocation library should be notified to update its state
    [CCLocation.sharedInstance updateLibraryBasedOnClientStatusWithClientKey:@"YOUR_APP_KEY" isSilentNotification:false completion:^(BOOL result) {}];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // For CCLocation messaging feature, send device token to the library as an alias
    NSString * deviceTokenString = [[[[deviceToken description]
     stringByReplacingOccurrencesOfString: @"<" withString: @""]
     stringByReplacingOccurrencesOfString: @">" withString: @""]
     stringByReplacingOccurrencesOfString: @" " withString: @""];
    [CCLocation.sharedInstance addAliasWithKey:@"apns_user_id" value:deviceTokenString];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSDictionary *apsInfo = [userInfo objectForKey:@"apsInfo"];
    NSString *source = [apsInfo objectForKey:@"source"];
    if ([source isEqualToString:@"colcoator"]) {
        [CCLocation.sharedInstance receivedSilentNotificationWithUserInfo:userInfo clientKey:@"YOUR_APP_KEY" completion:^(BOOL result) {}];
    }
}

@end
