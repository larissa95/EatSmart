//
//  User.h
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HostRating.h"
#import <UIKit/UIKit.h>

@interface User : NSObject

@property(readonly) NSInteger uuid;
@property(readonly) NSString *name;
@property(readonly) NSString *profilePicURL;
@property(readonly) NSString *gender;
@property(readonly) NSString *phoneNumber;
@property(readonly) NSInteger age;

@property(readonly) NSNumber *guestRating;
@property(readonly) HostRating *hostRating;

@property(readonly) NSDate *registerdsince;

-(int) averageHostRating;
-(id) initDummy;
-(id) initWithJSON:(NSDictionary *) JSON;


@end
