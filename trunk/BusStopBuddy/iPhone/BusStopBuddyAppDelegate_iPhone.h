//
//  BusStopBuddyAppDelegate_iPhone.h
//  BusStopBuddy
//
//  Created by Louis Slabbert on 08/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusManager.h"
#import "BusStopBuddyAppDelegate.h"

@interface BusStopBuddyAppDelegate_iPhone : BusStopBuddyAppDelegate {

    BusManager *_busManager;
    IBOutlet UITabBarController *tabBarController;
    
}

@property (nonatomic, retain) BusManager *busManager;

@end
