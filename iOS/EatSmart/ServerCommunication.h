//
//  ServerCommunication.h
//  Ticket
//
//  Created by Frederik Riedel on 07.06.14.
//  Copyright (c) 2014 Frederik Riedel. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;
@protocol ServerDelegate <NSObject>

@required
-(void) finishedServerCommunication:(NSData *) output fromServer:(int) serverTag;

@end

@interface ServerCommunication : NSObject
@property(nonatomic) int tag;

-(void) loadDataFromServerWithURL:(NSString *) url andParameters:(NSString *) parameters andHTTPMethod:(NSString*) httpRequestMethods;
+(void) loadImageFromURLInBackgroundAndPutInImageView:(NSArray *) urlAndImageView;
@property (strong, nonatomic) id<ServerDelegate> delegate;

@end
