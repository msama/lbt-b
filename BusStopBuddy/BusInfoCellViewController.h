//
//  BusInfoCellViewController.h
//  busStopBuddy
//
//  Created by Padma Daryanani on 09/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BusInfoCellViewController : UIViewController {
    IBOutlet UILabel *busNumberLabel;
    IBOutlet UILabel *busDestLabel;  
    IBOutlet UILabel *busTimeLabel;   
    IBOutlet UILabel *busSchedTimeLabel;
    
    NSString *busNumber;
    NSString *busDest;  
    NSString *busTime;   
    NSString *busSchedTime;   
}

@property (nonatomic, retain) NSString *busNumber;
@property (nonatomic, retain) NSString *busDest;  
@property (nonatomic, retain) NSString *busTime;   
@property (nonatomic, retain) NSString *busSchedTime; 

@end
