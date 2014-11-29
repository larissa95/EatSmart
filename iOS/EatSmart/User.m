//
//  User.m
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize uuid,name,profilePicURL,guestRating,hostRating,registerdsince,gender,phoneNumber,age;

-(id) initWithJSON:(NSDictionary *) JSON {
    self = [super init];    
    
    if(self) {
        uuid = [JSON valueForKey:@"hostId"];

        if(uuid == (id)[NSNull null]) {
            NSLog(@"j");
        }

        
        name = [JSON objectForKey:@"hostname"];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzz"];
        registerdsince = [dateFormat dateFromString:[JSON objectForKey:@"registerdsince"]];
        
        gender = [JSON objectForKey:@"gender"];
        phoneNumber = [JSON objectForKey:@"phone"];
        age=[JSON objectForKey:@"age"];
    }
    
    return self;
}

-(id) initDummy {
    self = [super init];
    
    if(self) {
        
    }
    
    return self;
    
}

-(int) averageHostRating {
    return 3;
}

@end
