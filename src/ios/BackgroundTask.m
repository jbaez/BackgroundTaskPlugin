//
//  BackgroundTask.m
//  DICT8Mobile
//
//  Created by Jaime Baez on 29/01/2013.
//
//

#import "BackgroundTask.h"

static UIBackgroundTaskIdentifier backgroundTaskID;

@implementation BackgroundTask

+ (void) initialize
{
    backgroundTaskID = UIBackgroundTaskInvalid;
}

- (void) begin:(CDVInvokedUrlCommand *)command
{
    __block CDVPluginResult* pluginResult = nil;
    
    UIDevice* device = [UIDevice currentDevice];
    
    BOOL isMultitaskingSupported = [device respondsToSelector:@selector(isMultitaskingSupported)] && [device isMultitaskingSupported];
    
    
    if (isMultitaskingSupported) {
        
        backgroundTaskID = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            [[UIApplication sharedApplication] endBackgroundTask:backgroundTaskID];
            backgroundTaskID = UIBackgroundTaskInvalid;
            // NSLog (@"Background task time expired.");
        }];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Background Task Started"];
        
        [self.commandDelegate runInBackground:^{
            // NSLog(@"Runing task in background");
        }];
    }
    else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Multitasking is not suppported"];
    }
    
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


- (void) end:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult* pluginResult = nil;
    
    if (backgroundTaskID == UIBackgroundTaskInvalid){
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No background task to End"];
    }
    else{
        [[UIApplication sharedApplication] endBackgroundTask:backgroundTaskID];
        backgroundTaskID = UIBackgroundTaskInvalid;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Background Task Ended"];
    }
    

    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
@end