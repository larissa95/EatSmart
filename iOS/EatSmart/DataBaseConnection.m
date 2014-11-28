//
//  DataBaseConnection.m
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "DataBaseConnection.h"

@implementation DataBaseConnection


+(NSArray *) mealSuggestions {
    Meal *meal = [[Meal alloc] initDummy];
    return @[meal,meal,meal];
}


@end