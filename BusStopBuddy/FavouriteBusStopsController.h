//
//  FavouriteBusStopsController.h
//  BusStopBuddy
//
//  Created by Michele Sama on 16/09/11.
//  Copyright 2011 PuzzleDev s.n.c di Michele Sama e soci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusManager.h"


@interface FavouriteBusStopsController : UITableViewController {
    BusManager *_busManager;
    NSArray *_favouriteBus;
}

@end
