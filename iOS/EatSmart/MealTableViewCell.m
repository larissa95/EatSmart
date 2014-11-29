//
//  MealTableViewCell.m
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "MealTableViewCell.h"

@implementation MealTableViewCell
@synthesize picture,mealNameLabel,distanceDescriptionLabel,timeLabel,priceLabel,starLabel,cookoreatPic;

-(id) init {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mealCell"];
    
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    picture = [[UIImageView alloc] init];
    picture.contentMode=UIViewContentModeScaleAspectFill;
    picture.layer.cornerRadius=picture.frame.size.width/2;
    picture.layer.masksToBounds=YES;
    picture.layer.borderColor=[[UIColor grayColor] CGColor];
    picture.layer.borderWidth=1;
    
    [self addSubview:picture];
    
    mealNameLabel = [[UILabel alloc] init];
    mealNameLabel.font=[UIFont fontWithName:@"Helveticaneue-light" size:20];
    [self addSubview:mealNameLabel];
    
    
    distanceDescriptionLabel = [[UILabel alloc] init];
    distanceDescriptionLabel.font=[UIFont fontWithName:@"Helveticaneue-light" size:13];
    [self addSubview:distanceDescriptionLabel];
    
    timeLabel = [[UILabel alloc] init];
    timeLabel.textAlignment=NSTextAlignmentRight;
    timeLabel.font=[UIFont fontWithName:@"Helveticaneue-bold" size:19];
    [self addSubview:timeLabel];
    
    priceLabel = [[UILabel alloc] init];
    priceLabel.textAlignment=NSTextAlignmentRight;
    priceLabel.font = [UIFont fontWithName:@"Helveticaneue-light" size:17];
    [self addSubview:priceLabel];
    
    starLabel = [[UILabel alloc] init];
    starLabel.font=[UIFont fontWithName:@"" size:20];
    starLabel.textColor=[UIColor colorWithRed:70/255.0 green:129/255.0 blue:192/255.0 alpha:1.0];
    
    [self addSubview:starLabel];
    
    cookoreatPic = [[UIImageView alloc] init];
    [self addSubview:cookoreatPic];
    
    
    
    return self;
}

-(void) loadImageFromURLInBackgroundAndPutInImageView:(NSArray *) urlAndImageView {
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[urlAndImageView objectAtIndex:0]]]];
    UIImageView *imageView = [urlAndImageView objectAtIndex:1];
    [imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
}



-(void) setMeal:(Meal *) meal {
    
    picture.image = [UIImage imageNamed:@"PlaceholderProfileImage.png"];
    if(meal.profilePicString) {
        [ServerCommunication performSelectorInBackground:@selector(loadImageFromURLInBackgroundAndPutInImageView:) withObject:@[meal.profilePicString,picture]];
    }
    
    
    
    
    
    if(meal.isCookEvent) {
        cookoreatPic.image=[UIImage imageNamed:@"Cook.png"];
    } else {
        cookoreatPic.image=[UIImage imageNamed:@"Eat.png"];
    }
    
    
    mealNameLabel.text=meal.name;
    distanceDescriptionLabel.text = [NSString stringWithFormat:@"%u min walking",[meal.walkDistanceInSeconds intValue]/60];
    
    priceLabel.text = [NSString stringWithFormat:@"%.2f €",[meal.price floatValue]];
    
    
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"HH:mm a"];
    NSString* dateStr = [[fmt stringFromDate:meal.timeStamp] lowercaseString];
    
    
    timeLabel.text = [NSString stringWithFormat:@"%@",dateStr];
    
    
    NSString *ratingString = @"";
    
    if(meal.rating) {
        for(int i=0; i<[meal.rating intValue]; i++) {
            ratingString = [NSString stringWithFormat:@"%@★",ratingString];
        }
        for(int i=[meal.rating intValue]; i<5; i++) {
            ratingString = [NSString stringWithFormat:@"%@☆",ratingString];
        }
    }
    starLabel.text=ratingString;
    
}


-(void) layoutSubviews {
    [super layoutSubviews];
    picture.frame=CGRectMake(10, 10, self.frame.size.height-20, self.frame.size.height-20);
    picture.layer.cornerRadius=picture.frame.size.width/2;
    mealNameLabel.frame=CGRectMake(self.frame.size.height+24, 14, self.frame.size.width-self.frame.size.height-115, 25);
    cookoreatPic.frame=CGRectMake(self.frame.size.height, 17, 20, 20);
    
    
    distanceDescriptionLabel.frame=CGRectMake(self.frame.size.height, 41, self.frame.size.width-self.frame.size.height-115, 17);
    
    timeLabel.frame=CGRectMake(self.frame.size.width-140, 29, 100, 20);
    priceLabel.frame=CGRectMake(self.frame.size.width-140, 50, 100, 20);
    
    starLabel.frame=CGRectMake(self.frame.size.height, 57, self.frame.size.width-self.frame.size.height, 25);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
