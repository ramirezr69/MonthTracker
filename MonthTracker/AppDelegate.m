//
//  AppDelegate.m
//  MonthTracker
//
//  Created by Group7 on 11/17/15.
//
//

#import "AppDelegate.h"
#import "ItemsViewController.h"
#import "MonthStore.h"

NSString * const NextIncomeSourcePrefsKey  = @"NextNextIncomeSource";
NSString * const NextIncomeAmountPrefsKey  = @"NextIncomeAmount";
NSString * const NextIncomeDatePrefsKey    = @"NextIncomeDate";
NSString * const NextExpenseTypePrefsKey   = @"NextExpenseType";
NSString * const NextExpenseAmountPrefsKey = @"NextExpenseAmount";
NSString * const NextExpenseDatePrefsKey   = @"NextExpenseDate";

@interface AppDelegate ()

@end

@implementation AppDelegate

// Setting
+ (void)initialize
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *factorySettings = @{
                                        NextIncomeSourcePrefsKey: @"Job One",
                                        NextIncomeAmountPrefsKey: @"2500",
                                          NextIncomeDatePrefsKey: @"Tue, 24 December 2015 12:53:58 +0000",
                                         NextExpenseTypePrefsKey: @"Food",
                                       NextExpenseAmountPrefsKey: @"45",
                                         NextExpenseDatePrefsKey: @"Tue, 24 December 2015 12:53:58 +0000"};
                                      
    [defaults registerDefaults:factorySettings];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Creating an instance of IncomeExpensiveViewControler
    //IncomeExpensiveViewController *ievc = [[IncomeExpensiveViewController alloc] init];
    //MonthPickerViewController *ievc = [[MonthPickerViewController alloc] init];
    
    ItemsViewController *ivc = [[ItemsViewController alloc]init];
    
    // Creating instance of UINavigationController
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:ivc];
    
    // Setting UINavigationController as the root view controller of the window
    self.window.rootViewController = navController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    BOOL success = [[MonthStore sharedStore] saveChanges];
    if (success) {
        NSLog(@"Saved all of the months");
    } else {
        NSLog(@"Could not save any of the months");
    }

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

@end
