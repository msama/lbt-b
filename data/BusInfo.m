//
//  BusInfo.m
//  mLondonBus
//
//  Created by Franco Raimondi on 09/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BusInfo.h"


@implementation BusInfo

@synthesize routeID=_routeID;
@synthesize destination=_destination;
@synthesize estimatedWait=_estimatedWait;
@synthesize scheduledTime=_scheduledTime;


- (id) initWithId:(NSString *)routeID andDestination:(NSString *)destination andestimatedWait:(NSString *)estimatedWait andscheduledTime:(NSString *) scheduledTime {
    self = [super init];
    if (self) {
        self.routeID = routeID;
        self.destination = destination;
        self.estimatedWait = estimatedWait;
        self.scheduledTime = scheduledTime;
    }
    return self;
}

- (void) dealloc {
    [_routeID dealloc];
    [_destination dealloc];
    [_estimatedWait dealloc];
    [_scheduledTime dealloc];   
    [super dealloc];
}


@end
