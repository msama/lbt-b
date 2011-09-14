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


- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject: _stopId forKey:@"objStopId"];
    [encoder encodeObject: _stopName forKey:@"objStopName"];
    [encoder encodeObject: _stopLetter forKey:@"objStopLetter"];    
    [encoder encodeBool:self.favourite forKey:@"objFavourite"];
    [encoder encodeObject:_lastUsage forKey:@"objLastUsage"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self) {
        self.stopId = [decoder decodeObjectForKey:@"objStopId"];
        self.stopName = [decoder decodeObjectForKey:@"objStopName"];
        self.stopLetter = [decoder decodeObjectForKey:@"objStopLetter"];
        self.favourite = [decoder decodeBoolForKey:@"objFavourite"];
        self.lastUsage = [decoder decodeObjectForKey:@"objLastUsage"];
    }
    return self;
}


@end
