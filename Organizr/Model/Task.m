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

@end
