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
#import "ServerCommunication.h"

@interface MealTableViewCell : UITableViewCell

@property(nonatomic) UIImageView *picture;
@property(nonatomic) UILabel *mealNameLabel;
@property(nonatomic) UILabel *distanceDescriptionLabel;
@property(nonatomic) UILabel *timeLabel;
@property(nonatomic) UILabel *priceLabel;
@property(nonatomic) UILabel *starLabel;
@property(nonatomic) UIImageView *cookoreatPic;


-(void) setMeal:(Meal *) meal;

@end
