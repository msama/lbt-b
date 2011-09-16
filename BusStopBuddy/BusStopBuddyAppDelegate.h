//
//  BusStopBuddyAppDelegate.h
//  BusStopBuddy
//
//  Created by Louis Slabbert on 08/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusManager.h"

@interface BusStopBuddyAppDelegate : NSObject <UIApplicationDelegate> {
    BusManager *_busManager;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) BusManager *busManager;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
