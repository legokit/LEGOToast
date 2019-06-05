//
//  LGLineProgressToastView.h
//  LEGOToast_Example
//
//  Created by 杨庆人 on 2019/6/3.
//  Copyright © 2019年 564008993@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGToastView.h"
@class LGLineProcessView;

@interface LGProgressToastView : UIView
@property (nonatomic, strong, readwrite) UIColor *defaultColor;  // 进度条背景颜色 default #000000
@property (nonatomic, strong, readwrite) UIColor *fillColor;  // 进度条颜色 default #CFA972
@property (nonatomic, assign, readwrite) CGFloat processValue;  // 进度 0 ~ 1

@property (nonatomic, assign) BOOL automaticDismiss;  // 默认为YES，当processValue为1时自动dismiss

+ (instancetype)showByMessage:(NSString *)msg;

+ (instancetype)showByMessage:(NSString *)msg
         positionType:(LGNoticePopuViewPosition)position;

+ (instancetype)showByMessage:(NSString *)msg inView:(UIView *)view;

+ (instancetype)showByMessage:(NSString *)msg
         positionType:(LGNoticePopuViewPosition)position inView:(UIView *)view;

+ (instancetype)showByMessage:(NSString *)msg
         positionType:(LGNoticePopuViewPosition)position
              offsetY:(CGFloat)offsetY;

+ (instancetype)showByAttributedString:(NSAttributedString *)attributedString
                  positionType:(LGNoticePopuViewPosition)position;

+ (instancetype)showByAttributedString:(NSAttributedString *)attributedString
                  positionType:(LGNoticePopuViewPosition)position
                       offsetY:(CGFloat)offsetY;

// 默认当 processValue = 1 时会dismiss
- (void)dismissCompletion:(void (^ __nullable)(void))completion;

@end

@interface LGLineProcessView : UIView
@property (nonatomic, strong) UIColor *defaultColor;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, assign) CGFloat processValue;
@end
