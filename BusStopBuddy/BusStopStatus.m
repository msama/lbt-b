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
@synthesize arrivals = _arrivals;


- (id) initWithId:(BusStop *)busStop {
    self = [super init];
    if (self) {
        self.busStop = busStop;
        self.arrivals = [NSMutableArray array];
    }
    return self;
}

- (void) dealloc {
    [_busStop release];
    [_lastUpdated release];
    [_arrivals release];
    [super dealloc];
}


@end
