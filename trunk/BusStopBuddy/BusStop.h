//
//  BusStop.h
//  mLondonBus
//
//  Created by Franco Raimondi on 08/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BusStop : NSObject {

    NSString *_stopId;
    NSString *_stopName;
    NSString *_stopLetter;
    BOOL _favourite;
    NSDate *_lastUsage;
}

@property (nonatomic, retain) NSString *stopId;
@property (nonatomic, retain) NSString *stopName;
@property (nonatomic, retain) NSString *stopLetter;
@property (nonatomic) BOOL favourite;
@property (nonatomic, retain) NSDate *lastUsage;

- (id) initWithId:(NSString *)stopId andName:(NSString *)stopName andLetter:(NSString *)stopLetter;

@end
