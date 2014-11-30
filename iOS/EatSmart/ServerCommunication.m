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


-(void) loadDataFromServerWithURL:(NSString *) url andParameters:(NSString *) parameters andHTTPMethod:(NSString*) httpRequestMethods {
    [self performSelectorInBackground:@selector(backgroundLoading:) withObject:@[url,parameters,httpRequestMethods]];
}

- (void) backgroundLoading:(NSArray *)array{
    NSString *url = array[0];
    NSString *data = array[1];
    NSString *httpRequestMethods = array[2];
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:httpRequestMethods];
    NSLog(@"%@",request);
    
  //  NSString *post =data;
  //  NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
  //  [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    [self performSelectorOnMainThread:@selector(finishedCatchingData:) withObject:responseData waitUntilDone:NO];
    NSString *someString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
}

-(void) finishedCatchingData:(NSData *) ausgabe {
    NSString *someString = [[NSString alloc] initWithData:ausgabe encoding:NSUTF8StringEncoding];

    [delegate finishedServerCommunication:ausgabe fromServer:self.tag];
}


+(void) loadImageFromURLInBackgroundAndPutInImageView:(NSArray *) urlAndImageView {
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[urlAndImageView objectAtIndex:0]]]];
    UIImageView *imageView = [urlAndImageView objectAtIndex:1];
    [imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
}




@end
