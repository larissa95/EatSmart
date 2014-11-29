//
//  ServerCommunication.m
//  Ticket
//
//  Created by Frederik Riedel on 07.06.14.
//  Copyright (c) 2014 Frederik Riedel. All rights reserved.
//

#import "ServerCommunication.h"

@implementation ServerCommunication

@synthesize delegate;

-(void) loadDataFromServerWithURL:(NSString *) url andParameters:(NSString *) parameters {
    [self performSelectorInBackground:@selector(backgroundLoading:) withObject:@[url,parameters]];
}

- (void) backgroundLoading:(NSArray *)array{
    NSString *url = array[0];
    NSString *data = array[1];

    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    
    NSString *post =data;
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    [self performSelectorOnMainThread:@selector(finishedCatchingData:) withObject:responseData waitUntilDone:NO];
}

-(void) finishedCatchingData:(NSData *) ausgabe {
    [delegate finishedServerCommunication:ausgabe];
}





@end
