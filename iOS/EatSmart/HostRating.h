//
//  HostRating.h
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HostRating : NSObject

@property(readonly) NSMutableArray *reviewTexts;

@property(readonly) NSNumber *quality;
@property(readonly) NSNumber *ambiente;
@property(readonly) NSNumber *quantity;
@property(readonly) NSNumber *mood;


@end
