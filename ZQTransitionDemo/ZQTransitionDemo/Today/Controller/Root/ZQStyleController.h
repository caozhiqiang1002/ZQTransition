//
//  ZQStyleController.h
//  ZQTransitionDemo
//
//  Created by caozhiqiang on 2019/7/9.
//  Copyright © 2019 caozhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZQAniamtionType) {
    ZQAniamtionTypeLevel,       //层次动画 - 仿AppStore（Today首页）
};


@interface ZQStyleController : UIViewController

@property (nonatomic, assign) ZQAniamtionType type;

@end
