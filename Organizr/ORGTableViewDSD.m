//
//  ORGTableViewDSD.m
//  Organizr
//
//  Created by Yasser Al-Khder on 2014-08-27.
//  Copyright (c) 2014 Yasser Al-Khder. All rights reserved.
//

#import "ORGTableViewDSD.h"
#import "ORGAppDelegate.h"

static NSString *kContextKeyPath = @"context";

@interface ORGTableViewDSD ()

@property (copy, nonatomic) NSString *cellIdentifier;
@property (copy, nonatomic) TableViewCellConfigureBlock configureBlock;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ORGTableViewDSD

- (instancetype)initWithFetchRequest:(NSFetchRequest *)fetchRequest cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TableViewCellConfigureBlock)configureBlock
{
    self = [super init];
    if (self) {
        self.cellIdentifier = cellIdentifier;
        self.configureBlock = configureBlock;
        //TODO: set self.fetchedResultsController
    }
    return self;
}

- (void)loadTable
{
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error]) {
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    id item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    self.configureBlock(item, cell);
    return cell;
}

@end
