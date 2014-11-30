//
//  ProfileViewController.m
//  EatSmart
//
//  Created by Larissa Laich on 29.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if(![LocalDataBase UserIsRegistered]){
        [self loadUserIdFromServer];
    }else{
        NSLog(@"%i",[LocalDataBase userId]);
      /*  ServerCommunication *server = server = [[ServerCommunication alloc] init];
        server.delegate = self;
        server.tag = 1;
        [server loadDataFromServerWithURL:[NSString stringWithFormat:@"%@/user/%i/information",[ServerUrl serverUrl],[LocalDataBase userId]] andParameters:@"" andHTTPMethod:@"GET"];
*/
        /*
        def getUserInformation(userId):
         hostRating = calculateAverageHostRating(userId)
         user = session.query(User).filter(User.id == userId).one()
         userDic = {"success": True,
         "userId": userId,
         "name": user.name,
         "firstLogin": user.firstLogin,
         "age": user.age,
         "phone": user.phone,
         "gender": user.gender,
         "hostRating": hostRating,
         "guestRating": calculateAverageGuestRating(userId)}
         
         return jsonify(userDic)
         */
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) finishedServerCommunication:(NSData *) output fromServer:(int)serverTag{
    if(serverTag == 0){
    if(output){
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:output options:0 error:nil];
        NSLog(JSON.description);
        NSNumber *iden = (NSNumber*)[JSON objectForKey:@"userId"];
        [LocalDataBase setUserId:[iden intValue]];
    }else{
        NSLog(@"nil");
    }
    
    }
    if(serverTag == 1){
        if(output){
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:output options:0 error:nil];
            NSLog(JSON.description);

        }else{
            NSLog(@"nil");
        }
        
    }
    
   
}

-(void) loadUserIdFromServer{
    NSLog(@"casdfsdf");
    ServerCommunication *server = server = [[ServerCommunication alloc] init];
    server.delegate = self;
    server.tag = 0;
    [server loadDataFromServerWithURL:[NSString stringWithFormat:@"%@/user/create",[ServerUrl serverUrl]] andParameters:@"" andHTTPMethod:@"POST"];
    
    //block
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
