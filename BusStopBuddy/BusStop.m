//
//  BusStop.m
//  mLondonBus
//
//  Created by Franco Raimondi on 08/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BusStop.h"


@implementation BusStop

@synthesize stopId = _stopId;
@synthesize stopName = _stopName;
@synthesize stopLetter = _stopLetter;
@synthesize favourite = _favourite;

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
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self) {
        self.stopId = [decoder decodeObjectForKey:@"objStopId"];
        self.stopName = [decoder decodeObjectForKey:@"objStopName"];
        self.stopLetter = [decoder decodeObjectForKey:@"objStopLetter"];
        self.favourite = [decoder decodeBoolForKey:@"objFavourite"];
    }
    return self;
}

- (id) copyWithZone:(NSZone *)zone{
    BusStop *object = [[[self class] allocWithZone:zone] init];
    object->_stopId = [_stopId copyWithZone:zone];
    object->_stopName = [_stopName copyWithZone:zone];
    object->_stopLetter = [_stopLetter copyWithZone:zone];
    object->_favourite = _favourite;
    return object;
}
 
- (NSString*) verboseName {
    if (_stopLetter == nil || [_stopLetter isEqual:@"<null>"]) {
        return _stopName;
    }
    return [NSString stringWithFormat:@"%@ (%@)", _stopName, _stopLetter];
}

@end
