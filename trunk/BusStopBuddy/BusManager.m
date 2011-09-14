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
        loadedBusStops = [[NSMutableArray array] retain];
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
    NSString *fileName = [[documentsDirectory stringByAppendingPathComponent:@"busstops.dat"] retain];
    
    NSLog(@"%@",fileName);
    
    BOOL busstopsExists = [[NSFileManager defaultManager] fileExistsAtPath:fileName];
    
    NSLog(@"%@",fileName);
    
    if (busstopsExists==YES) {
        // If busstops.dat exists, load content
        loadedBusStops = [[NSMutableArray alloc ]initWithContentsOfFile: fileName];
        if(loadedBusStops == nil)
        {
            NSLog(@"Something went wrong while loading busstops.dat!");
        }
    } else {
        // If busstops.dat does not exist, load data from JSON files
        NSLog(@"%@",fileName);
        NSError *error;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bus_stops" ofType:@"txt"];
        NSString *rawData = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];

        NSDictionary *allData = [rawData JSONValue];
        NSArray *busStops = [allData objectForKey:@"markers"];
        
        for (NSDictionary *busStop in busStops) {
            NSString *stopID = [busStop objectForKey:@"id"];
            NSString *stopName = [busStop objectForKey:@"name"];
            NSString *stopLetter = [busStop objectForKey:@"stopIndicator"];
        
            BusStop *stop = [[BusStop alloc] initWithId:stopID andName:stopName andLetter:stopLetter];
            [loadedBusStops addObject:stop];
            [stop release];
        }
        BOOL result;
        result = [loadedBusStops writeToFile:fileName atomically:YES];
    
        if (!result) {
            NSLog(@"Something went wrong while trying to save the initial bus stop list");
        }
    }
}

- (NSArray *) getAllStops {
    return [NSArray arrayWithArray:loadedBusStops];
}

- (NSArray *) getStopByPrefix:(NSString *)prefix {
    NSMutableArray *queryRes = [[NSMutableArray alloc] init];
    for (BusStop *stop in loadedBusStops) {
        if ([stop.stopName hasPrefix:prefix]) {
            [queryRes addObject:stop];
        }
    }
    return queryRes;
}

- (BusStop *) getStopWithNameAndLetter:(NSString *)stopName andLetter:(NSString *)letter {
    for (BusStop *stop in loadedBusStops) {
        if ([stop.stopName isEqual:stopName] && [stop.stopLetter isEqual:letter]) {
            return stop;
        }
    }
    return nil;
}




- (BusStopStatus *) getCountDown:(BusStop *)busStop {
    
    NSString *urlString = [NSString stringWithFormat:@"http://countdown.tfl.gov.uk/stopBoard/%@", busStop.stopId];
    NSURL *url = [NSURL URLWithString:urlString];
    
    //NSData *responseData = [NSData dataWithContentsOfURL:url];
    NSError *error;
    NSString *responseString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
	NSLog(@"Raw response: %@", responseString);
    
    
    NSDictionary *dictionary = [responseString JSONValue];
    
    
    // Initialize with lastUpdated and dummy data.
    BusStopStatus *status = [[BusStopStatus alloc] initWithId:busStop.stopId andLastUpdated:[dictionary objectForKey:@"lastUpdated"] andInfoMessages:@"info" andImportantMessages:@"important" andCriticalMessages:@"critical"];
    
    
    // Getting arrivals
    NSArray *arrivals = [dictionary objectForKey:@"arrivals"];

    // Populating BusStopStatus arrivals with values from dictionary
    for(NSDictionary *myDict in arrivals) {
        BusInfo *info = [[[BusInfo alloc]
                          initWithId:[myDict objectForKey:@"routeId"]
                          andDestination:[myDict objectForKey:@"destination"]
                          andestimatedWait:[myDict objectForKey:@"estimatedWait"]
                          andscheduledTime:[myDict objectForKey:@"scheduledTime"]] autorelease];
        
        [[status arrivals] addObject:info];
    }
    
    // Parsing disruptions
    // NSDictionary *siDict = [dictionary objectForKey:@"serviceDisruptions"];

    //TODO
    status.infoMessages = @""; //[siDict objectForKey:@"infoMessages"];
    status.importantMessages = @""; //[siDict objectForKey:@"importantMessages"];
    status.criticalMessages = @""; //[siDict objectForKey:@"criticalMessages"];
    
    return status;
}


- (NSArray *) getCountDownByRouteID:(BusStop *)busStop andRouteID:(NSString *)routeID {
    return nil;
}


- (NSArray *) getFavouritesBusStops {
    NSMutableArray *stops = [[NSMutableArray alloc ] init];
    for (BusStop *stop in loadedBusStops) {
        if (stop.favourite == YES) {
            [stops addObject:stop];
        }
    }
    return stops;
}
- (NSArray *) getRecentBusStops  {
    return [NSArray array];
}


@end
