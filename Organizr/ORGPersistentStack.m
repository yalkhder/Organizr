//
//  ORGPersistentStack.m
//  Organizr
//
//  Created by Yasser Al-Khder on 2014-08-28.
//  Copyright (c) 2014 Yasser Al-Khder. All rights reserved.
//

#import "ORGPersistentStack.h"

@interface ORGPersistentStack ()

@property (strong, nonatomic, readwrite) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSURL *modelURL;
@property (strong, nonatomic) NSURL *storeURL;

@end

@implementation ORGPersistentStack

- (instancetype)initWithStoreURL:(NSURL *)storeURL modelURL:(NSURL *)modelURL
{
    self = [super init];
    if (self) {
        self.storeURL = storeURL;
        self.modelURL = modelURL;
        [self setupManagedObjectContext];
    }
    return self;
}

- (void)setupManagedObjectContext
{
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSError *error;
    [self.managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.storeURL options:nil error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    //TODO: Add undo manager
}

- (NSManagedObjectModel *)managedObjectModel
{
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:self.modelURL];
}

@end
