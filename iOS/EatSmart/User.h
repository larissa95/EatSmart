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

@property(readonly) NSString *uuid;
@property(readonly) NSString *name;
@property(readonly) UIImage *profilePic;

@property(readonly) NSNumber *guestRating;
@property(readonly) HostRating *hostRating;





@end
