//
//  CreateNewMealViewController.m
//  EatSmart
//
//  Created by Frederik Riedel on 29.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "CreateNewMealViewController.h"

@interface CreateNewMealViewController ()

@end

@implementation CreateNewMealViewController

- (void)viewDidLoad {
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    navBar.barTintColor = [UIColor colorWithRed:70/255.0 green:129/255.0 blue:192/255.0 alpha:1.0];
    navBar.translucent=NO;
    [self.view addSubview:navBar];
    
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    UINavigationItem *title = [[UINavigationItem alloc] initWithTitle:@"create new event"];

    
    self.view.backgroundColor=[UIColor whiteColor];
    [super viewDidLoad];
    
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle: @"Cancel" style:UIBarButtonItemStylePlain target:self  action:@selector(cancel)];

    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle: @"Create" style:UIBarButtonItemStylePlain target:self  action:@selector(create)];
    
    title.rightBarButtonItem=right;
    title.leftBarButtonItem=left;
    
    navBar.items=@[title];
    
    navBar.barStyle = UIBarStyleBlackTranslucent;
    
    [self setNeedsStatusBarAppearanceUpdate];
    // Do any additional setup after loading the view.
}

-(void) cancel {
    [self dismissModalViewControllerAnimated:YES];
}

-(void) create {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
