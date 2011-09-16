//
//  BusStopBuddyAppDelegate_iPhone.m
//  BusStopBuddy
//
//  Created by Louis Slabbert on 08/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BusStopBuddyAppDelegate_iPhone.h"

@implementation BusStopBuddyAppDelegate_iPhone


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.busManager = [[BusManager alloc] init];
    [self.window setRootViewController:tabBarController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc
{
	[super dealloc];
}

@end
