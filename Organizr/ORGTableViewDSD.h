//
//  ORGTableViewDSD.h
//  Organizr
//
//  Created by Yasser Al-Khder on 2014-08-27.
//  Copyright (c) 2014 Yasser Al-Khder. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@interface ORGTableViewDSD : NSObject <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithFetchRequest:(NSFetchRequest *)fetchRequest cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TableViewCellConfigureBlock)configureBlock;

@end
