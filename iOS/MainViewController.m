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
@synthesize table,mealSuggestions,toolBar,refreshControl;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.title=@"Eat Smart";
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Filter" style:UIBarButtonItemStylePlain target:self  action:@selector(filter)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"My events" style:UIBarButtonItemStylePlain target:self  action:@selector(events)];
    
    
    
    table = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    table.dataSource=self;
    table.delegate=self;
    table.contentInset=UIEdgeInsetsMake(0, 0, 40, 0);
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [table addSubview:refreshControl];
    
    [self.view addSubview:table];
    
    [self updateMealSuggestions];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    
    toolBar = [[UIToolbar alloc] init];
    toolBar.tintColor = [UIColor colorWithRed:70/255.0 green:129/255.0 blue:192/255.0 alpha:1.0];
    toolBar.items=@[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)],[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],[[UIBarButtonItem alloc] initWithTitle: @"Profile" style:UIBarButtonItemStylePlain target:self  action:@selector(profile)]];
    
    [self.view addSubview:toolBar];
    
    // Do any additional setup after loading the view.
}

- (void)refresh {
    [self performSelectorInBackground:@selector(loadNewMenuDataInBackground) withObject:nil];
    
}

-(void) loadNewMenuDataInBackground {
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://10.60.36.31:5000/0.2.1b/meals/search/48.742627/9.095000"]];
    
    if(data) {
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSArray *mealsHuelle = [JSON objectForKey:@"results"];
    
    NSMutableArray *meals = [[NSMutableArray alloc] init];
    
    for(NSDictionary *dic in mealsHuelle) {
        Meal *meal =  [[Meal alloc] initWithJSON:dic];
        [meals addObject:meal];
    }
    
    mealSuggestions = [NSArray arrayWithArray:meals];
    [table performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    [refreshControl endRefreshing];
    } else {
        Meal *meal = [[Meal alloc] initDummy];
        mealSuggestions =  @[meal,meal];
        [table performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        [refreshControl endRefreshing];
    }
}


-(void) events {
    
}

-(void) filter {
    FilterViewController *fvc = [[FilterViewController alloc] init];
    [self.navigationController pushViewController:fvc animated:YES];
}

-(void) profile {
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    [self.navigationController pushViewController:profile animated:YES];
}

-(void) add {
    CreateNewMealViewController *createMeal = [[CreateNewMealViewController alloc] init];
    createMeal.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self.navigationController presentViewController:createMeal animated:YES completion: nil];
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

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Meal *selectedMeal = [mealSuggestions objectAtIndex:indexPath.row];
    MealDetailViewController *mdvc = [[MealDetailViewController alloc] initWithMeal:selectedMeal];
    [self.navigationController pushViewController:mdvc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) viewWillLayoutSubviews {
    table.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    toolBar.frame=CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40);
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
