//
//  User.m
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize uuid,name,profilePicURL,guestRating,hostRating,registerdsince,gender,phoneNumber,age,email;

-(id) initWithJSON:(NSDictionary *) JSON {
    self = [super init];    
    
    if(self) {


        uuid = [[JSON valueForKey:@"hostId"] integerValue];
        
        
        name = [JSON objectForKey:@"hostname"];
        if(name == (id)[NSNull null]) {
            name=nil;
        }
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzz"];
        if([JSON objectForKey:@"registerdsince"] == (id)[NSNull null]) {
            registerdsince=nil;
        } else {
            registerdsince = [dateFormat dateFromString:[JSON objectForKey:@"registerdsince"]];
        }
        
        gender = [JSON objectForKey:@"gender"];
        if(gender == (id)[NSNull null]) {
            gender=nil;
        }
        
        phoneNumber = [JSON objectForKey:@"phone"];
        if(phoneNumber == (id)[NSNull null]) {
            phoneNumber=nil;
        }
        
        age=[JSON objectForKey:@"age"];
        if(age == (id)[NSNull null]) {
            age=nil;
        }
        email=[JSON objectForKey:@"email"];
        if(age == (id)[NSNull null]) {
            age=nil;
        }
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
