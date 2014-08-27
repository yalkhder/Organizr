//
//  ORGRootViewController.m
//  Organizr
//
//  Created by Yasser Al-Khder on 2014-08-26.
//  Copyright (c) 2014 Yasser Al-Khder. All rights reserved.
//

#import "ORGRootViewController.h"
#import "ORGAppDelegate.h"
#import "Task.h"
#import "ORGTaskTableViewCell.h"
#import "ORGNewTaskTableViewCell.h"

@interface ORGRootViewController ()

@property (strong, nonatomic) ORGAppDelegate *appDelegate;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ORGRootViewController

static NSString *kContextKeyPath = @"context";

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
    
    self.appDelegate = [UIApplication sharedApplication].delegate;
    [self.appDelegate addObserver:self forKeyPath:kContextKeyPath options:0 context:NULL];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:kContextKeyPath]) {
        static NSString *kTaskEntityName = @"Task";
        static NSString *kReminderDateKeyPath = @"reminderDate";
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kTaskEntityName];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kReminderDateKeyPath ascending:YES];
        fetchRequest.sortDescriptors = @[sortDescriptor];
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.appDelegate.context sectionNameKeyPath:nil cacheName:nil];
        NSError *error;
        if (![self.fetchedResultsController performFetch:&error]) {
            NSLog(@"%@",[error localizedDescription]);
        }
    }
}

- (BOOL)rowAtIndexPathIsLastRow:(NSIndexPath *)indexPath
{
    return indexPath.row == [self tableView:self.tableView numberOfRowsInSection:indexPath.section] - 1;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return MAX(1, [[self.fetchedResultsController sections] count]);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
    }
    return numberOfRows + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self rowAtIndexPathIsLastRow:indexPath]) {
        static NSString *kTaskCellReuseIdentifier = @"Task Cell";
        ORGNewTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTaskCellReuseIdentifier forIndexPath:indexPath];
        Task *task = [self.fetchedResultsController objectAtIndexPath:indexPath];
        cell.textField.text = task.title;
        return cell;
    }
    else {
        static NSString *kNewTaskCellReuseIdentifier = @"New Task Cell";
        ORGNewTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNewTaskCellReuseIdentifier];
        return cell;
    }
    
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return ![self rowAtIndexPathIsLastRow:indexPath];
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"Row selected");
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"will start editing");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
