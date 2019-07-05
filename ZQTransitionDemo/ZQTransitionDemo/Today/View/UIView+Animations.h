//
//  UIView+Animations.h
//  AppStoreDemo
//
//  Created by caozhiqiang on 2019/6/27.
//  Copyright © 2019 caozhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AnimationBlock)(void);
typedef void(^Completion)(BOOL isFinished);

@interface UIView (Animations)

+ (void)startAnimateDuration:(NSTimeInterval)duration animate:(AnimationBlock)animate complete:(Completion)complete;

@end
