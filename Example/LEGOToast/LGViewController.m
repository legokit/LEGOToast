//
//  LGViewController.m
//  LEGOToast
//
//  Created by 564008993@qq.com on 05/24/2019.
//  Copyright (c) 2019 564008993@qq.com. All rights reserved.
//

#import "LGViewController.h"
#import "LGToastView.h"
#import "LGProgressToastView.h"
#import <Masonry/Masonry.h>

@interface LGViewController ()

@end

@implementation LGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];

    //    [self.view addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.left.offset(0);
//        make.right.mas_equalTo(self.view.mas_centerX);
//    }];
//
//    UIView *view2 = [[UIView alloc] init];
//    view2.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:view2];
//    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.right.offset(0);
//        make.left.mas_equalTo(self.view.mas_centerX);
//    }];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [LGToastView showByMessage:@"文案文案文案文案文案文案文案文案文案文案文案" positionType:LGNoticePopuViewPositionCenter];
    
//    LGLineProgressToastView *toastView = [LGLineProgressToastView showByAttributedString:[[NSAttributedString alloc] initWithString:@"LGToastView文案"] positionType:0 offsetY:0];
//    toastView.processValue = 0.0;
    
//    LGProgressToastView *toastView = [LGProgressToastView showByMessage:@"LGToastView文案文案文案" positionType:0 offsetY:0];
//    toastView.processValue = 0.0;
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self runTime:toastView];
//    });
    
}

-(void)runTime:(LGProgressToastView *)toastView {
    if (toastView.processValue < 1) {
        toastView.processValue = toastView.processValue + 0.25;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self runTime:toastView];
        });
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
