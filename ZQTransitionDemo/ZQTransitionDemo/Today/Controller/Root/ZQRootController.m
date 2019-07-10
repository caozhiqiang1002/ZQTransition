//
//  ZQRootController.m
//  ZQTransitionDemo
//
//  Created by caozhiqiang on 2019/7/9.
//  Copyright © 2019 caozhiqiang. All rights reserved.
//

#import "ZQRootController.h"
#import "ZQStyleController.h"

@interface ZQRootController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *animations;

@end

@implementation ZQRootController

- (NSArray *)animations {
    if (!_animations) {
        _animations = @[@(ZQAniamtionTypeLevel)];
    }
    return _animations;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择转场动画的方式";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.animations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.textLabel.textColor = [UIColor blackColor];
    ZQAniamtionType type = [self.animations[indexPath.row] integerValue];
    
    if (type == ZQAniamtionTypeLevel) {
        cell.textLabel.text = @"Level";
    }else{
        cell.textLabel.text = @"";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZQStyleController *styleVC = [[ZQStyleController alloc] init];
    styleVC.type = [self.animations[indexPath.row] integerValue];
    [self.navigationController pushViewController:styleVC animated:YES];
}

@end
