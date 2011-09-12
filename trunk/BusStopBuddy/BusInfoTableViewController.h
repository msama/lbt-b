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
#import "BusInfo.h"

@interface BusInfoTableViewController : UITableViewController {
    BusStopStatus *_stopStatus;
    
    /*
     IBOutlet UILabel *lbl_stopID;
    IBOutlet UILabel *lbl_lastUpdated;
    IBOutlet UILabel *lbl_infoMessages;
    IBOutlet UILabel *lbl_importantMessages;
    IBOutlet UILabel *lbl_criticalMessages;
    */
    
    /*    
    NSString *_stopID;
    NSString *_lastUpdated;
    NSString *_infoMessages;
    NSString *_importantMessages;
    NSString *_criticalMessages;
    NSMutableArray *_arrivals;
     */
}

@property (nonatomic, retain) NSArray *incomingBuses;
@property (nonatomic, retain) BusStopStatus *stopStatus;


//@property (nonatomic, retain) NSArray *incomingBuses;

@end
