//
//  BusStopStatus.m
//  mLondonBus
//
//  Created by Franco Raimondi on 09/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BusStopStatus.h"


@implementation BusStopStatus

@synthesize busStop=_busStop;
@synthesize lastUpdated=_lastUpdated;
@synthesize infoMessages=_infoMessages;
@synthesize importantMessages=_importantMessages;
@synthesize criticalMessages=_criticalMessages;
@synthesize arrivals = _arrivals;


- (id) initWithId:(BusStop *)busStop andLastUpdated:(NSString *)lastUpdated andInfoMessages:(NSString *)infoMessages andImportantMessages:(NSString *)importantMessage andCriticalMessages:(NSString *)criticalMessages {
    self = [super init];
    if (self) {
        self.busStop = busStop;
        self.lastUpdated = lastUpdated;
        self.infoMessages = infoMessages;
        self.importantMessages = importantMessage;
        self.criticalMessages = criticalMessages;
        self.arrivals = [NSMutableArray array];
    }
    return self;
}

- (void) dealloc {
    [_busStop release];
    [_lastUpdated release];
    [_infoMessages release];
    [_importantMessages release];   
    [_criticalMessages release];  
    [_arrivals release];
    [super dealloc];
}


@end
