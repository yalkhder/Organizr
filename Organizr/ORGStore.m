//
//  ORGStore.m
//  Organizr
//
//  Created by Yasser Al-Khder on 2014-08-28.
//  Copyright (c) 2014 Yasser Al-Khder. All rights reserved.
//

#import "ORGStore.h"
#import "Task.h"

@implementation ORGStore

- (Task *)rootTask
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"parent = %@", nil];
    NSError *error;
    NSArray *tasks = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    Task *rootTask = [tasks lastObject];
    if (rootTask == nil) {
        rootTask = [Task insertTaskWithTitle:nil reminderDate:nil additionalNotes:nil parent:nil inManagedObjectContext:self.managedObjectContext];
    }
    return rootTask;
}

@end
