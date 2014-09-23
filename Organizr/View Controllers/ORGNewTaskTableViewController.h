//
//  ORGNewTaskTableViewController.h
//  Organizr
//
//  Created by Yasser Al-Khder on 2014-08-31.
//  Copyright (c) 2014 Yasser Al-Khder. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Task;

@interface ORGNewTaskTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) Task *parent;

@end
