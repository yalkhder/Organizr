//
//  ORGRootViewController.h
//  Organizr
//
//  Created by Yasser Al-Khder on 2014-08-26.
//  Copyright (c) 2014 Yasser Al-Khder. All rights reserved.
//

@class Task;

#import <UIKit/UIKit.h>

@interface ORGRootViewController : UITableViewController

@property (strong, nonatomic) Task *parent;

@end
