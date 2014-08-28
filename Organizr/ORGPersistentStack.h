//
//  ORGPersistentStack.h
//  Organizr
//
//  Created by Yasser Al-Khder on 2014-08-28.
//  Copyright (c) 2014 Yasser Al-Khder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ORGPersistentStack : NSObject

@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

- (instancetype)initWithStoreURL:(NSURL *)storeURL modelURL:(NSURL *)modelURL;

@end
