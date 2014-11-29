//
//  FilterViewController.m
//  EatSmart
//
//  Created by Frederik Riedel on 29.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@end

@implementation FilterViewController
@synthesize table,datePicker;
bool dateCellExtended;
- (void)viewDidLoad {
    dateCellExtended=false;
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    
    
    datePicker = [[UIDatePicker alloc] init];
    [datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    
    
    // Do any additional setup after loading the view.
}

-(void) dateChanged {
    [table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 2;
            break;
            
        default:
            return 0;
            break;
    }
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.clipsToBounds=YES;
    
    switch (indexPath.section) {
        case 2: {
            if(indexPath.row==0) {
                FRSlider *slider = [[FRSlider alloc] initWithName:@"max. price" Unit:@"€" min:0 max:10 currentValue:2.30 nachKommaStellen:0.01];
                slider.frame=CGRectMake(0, 0, self.view.frame.size.width, [self tableView:table heightForRowAtIndexPath:indexPath]);
                [cell addSubview:slider];
                break;
            }
            
            if(indexPath.row==1) {
                FRSlider *slider = [[FRSlider alloc] initWithName:@"max. walking time" Unit:@"min" min:0 max:20 currentValue:5 nachKommaStellen:1.0];
                slider.frame=CGRectMake(0, 0, self.view.frame.size.width, [self tableView:table heightForRowAtIndexPath:indexPath]);
                [cell addSubview:slider];
                break;
            }
        }
        case 0: {
            //cell.textLabel.text=[NSString stringWithFormat:@"%@",datePicker.date.description];
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
            
        case 1: {
            UILabel *desctiptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, 50)];
            desctiptionLabel.font=[UIFont fontWithName:@"Helveticaneue-light" size:20];
            desctiptionLabel.text=@"Lowest host rating";
            [cell addSubview:desctiptionLabel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            AMRatingControl *starView = [[AMRatingControl alloc]initWithLocation:CGPointMake(self.view.frame.size.width-155, 7) emptyColor:[UIColor colorWithRed:70/255.0 green:129/255.0 blue:192/255.0 alpha:1.0] solidColor:[UIColor colorWithRed:70/255.0 green:129/255.0 blue:192/255.0 alpha:1.0] andMaxRating:5];
            
            [cell addSubview:starView];
            
            break;
        }

            
        default:
            break;
    }
    
    
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==0 && indexPath.section==0) {
        if(dateCellExtended) {
            return 50+datePicker.frame.size.height;
        }
    }
    return 50;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section==0 && indexPath.section==0) {
        dateCellExtended=!dateCellExtended;
        [table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(void) viewWillLayoutSubviews {
    table.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    datePicker.frame=CGRectMake(0, 50, self.view.frame.size.width, datePicker.frame.size.height);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
