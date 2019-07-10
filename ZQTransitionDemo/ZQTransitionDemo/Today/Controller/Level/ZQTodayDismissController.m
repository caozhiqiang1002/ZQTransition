//
//  ZQDetailViewController.m
//  AppStoreDemo
//
//  Created by caozhiqiang on 2019/7/2.
//  Copyright © 2019 caozhiqiang. All rights reserved.
//

#import "ZQDetailViewController.h"
#import "ZQTodayPresentController.h"
#import "ZQTodayGameCell.h"
#import "ZQLevelTransitionAnimator.h"

@interface ZQDetailViewController ()

@property (nonatomic, assign) CGPoint point;
@end

@implementation ZQDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createSnapView];
    [self createImageView];
}

- (void)createSnapView {
    self.snapView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.snapView.backgroundColor = [UIColor clearColor];
    self.snapView.image = self.snapImage;
    self.snapView.contentMode = UIViewContentModeScaleAspectFill;
    self.snapView.clipsToBounds = YES;
    [self.view addSubview:self.snapView];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.snapView.bounds;
    [self.snapView addSubview:effectView];
}

- (void)createImageView {
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.backgroundColor = [UIColor clearColor];
    self.imageView.image = self.backImage;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self.view addSubview:self.imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.point = [touches.anyObject locationInView:self.snapView];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [touches.anyObject locationInView:self.snapView];
    if (point.y > self.point.y) {
        CGFloat scale = 1.0 - fabs(point.y - self.point.y)/kScreenHeight;
        if (scale >= 0.8) {
            self.imageView.transform = CGAffineTransformMakeScale(scale, scale);
            self.imageView.layer.cornerRadius = 25.0 *(1 - scale)*5;
        }else{
//            [self.navigationController popViewControllerAnimated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }else {
        [self touchesEnded:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView startAnimateDuration:0.25 animate:^{
        self.imageView.transform = CGAffineTransformIdentity;
        self.imageView.layer.cornerRadius = 0.0f;
    } complete:nil];
}

@end
