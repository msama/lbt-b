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
    NSString *_infoMessages;
    NSString *_importantMessages;
    NSString *_criticalMessages;
    NSMutableArray *_arrivals;
}

@property (nonatomic, retain) BusStop *busStop;
@property (nonatomic, retain) NSString *lastUpdated;
@property (nonatomic, retain) NSString *infoMessages;
@property (nonatomic, retain) NSString *importantMessages;
@property (nonatomic, retain) NSString *criticalMessages;
@property (nonatomic, retain) NSMutableArray *arrivals;

- (id) initWithId:(BusStop *)stop andLastUpdated:(NSString *)lastUpdated andInfoMessages:(NSString *)infoMessages andImportantMessages:(NSString *)importantMessage andCriticalMessages:(NSString *)criticalMessages;

@end
