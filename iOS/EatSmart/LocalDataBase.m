//
//  LocalDataBase.m
//  EatSmart
//
//  Created by Frederik Riedel on 29.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "LocalDataBase.h"

@implementation LocalDataBase
static int uuid = -1;


+(void) setUserId:(int) _id{
    NSLog(@"%d",_id);
    NSString *string = [NSString stringWithFormat:@"%u",_id];
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [documentsPath stringByAppendingPathComponent:@"user.txt"];
    [string writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+(int) userId{
    [self UserIsRegistered];
    return uuid;
}


+(Boolean) UserIsRegistered{
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* uuID = [documentsPath stringByAppendingPathComponent:@"user.txt"];
    if([[NSFileManager defaultManager] fileExistsAtPath:uuID]){
        [self loadFromLocalTxt];
        if(uuid != -1){
            return true;
        }
    }return false;
}

+(void) loadFromLocalTxt {
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* filePath = [documentsPath stringByAppendingPathComponent:@"user.txt"];
    NSString* string = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    if(string) {
        uuid = [[string componentsSeparatedByString:@"\n"][0] intValue];
    }
}

@end
