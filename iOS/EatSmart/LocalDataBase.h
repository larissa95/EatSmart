//
//  LocalDataBase.h
//  EatSmart
//
//  Created by Frederik Riedel on 29.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalDataBase : NSObject

+(void) setUserId:(int) _id;
+(int) userId;

+(Boolean) UserIsRegistered;


@end
