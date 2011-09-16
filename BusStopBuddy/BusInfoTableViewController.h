//
//  BusInfoTableViewController.h
//  busStopBuddy
//
//  Created by Padma Daryanani on 09/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusInfoCellViewController.h"
#import "BusStopStatus.h"
#import "BusManager.h"

@interface BusInfoTableViewController : UITableViewController {
    BusManager *busManager;
    BusStopStatus *_stopStatus;
}

@property (nonatomic, retain) BusManager *busManager;
@property (nonatomic, retain) BusStopStatus *stopStatus;

- (void) addToFavourites:(id)sender;
- (void) removeFromFavourites:(id)sender;

@end
