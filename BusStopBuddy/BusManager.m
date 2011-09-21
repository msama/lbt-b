//
//  BusManager.m
//  mLondonBus
//
//  Created by Franco Raimondi on 09/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BusManager.h"
#import "JSON.h"

@implementation BusManager

- (id) init {
    self = [super init];
    if (self != nil) {
        //mLondonBusAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        //context = [[delegate managedObjectContext] retain]; 
        [self fetchBusStops];
    }
    return self;
}

- (void) dealloc {
    [loadedBusStops release];
    [super dealloc];
}

/*
 Loads busstops.dat if it exists (containing favourites etc.
 If the file does not exist, create it from bus_stops.txt.
 TODO: this could be the place to refresh the list when it is too old?
 */
- (void) fetchBusStops {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:@"busstops.dat"];
    
    BOOL busstopsExists = [[NSFileManager defaultManager] fileExistsAtPath:fileName];
    
    if (busstopsExists==YES) {
        // If busstops.dat exists, load content
        //loadedBusStops = [[NSMutableArray alloc ]initWithContentsOfFile: fileName];
        
        // loading
        NSData *data = [NSData dataWithContentsOfFile:fileName];
        NSKeyedArchiver *archiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        loadedBusStops = [[archiver decodeObjectForKey:@"stops"] retain];
        [archiver release];
        
        if(loadedBusStops == nil)
        {
            NSLog(@"Something went wrong while loading busstops.dat!");
        }
    } else {
        // If busstops.dat does not exist, load data from JSON files
        NSError *error;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bus_stops" ofType:@"txt"];
        NSString *rawData = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];

        NSDictionary *allData = [rawData JSONValue];
        NSArray *busStops = [allData objectForKey:@"markers"];
        loadedBusStops = [[NSMutableArray array] retain];
        
        for (NSDictionary *busStop in busStops) {
            NSString *stopID = [busStop objectForKey:@"id"];
            NSString *stopName = [busStop objectForKey:@"name"];
            NSString *stopLetter = [busStop objectForKey:@"stopIndicator"];
        
            BusStop *stop = [[BusStop alloc] initWithId:stopID andName:stopName andLetter:stopLetter];
            [loadedBusStops addObject:stop];
            [stop release];
        }
        [self saveBusStops];
    }
}


- (void) setFavouriteBusStop:(BusStop *)busStop {
    if (favouritesBusStop == nil) {
        [self getFavouriteBusStops];
    }
    if ([favouritesBusStop containsObject:busStop]) {
        return;
    }
    [favouritesBusStop addObject:busStop];
    [self saveFavourites];
}
    
    
- (void) unsetFavouriteBusStop:(BusStop *)busStop {
    if (favouritesBusStop == nil) {
        [self getFavouriteBusStops];
    }
    [favouritesBusStop removeObject:busStop];
    [self saveFavourites];
}

- (void) saveBusStops {
    
    // TODO: this name is repeated in fetchBusStops, remove duplicate code.
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:@"busstops.dat"];
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:loadedBusStops forKey:@"stops"];
    
    [archiver finishEncoding];
    BOOL success = [data writeToFile:fileName atomically:YES];
    if (!success) {
        NSLog(@"Something went wrong while writing busstops.dat!");
    }
    [archiver release];
    [data release];
}

- (void) saveFavourites {
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:favouritesBusStop forKey:@"favourites"];
    
    [archiver finishEncoding];
    BOOL success = [data writeToFile:favouritesFileName atomically:YES];
    if (!success) {
        NSLog(@"Something went wrong while writing busstops.dat!");
    }
    [archiver release];
    [data release];
}


- (NSArray *) getAllStops {
    return [NSArray arrayWithArray:loadedBusStops];
}

- (NSArray *) getStopByPrefix:(NSString *)prefix {
    prefix = [prefix lowercaseString];
    NSMutableArray *queryRes = [[[NSMutableArray alloc] init] autorelease];
    for (BusStop *stop in loadedBusStops) {
        if ([[stop.stopName lowercaseString]  hasPrefix:prefix]) {
            [queryRes addObject:stop];
        }
    }
    return queryRes;
}

- (BusStop *) getStopWithNameAndLetter:(NSString *)stopName andLetter:(NSString *)letter {
    stopName = [stopName lowercaseString];
    for (BusStop *stop in loadedBusStops) {
        if ([[stop.stopName lowercaseString] isEqual:stopName] && [stop.stopLetter isEqual:letter]) {
            return stop;
        }
    }
    return nil;
}

- (BusStopStatus *) getCountDown:(BusStop *)busStop {

    NSString *urlString = [NSString stringWithFormat:@"http://www.eis.mdx.ac.uk/appacademy/dummy.json"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    
    
    
    NSError *error;
    NSString *responseString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    NSDictionary *dictionary = [responseString JSONValue];
    
    if ([dictionary count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"The service is temporary offline. Please try again later or check http://countdown.tfl.gov.uk/ for further updates."
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert autorelease];
        [alert show];
    }
    
    
    // Initialize with lastUpdated and dummy data.
    BusStopStatus *status = [[[BusStopStatus alloc] initWithId:busStop] autorelease];
    status.lastUpdated = [dictionary objectForKey:@"lastUpdated"];
    
    
    // Getting arrivals
    NSArray *arrivals = [dictionary objectForKey:@"arrivals"];
    
    // Populating BusStopStatus arrivals with values from dictionary
    for(NSDictionary *myDict in arrivals) {
        BusInfo *info = [[[BusInfo alloc]
                          initWithId:[myDict objectForKey:@"routeId"]
                          andDestination:[myDict objectForKey:@"destination"]
                          andestimatedWait:[myDict objectForKey:@"estimatedWait"]
                          ] autorelease];
        
        [[status arrivals] addObject:info];
    }
    
    
    
    return status;
}


- (NSArray *) getCountDownByRouteID:(BusStop *)busStop andRouteID:(NSString *)routeID {
    return nil;
}


- (NSArray*) getFavouriteBusStops {
    if (favouritesBusStop == nil) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        favouritesFileName = [[documentsDirectory stringByAppendingPathComponent:@"busstops_fav.dat"] retain];
        NSData *data = [NSData dataWithContentsOfFile:favouritesFileName];
        NSKeyedArchiver *archiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        favouritesBusStop = [[archiver decodeObjectForKey:@"favourites"] retain];
        if (favouritesBusStop == nil) {
            favouritesBusStop = [[[NSMutableArray alloc] init] retain];
        }
        [archiver release];
    }
    return favouritesBusStop;
}


- (BusStop *) getStopWithID:(NSString *)stopID {
    // Looking for the index of the bus stop (see online documentation, works with iOS > 4.0)
    NSUInteger idx = [loadedBusStops indexOfObjectPassingTest:
                      ^BOOL(id obj, NSUInteger idx, BOOL *stop)
                      {
                          BusStop *mybs = obj;
                          return [mybs.stopId isEqualToString:stopID];
                      }];
    
    // Set favourite to YES
    
    return [loadedBusStops objectAtIndex:idx];

}



- (NSArray *) getRecentBusStops  {
    return [NSArray array];
}


@end
