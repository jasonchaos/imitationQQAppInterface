//
//  AppDelegate.h
//  gzittcOA
//
//  Created by JasonChao on 14-10-24.
//  Copyright (c) 2014年 JasonChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "windowDelegate.h"

@class myTabBarController;
@class mainMenu;
@class rootViewController;
@class menuBgController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,windowDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong,nonatomic) myTabBarController *rootViewController;
@property (strong,nonatomic) rootViewController *navigationController;
@property (strong,nonatomic) mainMenu *mainMenu;
@property (strong,nonatomic) menuBgController *menuBg;
@property NSDictionary* titleAndBoard;
@property NSArray *currentControllers;
@property NSMutableArray* myControllers;
@property UIStoryboard *rootStoryBoard;
@property NSString *currentPage;
@property BOOL initFlag;

@end

