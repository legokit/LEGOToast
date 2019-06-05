//
//  LGLineProgressToastView.m
//  LEGOToast_Example
//
//  Created by 杨庆人 on 2019/6/3.
//  Copyright © 2019年 564008993@qq.com. All rights reserved.
//

#import "LGProgressToastView.h"
#import <Masonry/Masonry.h>

#define LGToastViewWindow [[UIApplication sharedApplication].delegate window]
#define content_w 190
@interface LGProgressToastView ()
@property (nonatomic, strong) LGLineProcessView *processView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, assign) LGNoticePopuViewPosition positionType;
@property (nonatomic, strong) CAGradientLayer *gl;
@end

@implementation LGProgressToastView

+ (instancetype)showByMessage:(NSString *)msg {
    return [self.class showByMessage:msg inView:LGToastViewWindow];
}

+ (instancetype)showByMessage:(NSString *)msg inView:(UIView *)view {
    return [self.class showByMessage:msg positionType:LGNoticePopuViewPositionCenter];
}

+ (instancetype)showByMessage:(NSString *)msg
         positionType:(LGNoticePopuViewPosition)position {
    return [self.class showByMessage:msg positionType:position inView:LGToastViewWindow];
}

+ (instancetype)showByMessage:(NSString *)msg
         positionType:(LGNoticePopuViewPosition)position inView:(UIView *)view {
    return [self.class showByMessage:msg positionType:position inView:view offsetY:0];
}

+ (instancetype)showByMessage:(NSString *)msg
         positionType:(LGNoticePopuViewPosition)position offsetY:(CGFloat)offsetY {
    return [self.class showByMessage:msg positionType:position inView:LGToastViewWindow offsetY:offsetY];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.automaticDismiss = YES;
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        [self addSubview:self.contentLabel];
        [self addSubview:self.processView];
        
        // 根据 text 内容撑开 toast
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.edges.mas_equalTo(UIEdgeInsetsMake(60, 30, 31, 30));
        }];
        
    }
    return self;
}

+ (instancetype)showByMessage:(NSString *)msg
                 positionType:(LGNoticePopuViewPosition)position
                       inView:(UIView *)view
                      offsetY:(CGFloat)offsetY {
    LGProgressToastView *toastView = [[LGProgressToastView alloc] initWithFrame:CGRectZero];
    [toastView.contentLabel setText:[NSString stringWithFormat:@"%@",msg]];
    toastView.alpha = 0;
    toastView.positionType = position;
    [view addSubview:toastView];
    
    [toastView setUpFrameWithoffsetY:offsetY];
    [self.class show:toastView];
    
    return toastView;
}

+ (instancetype)showByAttributedString:(NSAttributedString *)attributedString
                  positionType:(LGNoticePopuViewPosition)position {
    return [self.class showByAttributedString:attributedString positionType:position inView:LGToastViewWindow offsetY:0];
}

+ (instancetype)showByAttributedString:(NSAttributedString *)attributedString
                  positionType:(LGNoticePopuViewPosition)position
                       offsetY:(CGFloat)offsetY {
    return [self.class showByAttributedString:attributedString positionType:position inView:LGToastViewWindow offsetY:offsetY];
}

+ (instancetype)showByAttributedString:(NSAttributedString *)attributedString
                  positionType:(LGNoticePopuViewPosition)position
                        inView:(UIView *)view
                       offsetY:(CGFloat)offsetY {
    LGProgressToastView *toastView = [[LGProgressToastView alloc] initWithFrame:CGRectZero];
    [toastView.contentLabel setAttributedText:attributedString];
    toastView.alpha = 0;
    toastView.positionType = position;
    [view addSubview:toastView];
    
    [toastView setUpFrameWithoffsetY:offsetY];
    [self.class show:toastView];
    
    return toastView;
}

+ (void)show:(LGProgressToastView *)toastView {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [toastView setAlpha:1];
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
    
}

- (void)dismissCompletion:(void (^ __nullable)(void))completion {
    LGProgressToastView *toastView = self;
    [UIView animateWithDuration:0.2 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [toastView setAlpha:0];
    } completion:^(BOOL finished) {
        if (finished) {
            [toastView removeFromSuperview];
            !completion ? :completion();
        }
    }];
}

- (void)setUpFrameWithoffsetY:(CGFloat)offsetY {
    CGFloat bottomAndTopSpace = 20;
    CGFloat topSpace = 60;
    CGFloat bottomSpace = 60;
    CGFloat maxShowHeight = (CGRectGetHeight(self.superview.bounds) - bottomAndTopSpace * 2);
    
    if (LGNoticePopuViewPositionTop == self.positionType) {
        maxShowHeight -= topSpace;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.superview);
            make.top.mas_equalTo(self.superview).offset(topSpace + offsetY);
            make.width.mas_equalTo(content_w);
            make.height.mas_lessThanOrEqualTo(maxShowHeight);
        }];
    }
    else if (LGNoticePopuViewPositionBottom == self.positionType) {
        maxShowHeight -= bottomSpace;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.superview);
            make.bottom.mas_equalTo(self.superview).offset(-bottomSpace + offsetY);
            make.width.mas_equalTo(content_w);
            make.height.mas_lessThanOrEqualTo(maxShowHeight);
        }];
    }
    else if (LGNoticePopuViewPositionCustom == self.positionType) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.superview);
            make.top.mas_equalTo(self.superview).offset(offsetY);
            make.width.mas_equalTo(content_w);
            make.height.mas_lessThanOrEqualTo(maxShowHeight);
        }];
    }
    else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.superview);
            make.centerY.mas_equalTo(self.superview).offset(offsetY);
            make.width.mas_equalTo(content_w);
            make.height.mas_lessThanOrEqualTo(maxShowHeight);
        }];
    }
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.textColor = [UIColor whiteColor];
        if (@available(iOS 8.2, *)) {
            _contentLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
        } else {
            _contentLabel.font = [UIFont systemFontOfSize:15];
        }
    }
    return _contentLabel;
}

- (LGLineProcessView *)processView {
    if (!_processView) {
        _processView = [[LGLineProcessView alloc] initWithFrame:CGRectMake(30, 35, content_w - 30 * 2, 6)];
    }
    return _processView;
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
    gl.colors = @[(__bridge id)[UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:0.95].CGColor,(__bridge id)[UIColor colorWithRed:42/255.0 green:42/255.0 blue:42/255.0 alpha:0.95].CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    [self.layer insertSublayer:gl below:self.contentLabel.layer];
    self.gl = gl;
}

- (void)setDefaultColor:(UIColor *)defaultColor {
    _defaultColor = defaultColor;
    self.processView.defaultColor = defaultColor;
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    self.processView.fillColor = fillColor;
}

- (void)setProcessValue:(CGFloat)processValue {
    _processValue = processValue;
    self.processView.processValue = processValue;
    if (processValue >= 1 && self.automaticDismiss) {
        [self dismissCompletion:nil];
    }
}

@end



@implementation LGLineProcessView {
    CAShapeLayer *_layer;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    UIBezierPath * bezierPath = [[UIBezierPath alloc]init];
    [bezierPath moveToPoint:CGPointMake(0, height / 2.0)];
    [bezierPath addLineToPoint:CGPointMake(width, height / 2.0)];
    _layer = [CAShapeLayer layer];
    _layer.path = bezierPath.CGPath;
    _layer.lineWidth = height;
    _layer.lineCap = @"round";
    _layer.fillColor = [UIColor clearColor].CGColor;
    _layer.strokeColor = [UIColor colorWithRed:207 / 255.0 green:169 / 255.0 blue:114 / 255.0 alpha:1].CGColor;
    _layer.strokeEnd = 0;
    [self.layer addSublayer:_layer];
    
    self.layer.cornerRadius = height / 2.0;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor blackColor];
}

-(void)setProcessValue:(CGFloat)processValue {
    _processValue = processValue;
    _layer.strokeEnd = processValue;
}

-(void)setFillColor:(UIColor*)fillColor{
    _fillColor = fillColor;
    _layer.strokeColor = _fillColor.CGColor;
}

-(void)setDefaultColor:(UIColor*)defaultColor{
    _defaultColor = defaultColor;
    self.backgroundColor = defaultColor;
}

@end
