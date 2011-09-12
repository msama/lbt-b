//
//  BusManager.h
//  mLondonBus
//
//  Created by Franco Raimondi on 09/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusStop.h"
#import "BusInfo.h"
#import "BusStopStatus.h"
#import "JSON.h"


@interface BusManager : NSObject {
    NSManagedObjectContext *context;
    NSMutableArray *loadedBusStops;
}

- (void) fetchBusStops;
- (NSArray *) getAllStops;
- (NSArray *) getStopByPrefix:(NSString *)prefix;
- (BusStop *) getStopWithNameAndLetter:(NSString *)stopName andLetter:(NSString *)letter;
- (BusStopStatus *) getCountDown:(BusStop *)busStop;
- (NSArray *) getFavouritesBusStops;
- (NSArray *) getRecentBusStops;

// Dont use yet
- (NSArray *) getCountDownByRouteID:(BusStop *)busStop andRouteID:(NSString *)routeID;







@end
