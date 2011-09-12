//
//  BusStopStatus.h
//  mLondonBus
//
//  Created by Franco Raimondi on 09/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BusStopStatus : NSObject {
    NSString *_stopID;
    NSString *_lastUpdated;
    NSString *_infoMessages;
    NSString *_importantMessages;
    NSString *_criticalMessages;
    NSMutableArray *_arrivals;
}

@property (nonatomic, retain) NSString *stopID;
@property (nonatomic, retain) NSString *lastUpdated;
@property (nonatomic, retain) NSString *infoMessages;
@property (nonatomic, retain) NSString *importantMessages;
@property (nonatomic, retain) NSString *criticalMessages;
@property (nonatomic, retain) NSMutableArray *arrivals;

- (id) initWithId:(NSString *)stopID andLastUpdated:(NSString *)lastUpdated andInfoMessages:(NSString *)infoMessages andImportantMessages:(NSString *)importantMessage andCriticalMessages:(NSString *)criticalMessages;

@end
