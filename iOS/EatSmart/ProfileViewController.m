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

-(void) loadUserIdFromServer{
   
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://10.60.36.31:5000/0.2.1b/meals/search/48.742627/9.095000"]];
        
        if(data) {
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSArray *mealsHuelle = [JSON objectForKey:@"results"];
            
            NSMutableArray *meals = [[NSMutableArray alloc] init];
            
            for(NSDictionary *dic in mealsHuelle) {
                Meal *meal =  [[Meal alloc] initWithJSON:dic];
                [meals addObject:meal];
            }
            
            mealSuggestions = [NSArray arrayWithArray:meals];
            [table performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
            [refreshControl endRefreshing];
        } else {
            Meal *meal = [[Meal alloc] initDummy];
            mealSuggestions =  @[meal,meal];
            [table performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
            [refreshControl endRefreshing];
        }
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
