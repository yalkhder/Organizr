#import "_Task.h"

@interface Task : _Task {}

+ (instancetype)insertTaskWithTitle:(NSString *)title reminderDate:(NSDate *)reminderDate additionalNotes:(NSString *)additionalNotes parent:(Task *)parent inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
- (NSFetchedResultsController *)childrenFetchedResultsController;

@end
