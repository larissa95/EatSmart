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
-(void) finishedServerCommunication:(NSData *) output;

@end

@interface ServerCommunication : NSObject


-(void) loadDataFromServerWithURL:(NSString *) url andParameters:(NSString *) parameters;
+(void) loadImageFromURLInBackgroundAndPutInImageView:(NSArray *) urlAndImageView;
@property (strong, nonatomic) id<ServerDelegate> delegate;

@end
