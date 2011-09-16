//
//  BusInfo.h
//  mLondonBus
//
//  Created by Franco Raimondi on 09/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BusInfo : NSObject {
    NSString *_routeID;
    NSString *_destination;
    NSString *_estimatedWait;
    NSString *_scheduledTime;
}

@property (nonatomic, retain) NSString *routeID;
@property (nonatomic, retain) NSString *destination;
@property (nonatomic, retain) NSString *estimatedWait;
@property (nonatomic, retain) NSString *scheduledTime;

- (id) initWithId:(NSString *)routeID andDestination:(NSString *)destination andestimatedWait:(NSString *)estimatedWait andscheduledTime:(NSString *) scheduledTime;

@end