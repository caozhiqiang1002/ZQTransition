//
//  ZQStyleController.m
//  ZQTransitionDemo
//
//  Created by caozhiqiang on 2019/7/9.
//  Copyright © 2019 caozhiqiang. All rights reserved.
//

#import "ZQStyleController.h"
#import "ZQTodayPresentController.h"
#import "ZQTodayPushController.h"

@interface ZQStyleController ()

@end

@implementation ZQStyleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)push:(id)sender {
    switch (self.type) {
        case ZQAniamtionTypeLevel:
            {
                ZQTodayPushController *todayVC = [[ZQTodayPushController alloc] init];
                [self.navigationController pushViewController:todayVC animated:YES];
            }
            break;
        default:
            break;
    }
}

- (IBAction)present:(id)sender {
    switch (self.type) {
        case ZQAniamtionTypeLevel:
            {
                ZQTodayPresentController *todayVC = [[ZQTodayPresentController alloc] init];
                [self.navigationController pushViewController:todayVC animated:YES];
            }
            break;
            
        default:
            break;
    }
}
@end
