//
//  MealDetailTableViewCell.m
//  EatSmart
//
//  Created by Frederik Riedel on 29.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "MealDetailTableViewCell.h"

@implementation MealDetailTableViewCell
@synthesize titleLabel,descriptionLabel;

-(id) init {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mealdetailinformation"];
    
    if(self) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.textColor=[UIColor colorWithRed:70/255.0 green:129/255.0 blue:192/255.0 alpha:1.0];
        titleLabel.font=[UIFont fontWithName:@"Helveticaneue" size:17];
        [self addSubview: titleLabel];
        
        descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.font=[UIFont fontWithName:@"Helveticaneue" size:22];
        descriptionLabel.numberOfLines=-1;
        [self addSubview:descriptionLabel];
    }
    
    return self;
}


-(void) layoutSubviews {
    [super layoutSubviews];
    titleLabel.frame=CGRectMake(10, 0, self.frame.size.width-10, 22);
    descriptionLabel.frame=CGRectMake(10, 17, self.frame.size.width-10, self.frame.size.height-17);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
