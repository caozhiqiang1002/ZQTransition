//
//  ZQTodayPushController.m
//  ZQTransitionDemo
//
//  Created by caozhiqiang on 2019/7/9.
//  Copyright © 2019 caozhiqiang. All rights reserved.
//

#import "ZQTodayPushController.h"
#import "ZQLevelTransitionAnimator.h"
#import "ZQTodayDataSource.h"
#import "ZQTodayPopController.h"

static NSString * const CellID = @"Today_Game_ID";

@interface ZQTodayPushController ()<UICollectionViewDelegateFlowLayout, ZQLevelTransitionAnimatorDelegate, UINavigationControllerDelegate, ZQTodayGameCellDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) ZQTodayDataSource *dataSource;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation ZQTodayPushController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self configTableDataSource];
}

#pragma mark - Private

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

- (UIImage *)normalSnapshotImage:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 1.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
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

- (void)jumpToImageDetail:(ZQTodayGameCell *)cell
{
    cell.hidden = YES;
    self.navigationController.delegate = self;
    self.indexPath = [self.collectionView indexPathForCell:cell];
    
    ZQTodayPopController *popVC = [[ZQTodayPopController alloc] init];
    popVC.backImage = cell.gameImageView.image;
    popVC.snapImage = [self normalSnapshotImage:self.view];
    
    [self.navigationController pushViewController:popVC animated:YES];
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return [ZQLevelTransitionAnimator transitionWithDelegate:self
                                                           style:ZQTransitionAnimatorStylePush
                                                        complete:nil];
    }
    return [ZQLevelTransitionAnimator transitionWithDelegate:self
                                                       style:ZQTransitionAnimatorStylePop
                                                    complete:^(UIViewController *toVC) {
                                                        ZQTodayGameCell *cell = (ZQTodayGameCell *)[self.collectionView cellForItemAtIndexPath:self.indexPath];
                                                        cell.hidden = NO;
                                                    }];
}

#pragma mark - ZQLevelTransitionAnimatorDelegate

- (UIView *)customViewForTransitionAnimatior:(ZQLevelTransitionAnimator *)transitionAnimator
{
    ZQTodayGameCell *cell = (ZQTodayGameCell *)[self.collectionView cellForItemAtIndexPath:self.indexPath];
    
    UIImageView *tempView = [[UIImageView alloc] initWithImage:cell.gameImageView.image];
    tempView.frame = [cell convertRect:cell.bounds toView:self.view];
    tempView.contentMode = UIViewContentModeScaleAspectFill;
    
    return tempView;
}

- (BOOL)isSupportCornerRadiusAnimateForTransitionAnimator:(ZQLevelTransitionAnimator *)transitionAnimator
{
    return YES;
}

- (CGFloat)cornerRadiusForTransitionAnimator:(ZQLevelTransitionAnimator *)transitionAnimator
{
    return 25.0f;
}

@end
