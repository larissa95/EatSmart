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
        
       /* @app.route('/0.2.1b/user/create', methods=['POST'])
        def createUser():
        
        new_user = User()
        session = DBSession()
        session.add(new_user)
        session.commit()
        userDic = {"success": True, "userId":new_user.id}
        session.close()
        return jsonify(userDic)
        
        [LocalDataBase setUserId:(int)] */
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
