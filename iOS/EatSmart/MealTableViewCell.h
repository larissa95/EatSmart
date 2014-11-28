//
//  MealTableViewCell.h
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"

@interface MealTableViewCell : UITableViewCell

@property(nonatomic) UIImageView *picture;
@property(nonatomic) UILabel *mealNameLabel;
@property(nonatomic) UILabel *ratingLabel;

-(void) setMeal:(Meal *) meal;

@end
