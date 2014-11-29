//
//  FRSlider.h
//  EatSmart
//
//  Created by Frederik Riedel on 29.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRSlider : UIView<UIScrollViewDelegate>

@property(nonatomic) UIScrollView *scrollView;
@property(nonatomic) UIView *colorIndicator;
@property(nonatomic) UIImageView *dragSeparator;
@property(nonatomic) UILabel *descriptionLabel;
@property(nonatomic) UILabel *valueLabel;

@property(nonatomic) NSString *unit;

@property(nonatomic) int min;
@property(nonatomic) int max;
@property(nonatomic) float currentValue;
@property(nonatomic) double roundingIncrement;



-(id) initWithName:(NSString *) name Unit:(NSString *) unit min:(float) min max:(float) max currentValue:(float) currentValue nachKommaStellen:(double) roundingIncrement;

@end
