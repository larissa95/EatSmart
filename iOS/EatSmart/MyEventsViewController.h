//
//  MyEventsViewController.h
//  EatSmart
//
//  Created by Frederik Riedel on 30.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MealTableViewCell.h"
#import "Meal.h"
#import "ServerUrl.h"
#import "LocalDataBase.h"
#import "MealDetailViewController.h"

@interface MyEventsViewController : UIViewController<UITableViewDataSource>

@property(nonatomic) UITableView *table;
@property(nonatomic) NSMutableArray *myHostedMeals;
@property(nonatomic) NSMutableArray *myPendingMeals;
@property(nonatomic) NSMutableArray *myConfirmedMeals;
@property(nonatomic) UIRefreshControl *refreshControl;

@end
