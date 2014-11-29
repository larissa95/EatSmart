//
//  MealTableViewCell.m
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "MealTableViewCell.h"

@implementation MealTableViewCell
@synthesize picture,mealNameLabel,distanceDescriptionLabel,timeLabel,priceLabel,starView;

-(id) init {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mealCell"];
    
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    picture = [[UIImageView alloc] init];
    picture.contentMode=UIViewContentModeScaleAspectFill;
    picture.layer.cornerRadius=picture.frame.size.width/2;
    picture.layer.masksToBounds=YES;
    
    [self addSubview:picture];
    
    mealNameLabel = [[UILabel alloc] init];
    mealNameLabel.font=[UIFont fontWithName:@"Helveticaneue-light" size:20];
    [self addSubview:mealNameLabel];
    
    
    distanceDescriptionLabel = [[UILabel alloc] init];
    distanceDescriptionLabel.font=[UIFont fontWithName:@"Helveticaneue-light" size:13];
    [self addSubview:distanceDescriptionLabel];
    
    timeLabel = [[UILabel alloc] init];
    timeLabel.font=[UIFont fontWithName:@"Helveticaneue-bold" size:19];
    [self addSubview:timeLabel];
    
    priceLabel = [[UILabel alloc] init];
    priceLabel.font = [UIFont fontWithName:@"Helveticaneue-light" size:17];
    [self addSubview:priceLabel];
    
    starView = [[AMRatingControl alloc]initWithLocation:CGPointMake(0, 0) emptyColor:[UIColor orangeColor] solidColor:[UIColor orangeColor] andMaxRating:5];
    
    starView.userInteractionEnabled=NO;
    
    [self addSubview:starView];
    
    return self;
}

-(void) setMeal:(Meal *) meal {
    
    if(!meal.host.profilePic) {
        picture.image=[UIImage imageNamed:@"defaultUser.png"];
    } else {
        picture.image=meal.host.profilePic;
    }
    
    
    mealNameLabel.text=meal.name;
    distanceDescriptionLabel.text = [NSString stringWithFormat:@"%@ min walking",meal.walkDistanceInMinutes];
    
    priceLabel.text = [NSString stringWithFormat:@"%.2f EUR",[meal.price floatValue]];
    
    
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"HH:mm a"];
    NSString* dateStr = [[fmt stringFromDate:meal.timeStamp] lowercaseString];
    

    timeLabel.text = [NSString stringWithFormat:@"%@",dateStr];
    
    
    [starView setRating:[meal.host averageHostRating]];
}


-(void) layoutSubviews {
    [super layoutSubviews];
    picture.frame=CGRectMake(10, 10, self.frame.size.height-20, self.frame.size.height-20);
    picture.layer.cornerRadius=picture.frame.size.width/2;
    mealNameLabel.frame=CGRectMake(self.frame.size.height, 17, self.frame.size.width-self.frame.size.height-115, 20);
    
    distanceDescriptionLabel.frame=CGRectMake(self.frame.size.height, 41, self.frame.size.width-self.frame.size.height-115, 17);
    
    timeLabel.frame=CGRectMake(self.frame.size.width-115, 29, 125, 20);
    priceLabel.frame=CGRectMake(self.frame.size.width-115, 50, 125, 20);
    
    starView.frame=CGRectMake(self.frame.size.height, 63, self.frame.size.width-self.frame.size.height-115, 25);
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
