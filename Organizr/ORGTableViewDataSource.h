//
//  ORGTableViewDSD.h
//  Organizr
//
//  Created by Yasser Al-Khder on 2014-08-27.
//  Copyright (c) 2014 Yasser Al-Khder. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ORGTableViewDataSourceDelegate <NSObject>

- (void)configureCell:(id)cell withObject:(id)object;
- (CGFloat)heightForRowWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
- (void)deleteObject:(id)object;

@end

@interface ORGTableViewDataSource : NSObject <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (copy, nonatomic) NSString *cellIdentifier;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) id<ORGTableViewDataSourceDelegate> delegate;
@property (nonatomic) BOOL paused;

- (instancetype)initWithTableView:(UITableView *)tableView;

@end
