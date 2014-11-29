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
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://10.60.36.31:5000/0.2.1b/meals/search/48.742627/9.095000"]];
    if(data) {

    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSArray *mealsHuelle = [JSON objectForKey:@"results"];
    
    NSMutableArray *meals = [[NSMutableArray alloc] init];
    
    for(NSDictionary *dic in mealsHuelle) {
        Meal *meal =  [[Meal alloc] initWithJSON:dic];
        [meals addObject:meal];
    }
    
    return [NSArray arrayWithArray:meals];
    }
    Meal *meal = [[Meal alloc] initDummy];
    return @[meal,meal];
}







@end