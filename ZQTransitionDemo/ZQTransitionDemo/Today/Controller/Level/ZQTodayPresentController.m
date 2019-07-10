//
//  ZQTodayController.m
//  AppStoreDemo
//
//  Created by caozhiqiang on 2019/6/27.
//  Copyright © 2019 caozhiqiang. All rights reserved.
//

#import "ZQTodayController.h"
#import "ZQTodayDataSource.h"
#import "UIView+Animations.h"
#import "ZQDetailViewController.h"
#import "ZQAppDelegate.h"
#import "ZQLevelTransitionAnimator.h"

static NSString * const CellID = @"Today_Game_ID";

@interface ZQTodayController ()<UITableViewDelegate,
                                UINavigationControllerDelegate,
                                UIViewControllerTransitioningDelegate,
                                ZQTodayGameCellDelegate,
                                ZQLevelTransitionAnimatorDelegate>

@property (nonatomic, strong) ZQTodayDataSource *dataSource;

@end

@implementation ZQTodayController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableDataSource];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)configTableDataSource {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"games" ofType:@"plist"];
    NSArray *images = [[NSArray alloc] initWithContentsOfFile:filePath];
    
    ConfigCellBlock block = ^(ZQTodayGameCell *cell, NSString *imageName) {
        [cell handleData:imageName];
        cell.delegate = self;
    };
    
    self.dataSource = [ZQTodayDataSource dataSourceWithItems:images
                                                      cellId:CellID configCellBlock:block];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZQTodayGameCell" bundle:nil]
         forCellReuseIdentifier:CellID];
    
    [self.tableView reloadData];
}

- (UIImage *)normalSnapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, [UIScreen mainScreen].scale);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 500;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"*** didSelectRowAtIndexPath ***");
}

#pragma mark - ZQTodayGameCellDelegate

- (void)jumpToImageDetail:(ZQTodayGameCell *)cell {
    
    self.indexPath = [self.tableView indexPathForCell:cell];
    
    cell.gameImageView.hidden = YES;
    UIImage *snapImage = [self normalSnapshotImage];
    
    ZQDetailViewController *detailVC = [[ZQDetailViewController alloc] init];
    detailVC.snapImage = snapImage;
    detailVC.backImage = cell.gameImageView.image;
    detailVC.transitioningDelegate = self;
    detailVC.modalPresentationStyle = UIModalPresentationCustom;
    self.navigationController.delegate = self;
    [self presentViewController:detailVC animated:YES completion:nil];
//    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return [ZQLevelTransitionAnimator transitionWithDelegate:self style:ZQTransitionAnimatorStylePush complete:nil];
    }
    return [ZQLevelTransitionAnimator transitionWithDelegate:self
                                                       style:ZQTransitionAnimatorStylePop
                                                    complete:^(UIViewController *toVC) {
                                                        ZQTodayGameCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPath];
                                                        cell.gameImageView.hidden = NO;
                                                    }];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [ZQLevelTransitionAnimator transitionWithDelegate:self
                                                       style:ZQTransitionAnimatorStylePresent
                                                    complete:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [ZQLevelTransitionAnimator transitionWithDelegate:nil
                                                       style:ZQTransitionAnimatorStyleDismiss
                                                    complete:^(UIViewController *toVC) {
                                                        ZQTodayGameCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPath];
                                                        cell.gameImageView.hidden = NO;
                                                    }];
}

#pragma mark - ZQLevelTransitionAnimatorDelegate

- (UIView *)customViewForTransitionAnimatior:(ZQLevelTransitionAnimator *)transitionAnimator {
    ZQTodayGameCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.gameImageView.image];
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 25.0f;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.frame = [cell.gameImageView convertRect:cell.gameImageView.bounds toView:self.view];
    
    return imageView;
}

- (BOOL)isSupportCornerRadiusAnimateForTransitionAnimator:(ZQLevelTransitionAnimator *)transitionAnimator {
    return YES;
}

- (CGFloat)cornerRadiusForTransitionAnimator:(ZQLevelTransitionAnimator *)transitionAnimator {
    return 25.0f;
}

@end
