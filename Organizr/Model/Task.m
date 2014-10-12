#import "Task.h"


@interface Task ()

// Private interface goes here.

@end


@implementation Task

+ (instancetype)insertTaskWithTitle:(NSString *)title reminderDate:(NSDate *)reminderDate additionalNotes:(NSString *)additionalNotes parent:(Task *)parent inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    Task *task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:managedObjectContext];
    task.title = title;
    task.reminderDate = reminderDate;
    task.additionalNotes = additionalNotes;
    task.parent = parent;
    return task;
}

- (NSFetchedResultsController *)childrenFetchedResultsController
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:self.entity.name];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"reminderDate" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"parent = %@", self];
    return [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}

- (void)scheduleLocalNotification
{
    if (self.reminderDate) {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = self.reminderDate;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.alertBody = self.title;
        localNotification.alertAction = @"view";
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.applicationIconBadgeNumber++;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}

- (void)cancelLocalNotification
{
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSUInteger notificationIndex = [localNotifications indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        UILocalNotification *notification = obj;
        return ([notification.alertBody isEqualToString:self.title] && [notification.fireDate isEqualToDate:self.reminderDate]);
    }];
    if (notificationIndex != NSNotFound) {
        [[UIApplication sharedApplication] cancelLocalNotification:[localNotifications objectAtIndex:notificationIndex]];
    }
}

@end
