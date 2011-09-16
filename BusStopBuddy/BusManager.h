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
    NSString *favouritesFileName;
    NSManagedObjectContext *context;
    NSMutableArray *loadedBusStops;
}

- (void) fetchBusStops;
- (NSArray *) getAllStops;
- (NSArray *) getStopByPrefix:(NSString *)prefix;
- (BusStop *) getStopWithNameAndLetter:(NSString *)stopName andLetter:(NSString *)letter;
- (BusStopStatus *) getCountDown:(BusStop *)busStop;
- (NSArray *) getFavouriteBusStops;
- (NSArray *) getRecentBusStops;
- (void) setFavouriteBusStop:(BusStop *)busStop;
- (void) unsetFavouriteBusStop:(BusStop *)busStop;
- (void) saveBusStops;
- (void) saveFavourites;
- (BusStop *) getStopWithID:(NSString *)stopID;


// Dont use yet
- (NSArray *) getCountDownByRouteID:(BusStop *)busStop andRouteID:(NSString *)routeID;

@end
