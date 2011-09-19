//
//  BusStopStatus.h
//  mLondonBus
//
//  Created by Franco Raimondi on 09/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusStop.h"

@interface BusStopStatus : NSObject {
    BusStop *_busStop;
    NSString *_lastUpdated;
    NSMutableArray *_arrivals;
}

@property (nonatomic, retain) BusStop *busStop;
@property (nonatomic, retain) NSString *lastUpdated;
@property (nonatomic, retain) NSMutableArray *arrivals;

- (id) initWithId:(BusStop *)stop;

@end
