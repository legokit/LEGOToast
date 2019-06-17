//
//  LGToastView.h
//  LEGOToast_Example
//
//  Created by 杨庆人 on 2019/6/3.
//  Copyright © 2019年 564008993@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LGToastGlobalParameter;

typedef NS_ENUM(NSInteger, LGNoticePopuViewPosition) {
    LGNoticePopuViewPositionCenter,  // Center
    LGNoticePopuViewPositionTop,   // Top
    LGNoticePopuViewPositionBottom,  // Bottom
    
    LGNoticePopuViewPositionCustom  // Custom
};


@interface LGToastView : UIView

+ (void)showByMessage:(NSString *)msg;

+ (void)showByMessage:(NSString *)msg
         positionType:(LGNoticePopuViewPosition)position;

+ (void)showByMessage:(NSString *)msg inView:(UIView *)view;

+ (void)showByMessage:(NSString *)msg
         positionType:(LGNoticePopuViewPosition)position inView:(UIView *)view;

+ (void)showByMessage:(NSString *)msg
         positionType:(LGNoticePopuViewPosition)position
              offsetY:(CGFloat)offsetY;

+ (void)showByAttributedString:(NSAttributedString *)attributedString
                  positionType:(LGNoticePopuViewPosition)position;

+ (void)showByAttributedString:(NSAttributedString *)attributedString
                  positionType:(LGNoticePopuViewPosition)position
                       offsetY:(CGFloat)offsetY;

@end

@interface LGToastGlobalParameter : NSObject

@property (nonatomic, strong) UIFont *font;  // 全局字体配置

+ (instancetype)shareManager;

@end
