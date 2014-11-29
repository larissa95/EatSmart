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
@synthesize table;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    
    
    
    // Do any additional setup after loading the view.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%ld,%ld",(long)indexPath.section,(long)indexPath.row]];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%ld,%ld",(long)indexPath.section,(long)indexPath.row]];
    }
    cell.clipsToBounds=YES;
    
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                    FRSlider *slider = [[FRSlider alloc] initWithName:@"Price" Unit:@"EUR" min:0 max:10 currentValue:2.30 nachKommaStellen:0.01];
                    slider.frame=CGRectMake(0, 0, self.view.frame.size.width, [self tableView:table heightForRowAtIndexPath:indexPath]);
                    [cell addSubview:slider];
                }
                    
                case 1: {
                    FRSlider *slider = [[FRSlider alloc] initWithName:@"Walking time" Unit:@"min" min:0 max:20 currentValue:5 nachKommaStellen:0.0];
                    slider.frame=CGRectMake(0, 0, self.view.frame.size.width, [self tableView:table heightForRowAtIndexPath:indexPath]);
                    [cell addSubview:slider];
                }
                    
                    
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
            
        default:
            break;
    }


    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) viewWillLayoutSubviews {
    table.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
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
