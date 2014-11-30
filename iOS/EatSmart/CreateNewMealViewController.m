//
//  CreateNewMealViewController.m
//  EatSmart
//
//  Created by Frederik Riedel on 29.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "CreateNewMealViewController.h"

@interface CreateNewMealViewController ()

@end

@implementation CreateNewMealViewController
@synthesize table,textField,datePicker,numberOfGuests,costPerGuest,segmentControl,locManager,map;
bool dateCellExtended;
- (void)viewDidLoad {
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    navBar.barTintColor = [UIColor colorWithRed:70/255.0 green:129/255.0 blue:192/255.0 alpha:1.0];
    navBar.translucent=NO;
    [self.view addSubview:navBar];
    
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    UINavigationItem *title = [[UINavigationItem alloc] initWithTitle:@"create new event"];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    [super viewDidLoad];
    
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle: @"Cancel" style:UIBarButtonItemStylePlain target:self  action:@selector(cancel)];
    
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle: @"Create" style:UIBarButtonItemStylePlain target:self  action:@selector(create)];
    
    title.rightBarButtonItem=right;
    title.leftBarButtonItem=left;
    
    navBar.items=@[title];
    
    navBar.barStyle = UIBarStyleBlackTranslucent;
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    
    textField = [[UITextField alloc] init];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    textField.placeholder=@"What do you cook?";
    textField.delegate=self;
    
    
    datePicker = [[UIDatePicker alloc] init];
    [datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    
    numberOfGuests = [[FRSlider alloc] initWithName:@"max number of guests" Unit:@"" min:1 max:15 currentValue:3 nachKommaStellen:1.0];
    
    
    costPerGuest = [[FRSlider alloc] initWithName:@"cost per guest" Unit:@"€" min:0 max:15 currentValue:3 nachKommaStellen:0.01];
    segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"eating event", @"cooking event"]];
    segmentControl.selectedSegmentIndex=0;
    segmentControl.tintColor=[UIColor colorWithRed:70/255.0 green:129/255.0 blue:192/255.0 alpha:1.0];
    
    [CLLocationManager locationServicesEnabled];
    locManager = [[CLLocationManager alloc] init];
    [locManager requestAlwaysAuthorization];
    locManager.delegate=self;
    locManager.distanceFilter = 40;
    locManager.desiredAccuracy = kCLLocationAccuracyBest;
    locManager.delegate = self;
    [locManager startUpdatingLocation];

    map =[[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    map.showsUserLocation=YES;
    // Do any additional setup after loading the view.
}



-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    map.region = MKCoordinateRegionMake(newLocation.coordinate, MKCoordinateSpanMake(0.002, 0.003));
}


-(void) cancel {
    [self dismissModalViewControllerAnimated:YES];
}

-(void) create {
    NSString *url = [NSString stringWithFormat:@"http://%@/meals/create",[AppDelegate IP]];
    
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

    
    NSString *post = [NSString stringWithFormat:@"name=%@&dateRegistrationEnd=%@&date=%@&price=%f&host=%u&address=%@&typ=%@&maxGuests=%u&nutrition_typ=%@&description=%@&longitude=%f&latitude=%f",@"Pfannkuchen",@"2014-11-30 12:59:12",@"2014-12-30 12:59:12",3.20,2,@"DingsBumsHausen",@"eating",5,@"vegan",@"Toller Abend!",locManager.location.coordinate.longitude,locManager.location.coordinate.latitude];
    
    NSLog(post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];

    [self dismissModalViewControllerAnimated:YES];
}

-(void) dateChanged {
    [table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textFielda
{
    [textField resignFirstResponder];
    return YES;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    switch (indexPath.row) {
        case 0: {
            [cell addSubview:textField];
            break;
        }
        case 1: {
            UILabel *desctiptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, 50)];
            desctiptionLabel.font=[UIFont fontWithName:@"Helveticaneue-light" size:20];
            desctiptionLabel.text=@"Select start time";
            [cell addSubview:desctiptionLabel];
            
            UILabel *currentDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, 50)];
            
            
            NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
            [fmt setDateFormat:@"HH:mm a, dd.MM."];
            NSString* dateStr = [fmt stringFromDate:datePicker.date];
            currentDateLabel.text=dateStr;
            currentDateLabel.font=[UIFont fontWithName:@"Helveticaneue-light" size:20];
            currentDateLabel.textAlignment=NSTextAlignmentRight;
            
            if(dateCellExtended) {
                currentDateLabel.textColor=[UIColor blueColor];
            }
            [cell addSubview:currentDateLabel];
            
            [cell addSubview:datePicker];
            break;
        }
        case 2: {
            [cell addSubview:segmentControl];
            
            break;
        }
        case 3: {
            [cell addSubview:numberOfGuests];
            
            break;
        }
        case 4: {
            [cell addSubview:costPerGuest];
            break;
        }
        case 5: {
            

            [cell addSubview:map];
            break;
        }
        case 6: {
            
            break;
        }
            
            
        default:
            break;
    }
    cell.clipsToBounds=YES;
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==1) {
        if(dateCellExtended) {
            return 50+datePicker.frame.size.height;
        }
    } else if(indexPath.row==5) {
        return 300;
    }
    return 50;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row==1) {
        
        dateCellExtended=!dateCellExtended;
        [table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void) viewWillLayoutSubviews {
    table.frame=CGRectMake(0, 66, self.view.frame.size.width, self.view.frame.size.height-66);
    textField.frame=CGRectMake(5, 15, self.view.frame.size.width-10, 30);
    costPerGuest.frame=CGRectMake(0, 5, self.view.frame.size.width, 50-5);
    numberOfGuests.frame=CGRectMake(0, 0, self.view.frame.size.width, 50-5);
    datePicker.frame=CGRectMake(0, 50, self.view.frame.size.width, datePicker.frame.size.height);
    segmentControl.frame=CGRectMake(10, 10, self.view.frame.size.width-20, 30);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
