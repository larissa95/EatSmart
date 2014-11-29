//
//  Meal.h
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
#import "User.h"

@interface Meal : NSObject


@property(readonly) User *host;
@property(readonly) NSString *uuid;
@property(readonly) NSString *name;
@property(readonly) NSNumber *numberOfMaxPersons;
@property(readonly) NSNumber *numberOfCurrentPersons;
@property(readonly) NSDate *timeStamp;

@property(readonly) NSNumber *price;

@property(readonly) NSString *locationDescription;
@property(readonly) CLLocation *gpsLocation;
@property(readonly) NSNumber *walkDistanceInSeconds;

-(id)initWithJSON:(NSDictionary *) JSON;
-(id) initDummy;


@end
