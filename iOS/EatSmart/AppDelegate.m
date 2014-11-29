//
//  AppDelegate.m
//  EatSmart
//
//  Created by Larissa Laich on 28.11.14.
//  Copyright (c) 2014 Larissa Laich. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    
    
    MainViewController *firstView = [[MainViewController alloc] init];
    
    UINavigationController *navigationController= [[UINavigationController alloc] initWithRootViewController:firstView];
    navigationController.navigationBar.barTintColor = [UIColor colorWithRed:70/255.0 green:129/255.0 blue:192/255.0 alpha:1.0];
    [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    
    navigationController.navigationBar.translucent=NO;
    
    self.window.rootViewController = navigationController;

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(test)
     name:@"grr"
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"grr"
     object:self];
    
    // Override point for customization after application launch.
    return YES;
}

-(void) test {
    NSLog(@"TEST");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+(NSString *) IP {
    return @"10.60.36.31:5000/0.2.1b";
}

@end
