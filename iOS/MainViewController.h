//
//  MainViewController.h
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MealTableViewCell.h"
#import "DataBaseConnection.h"

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic) UITableView *table;
@property(nonatomic) NSArray *mealSuggestions;

@end
