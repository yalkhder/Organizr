//
//  ORGAppDelegate.h
//  Organizr
//
//  Created by Yasser Al-Khder on 2014-08-25.
//  Copyright (c) 2014 Yasser Al-Khder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ORGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic, readonly) NSManagedObjectContext *context;

@end
