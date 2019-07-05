//
//  ZQTodayGameCell.m
//  AppStoreDemo
//
//  Created by caozhiqiang on 2019/6/27.
//  Copyright © 2019 caozhiqiang. All rights reserved.
//

#import "ZQTodayGameCell.h"

@interface ZQTodayGameCell ()
@property (nonatomic, assign) BOOL isAnimating;
@end

@implementation ZQTodayGameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.gameImageView.layer.cornerRadius = 25.0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.gameImageView addGestureRecognizer:tap];
}

#pragma mark - Touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"** touchesBegan **");
    if (!self.isAnimating) {
        [UIView startAnimateDuration:0.25f animate:^{
            self.gameImageView.transform = CGAffineTransformMakeScale(0.97, 0.97);
        } complete:nil];
        
        self.isAnimating = YES;
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"** touchesCancelled **");
    if (self.isAnimating) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(jumpToImageDetail:)]) {
            [self.delegate jumpToImageDetail:self];
        }
        self.isAnimating = NO;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"** touchesEnded **");
    if (self.isAnimating) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(jumpToImageDetail:)]) {
            [self.delegate jumpToImageDetail:self];
        }
        self.isAnimating = NO;
    }
}

#pragma mark - Target

- (void)tap:(UITapGestureRecognizer *)recognizer {
    NSLog(@"** tap **");
    if (!self.isAnimating) {
        [UIView startAnimateDuration:0.1f animate:^{
            self.gameImageView.transform = CGAffineTransformMakeScale(0.99, 0.99);
        } complete:^(BOOL isFinished) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(jumpToImageDetail:)]) {
                [self.delegate jumpToImageDetail:self];
            }
        }];
    }
    
}

- (void)handleData:(NSString *)imageName {
    self.gameImageView.image = [UIImage imageNamed:imageName];
    
}

@end
