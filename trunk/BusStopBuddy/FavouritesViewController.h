//
//  FavouritesViewController.h
//  BusStopBuddy
//
//  Created by Louis on 16/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusStop.h"
#import "BusManager.h"

@interface FavouritesViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *favouriteItems;
    UITableView *_favouriteStopTable;
 
     BusManager *busManager;
}
@property (nonatomic,retain) IBOutlet UITableView *favouriteStopTable;

@end
