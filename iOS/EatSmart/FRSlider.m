//
//  FRSlider.m
//  EatSmart
//
//  Created by Frederik Riedel on 29.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "FRSlider.h"

@implementation FRSlider
@synthesize valueLabel,descriptionLabel,scrollView,dragSeparator,colorIndicator;


-(id) initWithName:(NSString *) name Unit:(NSString *) unit min:(float) min max:(float) max currentValue:(float) currentValue nachKommaStellen:(double) roundingIncrement {
    self = [super init];
    
    if(self) {
        NSLog(name);
        
        scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator=NO;
        scrollView.showsVerticalScrollIndicator=NO;
        scrollView.bounces=NO;
        scrollView.decelerationRate=UIScrollViewDecelerationRateFast;
        scrollView.contentOffset=CGPointMake(0, 0);
        scrollView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
        scrollView.backgroundColor=[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        scrollView.delegate=self;
        [self addSubview:scrollView];
        colorIndicator = [[UIView alloc] init];
        colorIndicator.backgroundColor=[UIColor colorWithRed:80/255.0 green:139/255.0 blue:202/255.0 alpha:1.0];
        [scrollView addSubview:colorIndicator];
        
        valueLabel = [[UILabel alloc] init];
        valueLabel.textAlignment=NSTextAlignmentRight;
        valueLabel.text=@"10 m";
        valueLabel.textColor=[UIColor blackColor];
        valueLabel.font=[UIFont fontWithName:@"Helveticaneue-light" size:24];
        [self addSubview:valueLabel];
        
        
        descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.textAlignment = NSTextAlignmentLeft;
        descriptionLabel.text=name;
        descriptionLabel.font=[UIFont fontWithName:@"Helveticaneue-light" size:24];
        descriptionLabel.textColor=[UIColor blackColor];
        [self addSubview:descriptionLabel];
        
        self.unit = unit;
        self.max = max;
        self.min = min;
        self.roundingIncrement = roundingIncrement;
        
        self.currentValue = currentValue;
    }
    
    return self;
}

-(NSString *) valueString {
    float currentPercentage=(scrollView.frame.size.width - scrollView.contentOffset.x) / scrollView.frame.size.width;
    self.currentValue = currentPercentage * (self.max-self.min) + self.min;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.roundingIncrement = [NSNumber numberWithDouble:self.roundingIncrement];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;

    
    return [NSString stringWithFormat:@"%@ %@",[formatter stringFromNumber:[NSNumber numberWithFloat:self.currentValue]],self.unit];
}

-(float) value {
    return self.currentValue;
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    valueLabel.text=[self valueString];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    
    scrollView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    
    colorIndicator.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    scrollView.contentSize=CGSizeMake(2*self.frame.size.width, 10);
    
    
    descriptionLabel.frame=CGRectMake(10, 0, self.frame.size.width-20, self.frame.size.height);
    valueLabel.frame=CGRectMake(10, 0, self.frame.size.width-20, self.frame.size.height);
    
    
    float currentPercentage = (self.currentValue-self.min) / (self.max-self.min);
    scrollView.contentOffset=CGPointMake(-1*(currentPercentage*scrollView.frame.size.width)+scrollView.frame.size.width, 0);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
