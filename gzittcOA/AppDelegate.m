//
//  AppDelegate.m
//  gzittcOA
//
//  Created by JasonChao on 14-10-24.
//  Copyright (c) 2014年 JasonChao. All rights reserved.
//

#import "AppDelegate.h"
#import "myTabBarController.h"
#import "mainMenu.h"
#import "rootViewController.h"
#import "menuBgController.h"

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor colorWithRed:13/255.0 green:6/255.0 blue:1/255.0 alpha:1];
    self.mainMenu = [[mainMenu alloc] initWithNibName:@"mainMenu" bundle:NULL];
    [self.window addSubview:self.mainMenu.view];
    [self.window sendSubviewToBack:self.mainMenu.view];
    self.menuBg = [[menuBgController alloc] initWithImage:[UIImage imageNamed:@"menuBg"]];
    [self.window addSubview:self.menuBg];
    [self.window sendSubviewToBack:self.menuBg];
    
    self.titleAndBoard = @{@"内部邮件":@"mailStoryBoard",@"通知公告":@"noticeStoryBoard"};
    
    self.currentPage = @"通知公告";
    self.initFlag = NO;
    [self openNewPage:self.currentPage];
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController = [[rootViewController alloc] initWithRootViewController:self.rootViewController];
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    [self.window addSubview:self.navigationController.view];
    [self.window makeKeyAndVisible];
    
    self.navigationController.mainMenuDelegate = self.mainMenu;
    self.navigationController.menuBgDelegate = self.menuBg;
    self.mainMenu.rootViewDelegate = self.navigationController;
    self.mainMenu.windowDelegate = self;
    self.rootViewController.rootViewDelegate = self.navigationController;
    self.navigationController.avatarBtnDelegate = self.rootViewController;

    return YES;
}

-(void)openNewPage:(NSString*)pageTitle{
    if ([self getStoryBoardName:pageTitle] != nil) {
        if (![pageTitle isEqualToString:self.currentPage] || self.initFlag == NO) {
            self.rootStoryBoard = [UIStoryboard storyboardWithName:[self getStoryBoardName:pageTitle] bundle:[NSBundle mainBundle]];
            self.rootViewController = [self.rootStoryBoard instantiateInitialViewController];
            //[self.rootStoryBoard instantiateViewControllerWithIdentifier:@""];
            self.rootViewController.title = pageTitle;
            self.currentControllers = self.navigationController.viewControllers;
            self.myControllers = [NSMutableArray arrayWithArray:self.currentControllers];
            [self.myControllers removeAllObjects];
            [self.navigationController setViewControllers:self.myControllers animated:NO];
            [self.navigationController pushViewController:self.rootViewController animated:NO];
            self.rootViewController.rootViewDelegate = self.navigationController;
            self.navigationController.avatarBtnDelegate = self.rootViewController;
            self.initFlag = YES;
            self.currentPage = pageTitle;
        }
    }else{
        NSLog(@"未找到\"%@\"对应的storyBoard",pageTitle);
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"很抱歉" message:@"此功能尚未正式上线" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

-(NSString*)getStoryBoardName:(NSString*)titleName{
    return self.titleAndBoard[titleName];
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "edu.gzittc.gzittcOA" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"gzittcOA" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"gzittcOA.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
