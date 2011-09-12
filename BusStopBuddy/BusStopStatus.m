//
//  BusStopStatus.m
//  mLondonBus
//
//  Created by Franco Raimondi on 09/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BusStopStatus.h"


@implementation BusStopStatus

@synthesize stopID=_stopID;
@synthesize lastUpdated=_lastUpdated;
@synthesize infoMessages=_infoMessages;
@synthesize importantMessages=_importantMessages;
@synthesize criticalMessages=_criticalMessages;
@synthesize arrivals = _arrivals;


- (id) initWithId:(NSString *)stopID andLastUpdated:(NSString *)lastUpdated andInfoMessages:(NSString *)infoMessages andImportantMessages:(NSString *)importantMessage andCriticalMessages:(NSString *)criticalMessages {
    self = [super init];
    if (self) {
        self.stopID = stopID;
        self.lastUpdated = lastUpdated;
        self.infoMessages = infoMessages;
        self.importantMessages = importantMessage;
        self.criticalMessages = criticalMessages;
        self.arrivals = [NSMutableArray array];
    }
    return self;
}

- (void) dealloc {
    [_stopID dealloc];
    [_lastUpdated dealloc];
    [_infoMessages dealloc];
    [_importantMessages dealloc];   
    [_criticalMessages dealloc];  
    [_arrivals release];
    [super dealloc];
}


@end
