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
@property(readonly) NSInteger uuid;
@property(readonly) NSString *name;
@property(readonly) NSNumber *numberOfMaxPersons;
@property(readonly) NSNumber *numberOfCurrentPersons;
@property(readonly) NSDate *timeStamp;

@property(readonly) NSString *profilePicString;

@property(readonly) NSNumber *price;
@property(readonly) NSNumber *rating;

@property(readonly) NSString *locationDescription;
@property(readonly) CLLocationCoordinate2D gpsLocation;
@property(readonly) NSNumber *walkDistanceInSeconds;

@property(readonly) bool isCookEvent;

-(id)initWithJSON:(NSDictionary *) JSON;
-(id) initDummy;


@end
