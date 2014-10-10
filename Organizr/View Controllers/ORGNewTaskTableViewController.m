//
//  ORGNewTaskTableViewController.m
//  Organizr
//
//  Created by Yasser Al-Khder on 2014-08-31.
//  Copyright (c) 2014 Yasser Al-Khder. All rights reserved.
//

#import "ORGNewTaskTableViewController.h"
#import "Task.h"
#import "ORGReminderSwitchTableViewCell.h"
#import "ORGTitleTableViewCell.h"
#import "ORGDatePickerTableViewCell.h"
#import "ORGAdditionalNotesTableViewCell.h"

@interface ORGNewTaskTableViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButtonItem;
@property (weak, nonatomic) UISwitch *reminderSwitch;
@property (weak, nonatomic) UIDatePicker *reminderDatePicker;
@property (weak, nonatomic) UILabel *reminderDateLabel;
@property (weak, nonatomic) UITextField *titleTextField;
@property (weak, nonatomic) UITextView *additionalNotesTextView;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (weak, nonatomic) UIView *firstResponder;

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
    
//    self.doneBarButtonItem.enabled = self.titleTextField.text.length > 0;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    [self setupDateFormatter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupDateFormatter
{
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateStyle = NSDateFormatterShortStyle;
    self.dateFormatter.timeStyle = NSDateFormatterShortStyle;
}

- (void)scheduleNotificationForTask:(Task *)task
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    if (!localNotification || !task.reminderDate) {
        return;
    }
    localNotification.fireDate = task.reminderDate;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = task.title;
    localNotification.alertAction = @"view";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber++;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)switchToggled:(UISwitch *)sender
{
    NSIndexPath *dateTitleIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *datePickerIndexPath = [NSIndexPath indexPathForRow:2 inSection:1];
    if (sender.isOn) {
        [self.tableView insertRowsAtIndexPaths:@[dateTitleIndexPath, datePickerIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else {
        //TODO:Make it look prettier
        [self.tableView deleteRowsAtIndexPaths:@[dateTitleIndexPath, datePickerIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.reminderDatePicker setDate:[NSDate date] animated:NO];
    }
}

- (void)datePickerValueChanged:(UIDatePicker *)sender
{
    self.reminderDateLabel.text = [self.dateFormatter stringFromDate:sender.date];
}

#pragma mark - Text field delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.firstResponder = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.firstResponder = nil;
}

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

#pragma mark - Text view delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.firstResponder = textView;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.firstResponder = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1 && self.reminderSwitch.isOn) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: {
            ORGTitleTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"Title Cell" forIndexPath:indexPath];
            titleCell.titleTextField.delegate = self;
            self.titleTextField = titleCell.titleTextField;
            self.doneBarButtonItem.enabled = self.titleTextField.text.length > 0;
            return titleCell;
        }
        case 1: {
            switch (indexPath.row) {
                case 0: {
                    ORGReminderSwitchTableViewCell *switchCell = [tableView dequeueReusableCellWithIdentifier:@"Reminder Switch Cell" forIndexPath:indexPath];
                    self.reminderSwitch = switchCell.addReminderSwitch;
                    [switchCell.addReminderSwitch addTarget:self action:@selector(switchToggled:) forControlEvents:UIControlEventValueChanged];
                     return switchCell;
                }
                case 1: {
                    UITableViewCell *reminderDetailCell = [tableView dequeueReusableCellWithIdentifier:@"Reminder Date Cell" forIndexPath:indexPath];
                    self.reminderDateLabel = reminderDetailCell.detailTextLabel;
                    return reminderDetailCell;
                }
                case 2: {
                    ORGDatePickerTableViewCell *datePickerCell = [tableView dequeueReusableCellWithIdentifier:@"Reminder Date Picker Cell" forIndexPath:indexPath];
                    self.reminderDatePicker = datePickerCell.reminderDatePicker;
                    [self.reminderDatePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
                    self.reminderDateLabel.text = [self.dateFormatter stringFromDate:self.reminderDatePicker.date];
                    return datePickerCell;
                }
                default:
                    return nil;
            }
        }
        case 2: {
            ORGAdditionalNotesTableViewCell *additionalNotesCell = [tableView dequeueReusableCellWithIdentifier:@"Additional Notes Cell" forIndexPath:indexPath];
            self.additionalNotesTextView = additionalNotesCell.notesTextView;
            self.additionalNotesTextView.delegate = self;
            return additionalNotesCell;
        }
        default:
            return nil;
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO: Make those not hardcoded
    if (indexPath.section == 1 && indexPath.row == 2) {
        return 162;
    }
    if (indexPath.section == 2) {
        return 150;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

#pragma mark - Scroll view delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.firstResponder resignFirstResponder];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"Add New Task"]) {
        NSDate *reminderDate;
        if (self.reminderSwitch.isOn) {
            reminderDate = self.reminderDatePicker.date;
        }
        Task *task = [Task insertTaskWithTitle:self.titleTextField.text reminderDate:reminderDate additionalNotes:self.additionalNotesTextView.text parent:self.parent inManagedObjectContext:self.parent.managedObjectContext];
        if (reminderDate) {
            [self scheduleNotificationForTask:task];
        }
    }
}

@end
