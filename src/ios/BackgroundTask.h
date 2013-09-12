//
//  BackgroundTask.h
//  DICT8Mobile
//
//  Created by Jaime Baez on 29/01/2013.
//
//


#import <Cordova/CDVPlugin.h>

@interface BackgroundTask : CDVPlugin {
}

- (void) begin:(CDVInvokedUrlCommand*)command;
- (void) end:(CDVInvokedUrlCommand*)command;

@end