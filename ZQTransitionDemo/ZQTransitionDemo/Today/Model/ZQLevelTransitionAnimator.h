//
//  ZQLevelTransitionAnimator.h
//  AppStoreDemo
//
//  Created by caozhiqiang on 2019/7/4.
//  Copyright © 2019 caozhiqiang. All rights reserved.
//

#import "ZQTransitionAnimator.h"

@protocol ZQLevelTransitionAnimatorDelegate;


/**
 @brief 使用该类时，需要采用过协议的控制器设置代理对象
 */
@interface ZQLevelTransitionAnimator : ZQTransitionAnimator

/**
 @brief 初始化操作

 @param delegate 代理对象
 @param style 转场类型
 @param complete 转场完成的回调
 */
+ (ZQLevelTransitionAnimator *)transitionWithDelegate:(id<ZQLevelTransitionAnimatorDelegate>)delegate
                                                style:(ZQTransitionAnimatorStyle)style
                                             complete:(ZQTransitionAnimationCompleteBlock)complete;

@end


@protocol ZQLevelTransitionAnimatorDelegate <NSObject>

@optional
/**
 @brief 设置 customView
 
 @discussion push（present）时，必须实现该方法，pop（dismiss）时，不需要设置该方法
 
 @note 该视图必须重新创建，不可直接将已有视图作为返回值
 */
- (UIView *)customViewForTransitionAnimatior:(ZQLevelTransitionAnimator *)transitionAnimator;

/**
 @brief 是否支持圆角动画

 @discussion push（present）时，可以选择设置该方法，pop（dismiss）时，不需要设置该方法
 */
- (BOOL)isSupportCornerRadiusAnimateForTransitionAnimator:(ZQLevelTransitionAnimator *)transitionAnimator;

/**
 @brief 设置 customView 的圆角
 
 @discussion push（present）时，可以选择设置该方法，pop（dismiss）时，不需要设置该方法
 */
- (CGFloat)cornerRadiusForTransitionAnimator:(ZQLevelTransitionAnimator *)transitionAnimator;

@end
