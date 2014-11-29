//
//  Meal.m
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "Meal.h"


@implementation Meal
@synthesize uuid,name,numberOfCurrentPersons,numberOfMaxPersons,timeStamp,price,walkDistanceInSeconds,host,rating,isCookEvent;
-(id)initWithJSON:(NSDictionary *) JSON {
    self = [super init];

    if(self) {
        uuid = [JSON objectForKey:@"mealId"];
        name = [JSON objectForKey:@"mealName"];

        
        numberOfCurrentPersons = [JSON objectForKey:@"numberOfCurrentPersons"];
        numberOfMaxPersons = [JSON objectForKey:@"numberOfMaxPersons"];
        
        rating = [JSON objectForKey:@"rating"];
        
        NSString *dateStr = [JSON objectForKey:@"date"];
        
        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"E, dd MMM YYYY HH:mm:ss z"];
        timeStamp = [dateFormat dateFromString:dateStr];
        
        price = [JSON objectForKey:@"price"];
        
        walkDistanceInSeconds = [JSON objectForKey:@"walkingTime"];
        
    }
    
    return self;
}

-(id) initDummy {
    self = [super init];
    
    if(self) {
        uuid = @"1";
        name = @"Sauerbraten";
        
        numberOfCurrentPersons = [NSNumber numberWithInt:2];
        numberOfMaxPersons = [NSNumber numberWithInt:6];
        
        timeStamp = [[NSDate alloc] init];
        
        price = [NSNumber numberWithFloat:3.20f];
        
        walkDistanceInSeconds = [NSNumber numberWithFloat:10.f];
        
        host = [[User alloc] initDummy];
        
    }
    
    return self;
}

@end
