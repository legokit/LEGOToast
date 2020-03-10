//
//  LGToastView.m
//  LEGOToast_Example
//
//  Created by 杨庆人 on 2019/6/3.
//  Copyright © 2019年 564008993@qq.com. All rights reserved.
//

#import "LGToastView.h"
#import <Masonry/Masonry.h>

#define LGToastViewWindow [[UIApplication sharedApplication].delegate window]

@interface LGToastView ()
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, assign) LGNoticePopuViewPosition positionType;
@property (nonatomic, strong) CAGradientLayer *gl;
@end

@implementation LGToastView

+ (void)showByMessage:(NSString *)msg {
    [self.class showByMessage:msg inView:LGToastViewWindow];
}

+ (void)showByMessage:(NSString *)msg inView:(UIView *)view {
    [self.class showByMessage:msg positionType:LGNoticePopuViewPositionCenter];
}

+ (void)showByMessage:(NSString *)msg
         positionType:(LGNoticePopuViewPosition)position {
    [self.class showByMessage:msg positionType:position inView:LGToastViewWindow];
}

+ (void)showByMessage:(NSString *)msg
         positionType:(LGNoticePopuViewPosition)position inView:(UIView *)view {
    [self.class showByMessage:msg positionType:position inView:view offsetY:0];
}

+ (void)showByMessage:(NSString *)msg
         positionType:(LGNoticePopuViewPosition)position offsetY:(CGFloat)offsetY {
    [self.class showByMessage:msg positionType:position inView:LGToastViewWindow offsetY:offsetY];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self addSubview:self.contentLabel];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.edges.mas_equalTo(UIEdgeInsetsMake(21, 37, 21, 37));
        }];
    }
    return self;
}

+ (void)showByMessage:(NSString *)msg
         positionType:(LGNoticePopuViewPosition)position
               inView:(UIView *)view
              offsetY:(CGFloat)offsetY {
    dispatch_async(dispatch_get_main_queue(), ^{
        LGToastView *toastView = [[LGToastView alloc] initWithFrame:CGRectZero];
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:msg attributes:nil];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5; // 行间距
        paragraphStyle.alignment = NSTextAlignmentCenter;
        NSRange range = NSMakeRange(0, [msg length]);
        [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
        toastView.contentLabel.attributedText = attrStr;
        
        toastView.alpha = 0;
        toastView.positionType = position;
        [view addSubview:toastView];
        
        [toastView setUpFrameWithoffsetY:offsetY];
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [toastView setAlpha:1];
        } completion:^(BOOL finished) {
            NSTimeInterval delay = [LGToastGlobalParameter shareManager].interval ? [LGToastGlobalParameter shareManager].interval : 1;
            [UIView animateWithDuration:0.2 delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [toastView setAlpha:0];
            } completion:^(BOOL finished) {
                [toastView removeFromSuperview];
            }];
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (toastView && toastView.superview) {
                [toastView removeFromSuperview];
            }
        });
    });
}

+ (void)showByAttributedString:(NSAttributedString *)attributedString
                  positionType:(LGNoticePopuViewPosition)position {
    [self.class showByAttributedString:attributedString positionType:position inView:LGToastViewWindow offsetY:0];
}

+ (void)showByAttributedString:(NSAttributedString *)attributedString
                  positionType:(LGNoticePopuViewPosition)position
                       offsetY:(CGFloat)offsetY {
    [self.class showByAttributedString:attributedString positionType:position inView:LGToastViewWindow offsetY:offsetY];
}

+ (void)showByAttributedString:(NSAttributedString *)attributedString
                  positionType:(LGNoticePopuViewPosition)position
                        inView:(UIView *)view
                       offsetY:(CGFloat)offsetY {
    dispatch_async(dispatch_get_main_queue(), ^{
            LGToastView *toastView = [[LGToastView alloc] initWithFrame:CGRectZero];
        [toastView.contentLabel setAttributedText:attributedString];
        toastView.alpha = 0;
        toastView.positionType = position;
        [view addSubview:toastView];
        
        [toastView setUpFrameWithoffsetY:offsetY];
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [toastView setAlpha:1];
        } completion:^(BOOL finished) {
            if (finished) {
                [UIView animateWithDuration:0.2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [toastView setAlpha:0];
                } completion:^(BOOL finished) {
                    if (finished) {
                        [toastView removeFromSuperview];
                    }
                }];
            }
        }];
    });
}

- (void)setUpFrameWithoffsetY:(CGFloat)offsetY {
    CGFloat bottomAndTopSpace = 20;
    CGFloat leftAndRightSpaec = 20;
    CGFloat topSpace = 60;
    CGFloat bottomSpace = 60;
    CGFloat maxShowWidth = (CGRectGetWidth(self.superview.bounds) - leftAndRightSpaec * 2);
    CGFloat maxShowHeight = (CGRectGetHeight(self.superview.bounds) - bottomAndTopSpace * 2);
    
    if (LGNoticePopuViewPositionTop == self.positionType) {
        maxShowHeight -= topSpace;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.superview);
            make.top.mas_equalTo(self.superview).offset(topSpace + offsetY);
            make.size.mas_lessThanOrEqualTo(CGSizeMake(maxShowWidth, maxShowHeight));
        }];
    }
    else if (LGNoticePopuViewPositionBottom == self.positionType) {
        maxShowHeight -= bottomSpace;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.superview);
            make.bottom.mas_equalTo(self.superview).offset(-bottomSpace + offsetY);
            make.size.mas_lessThanOrEqualTo(CGSizeMake(maxShowWidth, maxShowHeight));
        }];
    }
    else if (LGNoticePopuViewPositionCustom == self.positionType) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.superview);
            make.top.mas_equalTo(self.superview).offset(offsetY);
            make.size.mas_lessThanOrEqualTo(CGSizeMake(maxShowWidth, maxShowHeight));
        }];
    }
    else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.superview);
            make.centerY.mas_equalTo(self.superview).offset(offsetY);
            make.size.mas_lessThanOrEqualTo(CGSizeMake(maxShowWidth, maxShowHeight));
        }];
    }
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        if ([LGToastGlobalParameter shareManager].font) {
            _contentLabel.font = [LGToastGlobalParameter shareManager].font;
        }
        else {
            if (@available(iOS 8.2, *)) {
                _contentLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
            }
            else {
                _contentLabel.font = [UIFont systemFontOfSize:14];
            }
        }
    }
    return _contentLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.gl && self.gl.superlayer) {
        [self.gl removeFromSuperlayer];
    }
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = self.bounds;
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 0);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:0.9].CGColor,(__bridge id)[UIColor colorWithRed:42/255.0 green:42/255.0 blue:42/255.0 alpha:0.9].CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    [self.layer insertSublayer:gl below:self.contentLabel.layer];
    self.gl = gl;
}

@end

@implementation LGToastGlobalParameter

static LGToastGlobalParameter *shareManager = nil;

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[LGToastGlobalParameter alloc] init];
    });
    return shareManager;
}

@end
