//
//  ZQTodayDataSource.m
//  AppStoreDemo
//
//  Created by caozhiqiang on 2019/6/27.
//  Copyright © 2019 caozhiqiang. All rights reserved.
//

#import "ZQTodayDataSource.h"

@interface ZQTodayDataSource ()
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) ConfigCellBlock configBlock;
@property (nonatomic, copy) NSString *cellId;
@end

@implementation ZQTodayDataSource

+ (instancetype)dataSourceWithItems:(NSArray *)items
                             cellId:(NSString *)cellId
                    configCellBlock:(ConfigCellBlock)configCellBlock
{
    ZQTodayDataSource *dataSource = [[ZQTodayDataSource alloc] init];
    
    dataSource.items = [items mutableCopy];
    dataSource.cellId = cellId;
    dataSource.configBlock = configCellBlock;
    
    return dataSource;
}

- (id)itemForIndexPath:(NSIndexPath *)indexPath {
    return self.items[indexPath.item];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZQTodayGameCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellId
                                                            forIndexPath:indexPath];
    id item = [self itemForIndexPath:indexPath];
    self.configBlock(cell, item);
    return cell;
}

@end
