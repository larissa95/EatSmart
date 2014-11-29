//
//  MealTableViewCell.h
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"
#import "AMRatingControl.h"

@interface MealTableViewCell : UITableViewCell

@property(nonatomic) UIImageView *picture;
@property(nonatomic) UILabel *mealNameLabel;
@property(nonatomic) UILabel *distanceDescriptionLabel;
@property(nonatomic) UILabel *timeLabel;
@property(nonatomic) UILabel *priceLabel;
@property(nonatomic) AMRatingControl *starView;


-(void) setMeal:(Meal *) meal;

@end
