//
//  ZQLevelTransitionAnimator.m
//  AppStoreDemo
//
//  Created by caozhiqiang on 2019/7/4.
//  Copyright © 2019 caozhiqiang. All rights reserved.
//

#import "ZQLevelTransitionAnimator.h"

@interface ZQLevelTransitionAnimator ()

@property (nonatomic, weak) id<ZQLevelTransitionAnimatorDelegate> delegate;
@property (nonatomic, copy) ZQTransitionAnimationCompleteBlock complete;

@property (nonatomic, assign) ZQTransitionAnimatorStyle style;

@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, assign) BOOL isSupported;
@property (nonatomic, assign) CGFloat cornerRadius;

@end

@implementation ZQLevelTransitionAnimator

+ (instancetype)sharedInstance
{
    static ZQLevelTransitionAnimator *animator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        animator = [[self alloc] init];
    });
    return animator;
}

+ (ZQLevelTransitionAnimator *)transitionWithDelegate:(id<ZQLevelTransitionAnimatorDelegate>)delegate
                                                style:(ZQTransitionAnimatorStyle)style
                                             complete:(ZQTransitionAnimationCompleteBlock)complete
{
    ZQLevelTransitionAnimator *animator = [ZQLevelTransitionAnimator sharedInstance];
    animator.delegate = delegate;
    animator.style = style;
    animator.complete = complete;
    return animator;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (self.style) {
        case ZQTransitionAnimatorStylePush:
        case ZQTransitionAnimatorStylePresent:
            [self animateTransitionForPushOrPresentStyle:transitionContext];
            break;
        case ZQTransitionAnimatorStylePop:
        case ZQTransitionAnimatorStyleDismiss:
            [self animateTransitionForPopOrDismissStyle:transitionContext];
            break;
        default:
            break;
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.8f;
}

#pragma mark - Private

- (void)animateTransitionForPushOrPresentStyle:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.hidden = YES;
    
    UIView *tempView = [self.delegate customViewForTransitionAnimatior:self];
    if (!tempView) {
        NSString *protocolName = NSStringFromProtocol(@protocol(ZQLevelTransitionAnimatorDelegate));
        NSString *selectorName = NSStringFromSelector(@selector(customViewForTransitionAnimatior:));
        [NSException raise:@"OBJECT_ERROR" format:@"%@ 协议中的 %@ 返回的值不能为空", protocolName, selectorName];
        return;
    }
    
    self.originFrame = tempView.frame;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:tempView];
    [containerView insertSubview:toVC.view belowSubview:tempView];
    
    if ([self.delegate respondsToSelector:@selector(isSupportCornerRadiusAnimateForTransitionAnimator:)]) {
        self.isSupported = [self.delegate isSupportCornerRadiusAnimateForTransitionAnimator:self];
        tempView.clipsToBounds = self.isSupported;
    }
    
    self.cornerRadius = 5.0f;
    if ([self.delegate respondsToSelector:@selector(cornerRadiusForTransitionAnimator:)]) {
        self.cornerRadius = [self.delegate cornerRadiusForTransitionAnimator:self];
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
         usingSpringWithDamping:0.6f
          initialSpringVelocity:1.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         tempView.frame = containerView.frame;
                         if (self.isSupported) {
                             tempView.layer.cornerRadius = 0.0f;
                         }
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                         tempView.hidden = YES;
                         toVC.view.hidden = NO;
                         
                         if (self.complete) self.complete(toVC);
                     }];
}

- (void)animateTransitionForPopOrDismissStyle:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = containerView.subviews.lastObject;
    tempView.hidden = NO;
    
    if (self.style == ZQTransitionAnimatorStylePop) {
        [containerView insertSubview:toVC.view belowSubview:tempView];
    }else{
        containerView.subviews.firstObject.hidden = YES;
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
         usingSpringWithDamping:0.6f
          initialSpringVelocity:1.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         tempView.frame = self.originFrame;
                         if (self.isSupported) {
                             tempView.layer.cornerRadius = self.cornerRadius;
                         }
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                         [tempView removeFromSuperview];
                         
                         if (self.complete) self.complete(toVC);
                     }];
}

@end
