//
//  MainViewController.m
//  EatSmart
//
//  Created by Frederik Riedel on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize table,mealSuggestions;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Eat Smart";
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Filter" style:UIBarButtonItemStyleBordered target:self  action:@selector(filter)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    
    
    table = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    table.dataSource=self;
    table.delegate=self;
    [self.view addSubview:table];
    
    [self updateMealSuggestions];
    
    // Do any additional setup after loading the view.
}

-(void) updateMealSuggestions {
    mealSuggestions = [DataBaseConnection mealSuggestions];
    [table reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mealSuggestions count];
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(MealTableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mealCell"];
    
    if(!cell) {
        cell = [[MealTableViewCell alloc] init];
    }
    [cell setMeal:[mealSuggestions objectAtIndex:indexPath.row]];
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
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
