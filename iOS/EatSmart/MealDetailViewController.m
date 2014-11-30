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
@synthesize mealView,mealHeadView,table,segmentControl,host,reviews,pendingUsers,confirmedUsers;


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
        
        
        if(meal.thisUserIsHost) {
            segmentControl =[[UISegmentedControl alloc] initWithItems:@[@"Event",@"Confirmed Guests",@"Pending Guests"]];
        } else {
            segmentControl =[[UISegmentedControl alloc] initWithItems:@[@"Event",@"Host",@"Reviews"]];
        }
        
        
        segmentControl.tintColor=[UIColor colorWithRed:70/255.0 green:129/255.0 blue:192/255.0 alpha:1.0];
        segmentControl.selectedSegmentIndex=0;
        
        [segmentControl addTarget:self
                           action:@selector(segmentChanged)
                 forControlEvents:UIControlEventValueChanged];
        
        [self.view addSubview:segmentControl];
        self.meal=meal;
        
        [self performSelectorInBackground:@selector(loadAdditionalDataInbackground) withObject:nil];
        
        reviews=[[NSMutableArray alloc] init];
        
        pendingUsers = [[NSMutableArray alloc] init];
        confirmedUsers=[[NSMutableArray alloc] init];
        
        
    }
    return self;
}


-(User *) userForID:(int) uuid {
    NSString *url = [NSString stringWithFormat:@"%@/user/%u/information",[ServerUrl serverUrl],uuid];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSData *postData = [@"" dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    

    
    User *user = [[User alloc] initWithJSON:JSON];
    return user;
}


-(void) loadAdditionalDataInbackground {
    [pendingUsers performSelectorOnMainThread:@selector(removeAllObjects) withObject:nil waitUntilDone:YES];
    [confirmedUsers performSelectorOnMainThread:@selector(removeAllObjects) withObject:nil waitUntilDone:YES];
    
    if(self.meal.thisUserIsHost) {
        for(int i=0; i<[self.meal.pendingUserIDs count]; i++) {
            User *user = [self userForID:[[self.meal.pendingUserIDs objectAtIndex:i] intValue]];
            [pendingUsers addObject:user];
        }
        
        for(int i=0; i<[self.meal.confirmedUserIDs count]; i++) {
            User *user = [self userForID:[[self.meal.confirmedUserIDs objectAtIndex:i] intValue]];
            [confirmedUsers addObject:user];
        }
        
        [table performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        
    } else {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/meals/%ld",[ServerUrl serverUrl],(long)self.meal.uuid]]];
        if(data) {
            
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSDictionary *hostHuelle = [JSON objectForKey:@"host"];
            
            host = [[User alloc] initWithJSON:hostHuelle];
            if(host.uuid==[LocalDataBase userId]) {
                NSLog(@"eigenes Event");
            }
            
            NSArray *reviewHuelle = [JSON objectForKey:@"reviews"];
            
            for(NSString *reviewString in reviewHuelle) {
                Review *review = [[Review alloc] init];
                review.reviewText=reviewString;
                review.authorname=@"Larissa";
                [reviews addObject:review];
            }
            
            [table performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        }
    }
    
    
    //http://10.60.36.31:5000/0.2.1b/meals/1
}

-(void) segmentChanged {
   /* if([table numberOfSections]>0) {
        [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }*/
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
    
    if(self.meal.thisUserIsHost) {
        if(segmentControl.selectedSegmentIndex==1) {
            return [confirmedUsers count];
        }
        if(segmentControl.selectedSegmentIndex==2) {
            return [pendingUsers count];
        }
    }
    
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
    if(self.meal.thisUserIsHost) {
        return 1;
    }
    
    if(segmentControl.selectedSegmentIndex==0 || segmentControl.selectedSegmentIndex==1) {
        return 1;
    }
    return [reviews count]+4;
}



-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if((self.meal.thisUserIsHost && segmentControl.selectedSegmentIndex==1) || (self.meal.thisUserIsHost && segmentControl.selectedSegmentIndex==2)) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"usercell"];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"usercell"];
        }
        

        if(segmentControl.selectedSegmentIndex==1) {
            cell.textLabel.text = ((User *)[confirmedUsers objectAtIndex:indexPath.row]).name;
            cell.detailTextLabel.text=@"";
        } else {
            cell.textLabel.text = ((User *)[pendingUsers objectAtIndex:indexPath.row]).name;
            cell.detailTextLabel.text=@"click to confirm";
        }
        
        return cell;
        
    } else {
        
        
        if(segmentControl.selectedSegmentIndex == 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reviewcell"];
            if(!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reviewcell"];
            }
            
            if(indexPath.section<4) {
                
                if(indexPath.section==0) {
                    cell.textLabel.text=@"★★★★☆";
                    cell.detailTextLabel.text=@"Mood";
                }

                if(indexPath.section==1) {
                    cell.textLabel.text=@"★★★★★";
                    cell.detailTextLabel.text=@"Quality";
                }
                if(indexPath.section==2) {
                    cell.textLabel.text=@"★★★★☆";
                    cell.detailTextLabel.text=@"Quantity";
                }
                if(indexPath.section==3) {
                    cell.textLabel.text=@"★★★☆☆";
                    cell.detailTextLabel.text=@"Timeliness";
                }
  
                
            } else {
            
            cell.textLabel.text=((Review *)[reviews objectAtIndex:((int)indexPath.section)-4]).reviewText;
            cell.textLabel.numberOfLines=-1;
            }
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
                        cell.descriptionLabel.text=host.name;
                        break;
                    }
                    case 1: {
                        cell.titleLabel.text=@"age";
                        cell.descriptionLabel.text=[NSString stringWithFormat:@"%ld",(long)host.age];
                        break;
                    }
                    case 2: {
                        cell.titleLabel.text=@"gender";
                        cell.descriptionLabel.text=host.gender;
                        break;
                    }
                    case 3: {
                        cell.titleLabel.text=@"registered for";
                        
                        NSTimeInterval daysbetween = [[[NSDate alloc] init] timeIntervalSinceDate:host.registerdsince] / 86400;
                        
                        cell.descriptionLabel.text=[NSString stringWithFormat:@"%.0f days",daysbetween];
                        break;
                    }
                        
                }
            }
            return cell;
        }
    }
    return nil;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (segmentControl.selectedSegmentIndex==2 && !self.meal.thisUserIsHost) {
        return @"";
    }
    return @"";
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.meal.thisUserIsHost) {
        return 60;
    }
    
    if(segmentControl.selectedSegmentIndex==2) {
        if(indexPath.section<4) {
            return 60;
        }
        NSString *str =((Review *)[reviews objectAtIndex:indexPath.section-4]).reviewText;
        CGSize size = [str sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:19] constrainedToSize:CGSizeMake(self.view.frame.size.width, 10000) lineBreakMode:UILineBreakModeWordWrap];
        
        return size.height + 10;
    }
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (segmentControl.selectedSegmentIndex==0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
        
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate=self.meal.gpsLocation;
        
        MKMapView *map =[[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
        [map addAnnotation:annotation];
        
        [view addSubview:map];
        map.userInteractionEnabled=NO;
        map.region = MKCoordinateRegionMake(self.meal.gpsLocation, MKCoordinateSpanMake(0.004, 0.006));
        
        
        
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
    
    
    if((self.meal.thisUserIsHost && segmentControl.selectedSegmentIndex==2)) {
        
        [self performSelectorInBackground:@selector(confirmPendingInbackground:) withObject:[NSNumber numberWithInt:(int)((User *)[pendingUsers objectAtIndex:indexPath.row]).uuid]];
    }
}

-(void) confirmPendingInbackground:(NSNumber *) userId {
    NSString *url = [NSString stringWithFormat:@"%@/meals/%ld/user/%u",[ServerUrl serverUrl],(long)self.meal.uuid,[userId intValue]];

    NSLog(url);
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"PUT"];

    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData *postData = [@"" dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    [self loadAdditionalDataInbackground];
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
