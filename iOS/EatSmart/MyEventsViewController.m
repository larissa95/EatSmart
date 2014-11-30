//
//  MyEventsViewController.m
//  EatSmart
//
//  Created by Frederik Riedel on 30.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "MyEventsViewController.h"

@interface MyEventsViewController ()

@end

@implementation MyEventsViewController
@synthesize table,myConfirmedMeals,myHostedMeals,myPendingMeals,refreshControl;
- (void)viewDidLoad {
    
    self.title=@"My Events";
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    table = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    table.dataSource=self;
    table.delegate=self;
    [self.view addSubview:table];
    [self performSelectorInBackground:@selector(loadMyEventsInbackground) withObject:nil];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [table addSubview:refreshControl];
    
    myPendingMeals = [[NSMutableArray alloc] init];
    myHostedMeals=[[NSMutableArray alloc] init];
    myConfirmedMeals=[[NSMutableArray alloc] init];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)refresh {
    [myConfirmedMeals removeAllObjects];
    [myHostedMeals removeAllObjects];
    [myPendingMeals removeAllObjects];
    [self performSelectorInBackground:@selector(loadMyEventsInbackground) withObject:nil];
}


-(void) loadMyEventsInbackground {
    NSString *url = [NSString stringWithFormat:@"%@/user/%u/information",[ServerUrl serverUrl],[LocalDataBase userId]];
    
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSData *postData = [@"" dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    if(responseData) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        
        
        NSArray *tempPendingMeals = [JSON objectForKey:@"mealUnconfirmedIds"];
        for(int i=0; i<[tempPendingMeals count]; i++) {
            [self addUnconfirmedMeals:[[tempPendingMeals objectAtIndex:i] intValue]];
        }
        
        NSArray *tempConfirmedMeals = [JSON objectForKey:@"mealGuestIds"];
        for(int i=0; i<[tempConfirmedMeals count]; i++) {
            [self addConfirmedMeals:[[tempConfirmedMeals objectAtIndex:i] intValue]];
        }
        
        NSArray *tempHostedMeals = [JSON objectForKey:@"mealHostIds"];
        for(int i=0; i<[tempHostedMeals count]; i++) {
            [self addHostedMeals:[[tempHostedMeals objectAtIndex:i] intValue]];
        }
        
        
        
        [table performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
    [refreshControl performSelectorOnMainThread:@selector(endRefreshing) withObject:nil waitUntilDone:NO];
    
    
}


-(void) addUnconfirmedMeals:(int) uuid {
    NSString *url = [NSString stringWithFormat:@"%@/meals/%u",[ServerUrl serverUrl],uuid];
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSData *postData = [@"" dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    Meal *meal = [[Meal alloc] initWithJSON:JSON];
    [myPendingMeals addObject:meal];
}


-(void) addHostedMeals:(int) uuid {
    NSString *url = [NSString stringWithFormat:@"%@/meals/%u",[ServerUrl serverUrl],uuid];
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSData *postData = [@"" dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    Meal *meal = [[Meal alloc] initWithJSON:JSON];
    [myHostedMeals addObject:meal];
}

-(void) addConfirmedMeals:(int) uuid {
    NSString *url = [NSString stringWithFormat:@"%@/meals/%u",[ServerUrl serverUrl],uuid];
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSData *postData = [@"" dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    Meal *meal = [[Meal alloc] initWithJSON:JSON];
    [myConfirmedMeals addObject:meal];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return @"my hosted events";
            break;
        }
        case 1:
        {
            return @"upcoming confirmed events";
            break;
        }
        case 2:
        {
            return @"pending events";
            break;
        }
            
            
        default:
            break;
    }
    
    return @"";
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
        {
            return [myHostedMeals count];
            break;
        }
        case 1:
        {
            return [myConfirmedMeals count];
            break;
        }
        case 2:
        {
            return [myPendingMeals count];
            break;
        }
            
            
        default:
            break;
    }
    
    return 0;
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


-(MealTableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mealCell"];
    
    if(!cell) {
        cell = [[MealTableViewCell alloc] init];
    }
    
    switch (indexPath.section) {
        case 0:
        {
            [cell setMeal:[myHostedMeals objectAtIndex:indexPath.row]];
            break;
        }
        case 1:
        {
            [cell setMeal:[myConfirmedMeals objectAtIndex:indexPath.row]];
            break;
        }
        case 2:
        {
            [cell setMeal:[myPendingMeals objectAtIndex:indexPath.row]];
            break;
        }
            
            
        default:
            break;
    }
    //[cell setMeal:[mealSuggestions objectAtIndex:indexPath.row]];
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Meal *selectedMeal;
    switch (indexPath.section) {
        case 0:
            selectedMeal = [myHostedMeals objectAtIndex:indexPath.row];
            break;
        case 1:
            selectedMeal = [myConfirmedMeals objectAtIndex:indexPath.row];
            break;
        case 2:
            selectedMeal = [myPendingMeals objectAtIndex:indexPath.row];
            break;
            
        default:
            break;
    }
    
    MealDetailViewController *mdvc = [[MealDetailViewController alloc] initWithMeal:selectedMeal];
    [self.navigationController pushViewController:mdvc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
