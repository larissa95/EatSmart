//
//  Meal.m
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "Meal.h"


@implementation Meal
@synthesize uuid,name,numberOfCurrentPersons,numberOfMaxPersons,timeStamp,price,walkDistanceInSeconds,host,rating,isCookEvent,gpsLocation,profilePicString,locationDescription;
-(id)initWithJSON:(NSDictionary *) JSON {
    self = [super init];

    if(self) {
        uuid = [[JSON objectForKey:@"mealId"] integerValue];
        
        name = [JSON objectForKey:@"mealName"];
        
        
        numberOfCurrentPersons = [JSON objectForKey:@"guest_attending"];
        numberOfMaxPersons = [JSON objectForKey:@"maxGuests"];
        
        rating = [JSON objectForKey:@"rating"];
        
        NSString *dateStr = [JSON objectForKey:@"date"];
        
        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzz"];
        timeStamp = [dateFormat dateFromString:dateStr];
        
        price = [JSON objectForKey:@"price"];
        
        walkDistanceInSeconds = [JSON objectForKey:@"walkingTime"];
        
        if([[JSON objectForKey:@"typ"] isEqualToString:@"cooking"]) {
            isCookEvent=true;
        } else {
            isCookEvent=false;
        }
        
        gpsLocation=CLLocationCoordinate2DMake([[[JSON objectForKey:@"placeGPS"] objectForKey:@"latitude"] doubleValue], [[[JSON objectForKey:@"placeGPS"] objectForKey:@"longitude"] doubleValue]);
        
        profilePicString = [JSON objectForKey:@"imageUrl"];

        locationDescription = [JSON objectForKey:@"address"];
        
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
        
        walkDistanceInSeconds = [NSNumber numberWithFloat:500.f];
        
        host = [[User alloc] initDummy];
        
        profilePicString = @"http://0.static.wix.com/media/f3cd4142eb0cd3fc50150ad5c7a9a3f8.wix_mp_1024";
        
    }
    
    return self;
}

@end
