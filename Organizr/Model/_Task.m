// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Task.m instead.

#import "_Task.h"

const struct TaskAttributes TaskAttributes = {
	.additionalNotes = @"additionalNotes",
	.reminderDate = @"reminderDate",
	.title = @"title",
};

const struct TaskRelationships TaskRelationships = {
	.children = @"children",
	.parent = @"parent",
};

const struct TaskFetchedProperties TaskFetchedProperties = {
};

@implementation TaskID
@end

@implementation _Task

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Task";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Task" inManagedObjectContext:moc_];
}

- (TaskID*)objectID {
	return (TaskID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic additionalNotes;






@dynamic reminderDate;






@dynamic title;






@dynamic children;

	
- (NSMutableSet*)childrenSet {
	[self willAccessValueForKey:@"children"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"children"];
  
	[self didAccessValueForKey:@"children"];
	return result;
}
	

@dynamic parent;

	






@end
