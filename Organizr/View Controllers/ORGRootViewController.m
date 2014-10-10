//
//  ORGRootViewController.m
//  Organizr
//
//  Created by Yasser Al-Khder on 2014-08-26.
//  Copyright (c) 2014 Yasser Al-Khder. All rights reserved.
//

#import "ORGRootViewController.h"
#import "Task.h"
#import "ORGTableViewDataSource.h"
#import "ORGTaskTableViewCell.h"
#import "ORGNewTaskTableViewCell.h"
#import "ORGNewTaskTableViewController.h"

@interface ORGRootViewController () <ORGTableViewDataSourceDelegate>

@property (strong, nonatomic) ORGTableViewDataSource *dataSource;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation ORGRootViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom Initialization.
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDataSource];
    [self setupDateFormatter];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.dataSource.paused = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.dataSource.paused = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupDataSource
{
    self.dataSource = [[ORGTableViewDataSource alloc] initWithTableView:self.tableView];
    self.dataSource.fetchedResultsController = self.parent.childrenFetchedResultsController;
    self.dataSource.cellIdentifier = @"Task Cell";
    self.dataSource.delegate = self;
    
}

- (void)setupDateFormatter
{
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateStyle = NSDateFormatterLongStyle;
    self.dateFormatter.timeStyle = NSDateFormatterShortStyle;
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    // Code when screen is popped back to controller
}

#pragma mark - Table view data source delegate
- (void)configureCell:(id)cell withObject:(id)object
{
    ORGTaskTableViewCell *taskCell = cell;
    Task *task = object;
    taskCell.titleLabel.text = task.title;
    [taskCell.titleLabel sizeToFit];
    taskCell.reminderDateLabel.text = [self.dateFormatter stringFromDate:task.reminderDate];
    [taskCell.reminderDateLabel sizeToFit];
}

- (CGFloat)heightForRowWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    Task *task = object;
    if (task.reminderDate) {
        return 60;
    }
    return [super tableView:self.tableView heightForRowAtIndexPath:indexPath];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id destinationViewController = [segue destinationViewController];
    if ([destinationViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = destinationViewController;
        id navRootViewController = [navController viewControllers].firstObject;
        if ([navRootViewController isKindOfClass:[ORGNewTaskTableViewController class]]) {
            ORGNewTaskTableViewController *newTaskTableViewController = navRootViewController;
            newTaskTableViewController.parent = self.parent;
        }
    }
}


@end
