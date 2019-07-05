//
//  ZQTransitionAnimator.m
//  AppStoreDemo
//
//  Created by caozhiqiang on 2019/7/4.
//  Copyright © 2019 caozhiqiang. All rights reserved.
//

#import "ZQTransitionAnimator.h"

@implementation ZQTransitionAnimator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"如果想要自定义转场动画，需要开发者继承该类，重写该方法");
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

@end
