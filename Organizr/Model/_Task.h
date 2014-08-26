// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Task.h instead.

#import <CoreData/CoreData.h>


extern const struct TaskAttributes {
	__unsafe_unretained NSString *additionalNotes;
	__unsafe_unretained NSString *reminderDate;
	__unsafe_unretained NSString *title;
} TaskAttributes;

extern const struct TaskRelationships {
} TaskRelationships;

extern const struct TaskFetchedProperties {
} TaskFetchedProperties;






@interface TaskID : NSManagedObjectID {}
@end

@interface _Task : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TaskID*)objectID;





@property (nonatomic, strong) NSString* additionalNotes;



//- (BOOL)validateAdditionalNotes:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* reminderDate;



//- (BOOL)validateReminderDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;






@end

@interface _Task (CoreDataGeneratedAccessors)

@end

@interface _Task (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAdditionalNotes;
- (void)setPrimitiveAdditionalNotes:(NSString*)value;




- (NSDate*)primitiveReminderDate;
- (void)setPrimitiveReminderDate:(NSDate*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




@end
