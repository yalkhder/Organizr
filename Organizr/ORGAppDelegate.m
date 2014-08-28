//
//  ORGAppDelegate.m
//  Organizr
//
//  Created by Yasser Al-Khder on 2014-08-25.
//  Copyright (c) 2014 Yasser Al-Khder. All rights reserved.
//

#import "ORGAppDelegate.h"
#import "ORGPersistentStack.h"
#import "ORGStore.h"
#import "ORGRootViewController.h"

@interface ORGAppDelegate ()

@property (strong, nonatomic) ORGPersistentStack *persistentStack;
@property (strong, nonatomic) ORGStore *store;

@end

@implementation ORGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    ORGRootViewController *rootViewController = (ORGRootViewController *)navigationController.topViewController;
    self.persistentStack = [[ORGPersistentStack alloc] initWithStoreURL:self.storeURL modelURL:self.modelURL];
    self.store = [[ORGStore alloc] init];
    self.store.managedObjectContext = self.persistentStack.managedObjectContext;
    rootViewController.parent = self.store.rootTask;
    return YES;
}

- (NSURL *)storeURL
{
    NSURL* documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    return [documentsDirectory URLByAppendingPathComponent:@"db.sqlite"];
}

- (NSURL *)modelURL
{
    return [[NSBundle mainBundle] URLForResource:@"Organizr" withExtension:@"momd"];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSError *error;
    if ([self.store.managedObjectContext save:NULL]) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
