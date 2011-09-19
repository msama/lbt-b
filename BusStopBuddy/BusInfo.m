//
//  BusInfo.m
//  mLondonBus
//
//  Created by Franco Raimondi on 09/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BusInfo.h"


@implementation BusInfo

@synthesize routeID = _routeID;
@synthesize destination = _destination;
@synthesize estimatedWait = _estimatedWait;


- (id) initWithId:(NSString *)routeID andDestination:(NSString *)destination andestimatedWait:(NSString *)estimatedWait {
    self = [super init];
    if (self) {
        self.routeID = routeID;
        self.destination = destination;
        self.estimatedWait = estimatedWait;
    }
    return self;
}

- (void) dealloc {
    [_routeID release];
    [_destination release];
    [_estimatedWait release];
    [super dealloc];
}


@end
