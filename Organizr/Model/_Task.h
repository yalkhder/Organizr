// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Task.h instead.

#import <CoreData/CoreData.h>


extern const struct TaskAttributes {
	__unsafe_unretained NSString *additionalNotes;
	__unsafe_unretained NSString *reminderDate;
	__unsafe_unretained NSString *title;
} TaskAttributes;

extern const struct TaskRelationships {
	__unsafe_unretained NSString *children;
	__unsafe_unretained NSString *parent;
} TaskRelationships;

extern const struct TaskFetchedProperties {
} TaskFetchedProperties;

@class Task;
@class Task;





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





@property (nonatomic, strong) NSSet *children;

- (NSMutableSet*)childrenSet;




@property (nonatomic, strong) Task *parent;

//- (BOOL)validateParent:(id*)value_ error:(NSError**)error_;





@end

@interface _Task (CoreDataGeneratedAccessors)

- (void)addChildren:(NSSet*)value_;
- (void)removeChildren:(NSSet*)value_;
- (void)addChildrenObject:(Task*)value_;
- (void)removeChildrenObject:(Task*)value_;

@end

@interface _Task (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAdditionalNotes;
- (void)setPrimitiveAdditionalNotes:(NSString*)value;




- (NSDate*)primitiveReminderDate;
- (void)setPrimitiveReminderDate:(NSDate*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (NSMutableSet*)primitiveChildren;
- (void)setPrimitiveChildren:(NSMutableSet*)value;



- (Task*)primitiveParent;
- (void)setPrimitiveParent:(Task*)value;


@end
