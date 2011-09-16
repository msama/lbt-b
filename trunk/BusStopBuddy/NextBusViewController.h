//
//  NextBusViewController.h
//  BusStopBuddy
//
//  Created by Louis Slabbert on 08/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusStop.h"
#import "BusManager.h"

@interface NextBusViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {
    NSArray *_filteredItems;
    UITableView *_busStopTable;
    
    BusManager *_busManager;
}

@property (nonatomic,retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic,retain) IBOutlet UITableView *busStopTable;
@end


