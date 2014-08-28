//
//  ORGStore.h
//  Organizr
//
//  Created by Yasser Al-Khder on 2014-08-28.
//  Copyright (c) 2014 Yasser Al-Khder. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Task;

@interface ORGStore : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (Task *)rootTask;

@end
