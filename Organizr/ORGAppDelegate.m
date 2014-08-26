//
//  ORGAppDelegate.m
//  Organizr
//
//  Created by Yasser Al-Khder on 2014-08-25.
//  Copyright (c) 2014 Yasser Al-Khder. All rights reserved.
//

#import "ORGAppDelegate.h"

@interface ORGAppDelegate ()

@property (strong, nonatomic, readwrite) NSManagedObjectContext *context;

@end

@implementation ORGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    NSString *managedDocumentName = @"OrganizrDB";
    NSURL *managedDocumentURL = [documentsDirectory URLByAppendingPathComponent:managedDocumentName];
    UIManagedDocument *managedDocument = [[UIManagedDocument alloc] initWithFileURL:managedDocumentURL];
    if ([fileManager fileExistsAtPath:[managedDocumentURL path]]) {
        [managedDocument openWithCompletionHandler:^(BOOL success) {
            if (success) {
                [self documentIsReady:managedDocument];
            }
            else {
                NSLog(@"error opening DB");
            }
        }];
    }
    else {
        [managedDocument saveToURL:managedDocumentURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                [self documentIsReady:managedDocument];
            }
            else {
                NSLog(@"error creating DB");
            }
        }];
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

- (void)documentIsReady:(UIManagedDocument *)managedDocument
{
    if (managedDocument.documentState == UIDocumentStateNormal) {
        self.context = managedDocument.managedObjectContext;
    }
    else {
        NSLog(@"document not in normal state");
    }
}

@end
