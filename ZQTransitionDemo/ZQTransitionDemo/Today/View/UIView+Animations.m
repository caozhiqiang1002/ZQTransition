//
//  UIView+Animations.m
//  AppStoreDemo
//
//  Created by caozhiqiang on 2019/6/27.
//  Copyright © 2019 caozhiqiang. All rights reserved.
//

#import "UIView+Animations.h"

@implementation UIView (Animations)

+ (void)startAnimateDuration:(NSTimeInterval)duration animate:(AnimationBlock)animate complete:(Completion)complete {
    [UIView animateWithDuration:duration
                          delay:0.0f
         usingSpringWithDamping:0.6f
          initialSpringVelocity:1.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:animate
                     completion:complete];
}

@end
