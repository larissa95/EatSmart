//
//  MealDetailViewController.h
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"
#import "MealHeadView.h"
#import "MealDetailTableViewCell.h"

@interface MealDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>


@property(nonatomic) UIWebView *mealView;
@property(nonatomic) MealHeadView *mealHeadView;
@property(nonatomic) UITableView *table;
@property(nonatomic) UISegmentedControl *segmentControl;
@property(nonatomic) Meal *meal;
@property(nonatomic) NSMutableArray *reviews;

-(id) initWithMeal:(Meal *) meal;


@end
