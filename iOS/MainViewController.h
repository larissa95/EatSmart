//
//  MainViewController.h
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MealTableViewCell.h"
#import "MealDetailViewController.h"
#import "DataBaseConnection.h"
#import "FilterViewController.h"
#import "CreateNewMealViewController.h"
#import "ProfileViewController.h"

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic) UITableView *table;
@property(nonatomic) NSArray *mealSuggestions;
@property(nonatomic) UIToolbar *toolBar;
@property(nonatomic) UIRefreshControl *refreshControl;

@end
