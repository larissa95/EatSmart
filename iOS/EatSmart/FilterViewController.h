//
//  FilterViewController.h
//  EatSmart
//
//  Created by Frederik Riedel on 29.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRSlider.h"
#import "AMRatingControl.h"

@interface FilterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic) UITableView *table;
@property(nonatomic) UIDatePicker *datePicker;

@end
