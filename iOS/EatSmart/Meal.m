//
//  Meal.m
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "Meal.h"


@implementation Meal
@synthesize uuid,name,numberOfCurrentPersons,numberOfMaxPersons,timeStamp;
-(id)initWithJSON:(NSDictionary *) JSON {
    self = [super init];

    if(self) {
        uuid = [JSON objectForKey:@"uuid"];
        name = [JSON objectForKey:@"name"];

        
        numberOfCurrentPersons = [JSON objectForKey:@"numberOfCurrentPersons"];
        numberOfMaxPersons = [JSON objectForKey:@"numberOfMaxPersons"];
        
        timeStamp = [JSON objectForKey:@"timeStamp"];
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
        
    }
    
    return self;
}

@end
