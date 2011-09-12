//
//  BusStop.m
//  mLondonBus
//
//  Created by Franco Raimondi on 08/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BusStop.h"


@implementation BusStop

@synthesize stopId=_stopId;
@synthesize stopName=_stopName;
@synthesize stopLetter=_stopLetter;
@synthesize favourite=_favourite;
@synthesize lastUsage=_lastUsage;

- (id) initWithId:(NSString *)stopId andName:(NSString *)stopName andLetter:(NSString *)stopLetter {
    self = [super init];
    if (self) {
        self.stopId = stopId;
        self.stopName = stopName;
        self.stopLetter = stopLetter;
    }
    return self;
}

- (void) dealloc {
    [_stopId dealloc];
    [_stopName dealloc];
    [_stopLetter dealloc];
    [super dealloc];
}

@end
