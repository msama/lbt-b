//
//  BusStopBuddyAppDelegate_iPhone.m
//  BusStopBuddy
//
//  Created by Louis Slabbert on 08/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BusStopBuddyAppDelegate_iPhone.h"

@implementation BusStopBuddyAppDelegate_iPhone

@synthesize busManager = _busManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    _busManager = [[[BusManager alloc] init] retain];
    [self.window setRootViewController:tabBarController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc
{
    [_busManager release];
	[super dealloc];
}

@end
