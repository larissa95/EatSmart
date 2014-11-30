//
//  ProfileViewController.h
//  EatSmart
//
//  Created by Larissa Laich on 29.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalDataBase.h"
#import "ServerUrl.h"
#import "PayPalMobile.h"
#import "ServerCommunication.h"
#import "User.h"

@interface ProfileViewController : UIViewController

@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property(nonatomic, strong, readwrite) UILabel *intro;
@property(nonatomic, strong, readwrite) UIButton *loginButton;


@end
