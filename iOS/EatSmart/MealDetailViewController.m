//
//  MealDetailViewController.m
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "MealDetailViewController.h"

@interface MealDetailViewController ()

@end

@implementation MealDetailViewController
@synthesize mealView,mealHeadView,table,segmentControl;


-(id) initWithMeal:(Meal *) meal {
    self = [super initWithNibName:nil bundle:nil];
    if(self) {
        self.view.backgroundColor=[UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
        
        
        mealHeadView = [[MealHeadView alloc] initWithMeal:meal andNavigationController:self.navigationController];
        [self.view addSubview:mealHeadView];
        
        table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        table.delegate=self;
        table.dataSource=self;
        [self.view addSubview:table];
        
        segmentControl =[[UISegmentedControl alloc] initWithItems:@[@"Event",@"Host",@"Reviews"]];
        segmentControl.tintColor=[UIColor colorWithRed:70/255.0 green:129/255.0 blue:192/255.0 alpha:1.0];
        segmentControl.selectedSegmentIndex=0;
        
        [segmentControl addTarget:self
                           action:@selector(segmentChanged)
                 forControlEvents:UIControlEventValueChanged];
        
        [self.view addSubview:segmentControl];
        self.meal=meal;
    }
    return self;
}

-(void) segmentChanged {
    [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [table reloadData];
}

-(void) share {
    
    NSArray *itemsToShare = @[@"check out this meal: cookrify.com/4t4893z4t"];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll]; //or whichever you don't need
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewWillLayoutSubviews {
    mealView.frame=self.view.frame;
    mealHeadView.frame=CGRectMake(0, 0, self.view.frame.size.width, 120);
    
    
    segmentControl.frame=CGRectMake(10, mealHeadView.frame.origin.y+mealHeadView.frame.size.height+10, self.view.frame.size.width-20, 30);
    
    table.frame=CGRectMake(0, segmentControl.frame.origin.y+segmentControl.frame.size.height+10, self.view.frame.size.width, self.view.frame.size.height-(segmentControl.frame.origin.y+segmentControl.frame.size.height+10));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(segmentControl.selectedSegmentIndex == 0) {
        return 3;
    }
    if(segmentControl.selectedSegmentIndex == 1) {
        return 4;
    }
    if(segmentControl.selectedSegmentIndex == 2) {
        return 1;
    }
    return 0;
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    if(segmentControl.selectedSegmentIndex==0 || segmentControl.selectedSegmentIndex==1) {
        return 1;
    }
    return 100;
}




-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(segmentControl.selectedSegmentIndex == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reviewcell"];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reviewcell"];
        }
        
        cell.textLabel.text=@"Das Essen hat sehr gut geschmeckt, allerdings fand ich es doof, dass eine Ratte mit knallroten Augen unter dem Kühlschrank war. Das Essen hat sehr gut geschmeckt, allerdings fand ich es doof, dass eine Ratte mit knallroten Augen unter dem Kühlschrank war. Das Essen hat sehr gut geschmeckt, allerdings fand ich es doof, dass eine Ratte mit knallroten Augen unter dem Kühlschrank war. Das Essen hat sehr gut geschmeckt, allerdings fand ich es doof, dass eine Ratte mit knallroten Augen unter dem Kühlschrank war.";
        cell.textLabel.numberOfLines=-1;
        return cell;
        
    } else {
        
        MealDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mealdetailinformation"];
        
        if(!cell) {
            cell = [[MealDetailTableViewCell alloc] init];
        }
        
        if(segmentControl.selectedSegmentIndex==0) {
            switch (indexPath.row) {
                case 0: {
                    cell.titleLabel.text=@"date and time";
                    
                    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
                    [fmt setDateFormat:@"dd.MM.YYYY, HH:mm a"];
                    NSString* dateStr = [fmt stringFromDate:self.meal.timeStamp];
                    cell.descriptionLabel.text=dateStr;
                    break;
                }
                case 1: {
                    cell.titleLabel.text=@"signed up guests";
                    cell.descriptionLabel.text=[NSString stringWithFormat:@"%@ of %@",self.meal.numberOfCurrentPersons,self.meal.numberOfMaxPersons];
                    break;
                }
                case 2: {
                    cell.titleLabel.text=@"location";
                    cell.descriptionLabel.text=self.meal.locationDescription;
                    break;
                }
                    
                    
                default:
                    break;
            }
        }
        
        if(segmentControl.selectedSegmentIndex == 1) {
            switch (indexPath.row) {
                case 0: {
                    cell.titleLabel.text=@"name";
                    cell.descriptionLabel.text=@"TBD";
                    break;
                }
                case 1: {
                    cell.titleLabel.text=@"age";
                    cell.descriptionLabel.text=@"TBD";
                    break;
                }
                case 2: {
                    cell.titleLabel.text=@"gender";
                    cell.descriptionLabel.text=@"TBD";
                    break;
                }
                case 3: {
                    cell.titleLabel.text=@"registered for";
                    cell.descriptionLabel.text=@"TBD";
                    break;
                }
                    
            }
        }
         return cell;
    }
    return nil;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (segmentControl.selectedSegmentIndex==2) {
        return @"Larissa Laich";
    }
     return @"";
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(segmentControl.selectedSegmentIndex==2) {
        NSString *str = @"Das Essen hat sehr gut geschmeckt, allerdings fand ich es doof, dass eine Ratte mit knallroten Augen unter dem Kühlschrank war. Das Essen hat sehr gut geschmeckt, allerdings fand ich es doof, dass eine Ratte mit knallroten Augen unter dem Kühlschrank war. Das Essen hat sehr gut geschmeckt, allerdings fand ich es doof, dass eine Ratte mit knallroten Augen unter dem Kühlschrank war. Das Essen hat sehr gut geschmeckt, allerdings fand ich es doof, dass eine Ratte mit knallroten Augen unter dem Kühlschrank war.";
        CGSize size = [str sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:19] constrainedToSize:CGSizeMake(self.view.frame.size.width, 10000) lineBreakMode:UILineBreakModeWordWrap];

        return size.height + 10;
    }
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (segmentControl.selectedSegmentIndex==0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
        
        MKMapView *map =[[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate=self.meal.gpsLocation;
        [map addAnnotation:annotation];
        
        [view addSubview:map];
        map.userInteractionEnabled=NO;
        map.centerCoordinate=self.meal.gpsLocation;
        
        return view;
    }
    return nil;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(segmentControl.selectedSegmentIndex==0) {
        return 300;
    }
    return 0;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
