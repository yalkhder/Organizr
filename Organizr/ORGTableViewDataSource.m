//
//  ORGTableViewDSD.m
//  Organizr
//
//  Created by Yasser Al-Khder on 2014-08-27.
//  Copyright (c) 2014 Yasser Al-Khder. All rights reserved.
//

#import "ORGTableViewDataSource.h"

@interface ORGTableViewDataSource ()

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ORGTableViewDataSource

- (instancetype)initWithTableView:(UITableView *)tableView
{
    self = [super init];
    if (self) {
        self.tableView = tableView;
        self.tableView.dataSource = self;
    }
    
    return self;
}

- (void)setFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    NSAssert(_fetchedResultsController == nil, @"Cannot assign fetchedResultsController more than once.");
    _fetchedResultsController = fetchedResultsController;
    //TODO: fetchedResultsController delegate
    NSError *error;
    if (![_fetchedResultsController performFetch:&error]) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    id object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.delegate configureCell:cell withObject:object];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

@end
