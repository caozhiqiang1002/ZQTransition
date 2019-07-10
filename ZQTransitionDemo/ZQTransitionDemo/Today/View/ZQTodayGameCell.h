//
//  ZQTodayGameCell.h
//  AppStoreDemo
//
//  Created by caozhiqiang on 2019/6/27.
//  Copyright © 2019 caozhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZQTodayGameCell;

@protocol ZQTodayGameCellDelegate <NSObject>

- (void)jumpToImageDetail:(ZQTodayGameCell *)cell;

@end

@interface ZQTodayGameCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *gameImageView;

@property (nonatomic, weak) id<ZQTodayGameCellDelegate> delegate;

- (void)handleData:(NSString *)imageName;

@end
