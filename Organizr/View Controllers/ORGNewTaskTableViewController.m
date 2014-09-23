//
//  ORGNewTaskTableViewController.m
//  Organizr
//
//  Created by Yasser Al-Khder on 2014-08-31.
//  Copyright (c) 2014 Yasser Al-Khder. All rights reserved.
//

#import "ORGNewTaskTableViewController.h"
#import "Task.h"

@interface ORGNewTaskTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButtonItem;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *additionalNotesTextView;
@property (weak, nonatomic) IBOutlet UISwitch *addReminderSwitch;


@end

@implementation ORGNewTaskTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.doneBarButtonItem.enabled = self.titleTextField.text.length > 0;
    self.titleTextField.delegate = self;
    [self.addReminderSwitch addTarget:self action:@selector(switchToggled:) forControlEvents:UIControlEventValueChanged];
    
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

- (NSIndexPath *)remindMeOnIndexPath
{
    return [NSIndexPath indexPathForRow:1 inSection:1];
}

- (void)switchToggled:(UISwitch *)sender {
    // TODO: Show/Hide reminder cells.
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.titleTextField) {
        BOOL textFieldWillHaveText = ![string isEqualToString:@""] || textField.text.length > 1;
        self.doneBarButtonItem.enabled = textFieldWillHaveText;
    }
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [super numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int numberOfRows = [super tableView:tableView numberOfRowsInSection:section];
    if (section == 1) {
        numberOfRows--;
        if (!self.addReminderSwitch.isOn) {
            numberOfRows--;
        }
    }
    return numberOfRows;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
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
*/

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
    if ([indexPath isEqual:[self remindMeOnIndexPath]]) {
        NSLog(@"Show dial");
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"Add New Task"]) {
        [Task insertTaskWithTitle:self.titleTextField.text reminderDate:nil additionalNotes:self.additionalNotesTextView.text parent:self.parent inManagedObjectContext:self.parent.managedObjectContext];
    }
}

@end
