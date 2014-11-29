//
//  MealDetailViewController.h
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"

@interface MealDetailViewController : UIViewController


@property(nonatomic) UIWebView *mealView;
-(id) initWithMeal:(Meal *) meal;

@end
