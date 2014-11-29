//
//  MealHeadView.h
//  EatSmart
//
//  Created by Frederik Riedel on 29.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"
#import "ServerCommunication.h"

@interface MealHeadView : UIView

@property(nonatomic) UIImageView *profilePic;
@property(nonatomic) UIImageView *cookoreatPic;
@property(nonatomic) UILabel *cookoreatLabel;
@property(nonatomic) UIButton *buy;
@property(nonatomic) UILabel *title;
@property(nonatomic) UILabel *hostRating;
@property(nonatomic) int buyStatusForThisUser;
@property(nonatomic) Meal *meal;


-(id) initWithMeal:(Meal *) meal;


@end
