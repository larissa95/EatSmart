//
//  CreateNewMealViewController.h
//  EatSmart
//
//  Created by Frederik Riedel on 29.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRSlider.h"
#import "AppDelegate.h"

@import MapKit;
@import CoreLocation;

@interface CreateNewMealViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CLLocationManagerDelegate>

@property(nonatomic) UITableView *table;
@property(nonatomic) UITextField *textField;
@property(nonatomic) UITextField *locationDescription;
@property(nonatomic) UIDatePicker *datePicker;
@property(nonatomic) FRSlider *numberOfGuests;
@property(nonatomic) FRSlider *costPerGuest;
@property(nonatomic) UISegmentedControl *segmentControl;
@property(nonatomic) CLLocationManager *locManager;
@property(nonatomic) MKMapView *map;

@end
