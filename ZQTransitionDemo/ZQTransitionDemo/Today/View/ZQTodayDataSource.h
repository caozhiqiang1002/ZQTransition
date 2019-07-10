//
//  ZQTodayDataSource.h
//  AppStoreDemo
//
//  Created by caozhiqiang on 2019/6/27.
//  Copyright © 2019 caozhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQTodayGameCell.h"

typedef void(^ConfigCellBlock)(id Cell, id imageName);

@interface ZQTodayDataSource : NSObject<UICollectionViewDataSource>

+ (instancetype)dataSourceWithItems:(NSArray *)items
                             cellId:(NSString *)cellId
                    configCellBlock:(ConfigCellBlock)configCellBlock;

- (id)itemForIndexPath:(NSIndexPath *)indexPath;

@end

