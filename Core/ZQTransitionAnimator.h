//
//  ZQTransitionAnimator.h
//  AppStoreDemo
//
//  Created by caozhiqiang on 2019/7/4.
//  Copyright © 2019 caozhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZQTransitionAnimationCompleteBlock)(UIViewController *toVC);

typedef NS_ENUM(NSUInteger, ZQTransitionAnimatorStyle) {
    
    ZQTransitionAnimatorStylePush,
    ZQTransitionAnimatorStylePop,
    
    ZQTransitionAnimatorStylePresent,
    ZQTransitionAnimatorStyleDismiss,
    
};

@interface ZQTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@end
