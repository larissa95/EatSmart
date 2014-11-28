//
//  MealTableViewCell.m
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "MealTableViewCell.h"

@implementation MealTableViewCell
@synthesize picture,mealNameLabel,ratingLabel;

-(id) init {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mealCell"];
    picture = [[UIImageView alloc] init];
    picture.contentMode=UIViewContentModeScaleAspectFill;
    picture.layer.cornerRadius=picture.frame.size.width/2;
    picture.layer.masksToBounds=YES;
    
    [self addSubview:picture];
    
    mealNameLabel = [[UILabel alloc] init];
    [self addSubview:mealNameLabel];
    
    return self;
}

-(void) setMeal:(Meal *) meal {
    
    if(!meal.host.profilePic) {
        picture.image=[UIImage imageNamed:@"defaultUser.png"];
    } else {
        picture.image=meal.host.profilePic;
    }
    
    
    mealNameLabel.text=meal.name;
}


-(void) layoutSubviews {
    [super layoutSubviews];
    picture.frame=CGRectMake(10, 10, self.frame.size.height-20, self.frame.size.height-20);
    picture.layer.cornerRadius=picture.frame.size.width/2;
    mealNameLabel.frame=CGRectMake(self.frame.size.height, 0, self.frame.size.width-self.frame.size.height, self.frame.size.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
