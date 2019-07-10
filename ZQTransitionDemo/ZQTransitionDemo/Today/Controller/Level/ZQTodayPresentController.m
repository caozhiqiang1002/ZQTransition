//
//  ZQTodayPresentController.m
//  AppStoreDemo
//
//  Created by caozhiqiang on 2019/6/27.
//  Copyright © 2019 caozhiqiang. All rights reserved.
//

#import "ZQTodayPresentController.h"
#import "ZQTodayDataSource.h"
#import "UIView+Animations.h"
#import "ZQTodayDismissController.h"
#import "ZQAppDelegate.h"
#import "ZQLevelTransitionAnimator.h"

static NSString * const CellID = @"Today_Game_ID";

@interface ZQTodayPresentController ()<UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate, ZQTodayGameCellDelegate, ZQLevelTransitionAnimatorDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) ZQTodayDataSource *dataSource;

@end

@implementation ZQTodayPresentController

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
    self.collectionView.dataSource = self.dataSource;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZQTodayGameCell" bundle:nil]
         forCellWithReuseIdentifier:CellID];
    
    [self.collectionView reloadData];
}

- (UIImage *)normalSnapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, [UIScreen mainScreen].scale);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth-20*2, 480);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 20, 15, 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}

#pragma mark - ZQTodayGameCellDelegate

- (void)jumpToImageDetail:(ZQTodayGameCell *)cell {
    
    self.indexPath = [self.collectionView indexPathForCell:cell];
    
    cell.gameImageView.hidden = YES;
    UIImage *snapImage = [self normalSnapshotImage];
    
    ZQTodayDismissController *detailVC = [[ZQTodayDismissController alloc] init];
    detailVC.snapImage = snapImage;
    detailVC.backImage = cell.gameImageView.image;
    detailVC.transitioningDelegate = self;
    detailVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:detailVC animated:YES completion:nil];
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
                                                        ZQTodayGameCell *cell = (ZQTodayGameCell *)[self.collectionView cellForItemAtIndexPath:self.indexPath];
                                                        cell.gameImageView.hidden = NO;
                                                    }];
}

#pragma mark - ZQLevelTransitionAnimatorDelegate

- (UIView *)customViewForTransitionAnimatior:(ZQLevelTransitionAnimator *)transitionAnimator {
    ZQTodayGameCell *cell = (ZQTodayGameCell *)[self.collectionView cellForItemAtIndexPath:self.indexPath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.gameImageView.image];
    imageView.frame = [cell.gameImageView convertRect:cell.gameImageView.bounds toView:self.view];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return imageView;
}

- (BOOL)isSupportCornerRadiusAnimateForTransitionAnimator:(ZQLevelTransitionAnimator *)transitionAnimator {
    return YES;
}

- (CGFloat)cornerRadiusForTransitionAnimator:(ZQLevelTransitionAnimator *)transitionAnimator {
    return 25.0f;
}

@end
