//
//  ZWZNavigationBar.m
//  ZWZNavigationControllerDemo
//
//  Created by wenZheng Zhang on 15/11/30.
//  Copyright © 2015年 ZWZ. All rights reserved.
//

#import "ZWZNavigationBar.h"

@interface ZWZNavigationBar ()

@property (nonatomic) UIView *visualEffectView;
@property (nonatomic) UIView *colorView;
@property (nonatomic) UIColor *currentColor;

@property (nonatomic) UIImage *zwzShadowImage;
@property (nonatomic) UIImage *zwzBackgroundImage;
@end

@implementation ZWZNavigationBar

- (UIView *)colorView
{
    if (_colorView == nil) {
        
        _colorView = [[UIView alloc] init];
        _colorView.backgroundColor = [UIColor clearColor];
        _colorView.frame = [self colorLayerFrame];
        _colorView.userInteractionEnabled = NO;
        
        if ([UIVisualEffectView class]) {
            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            [_colorView addSubview:_visualEffectView];
            _visualEffectView.frame = _colorView.bounds;
        }
        
        [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:[[UIImage alloc] init]];
        self.backgroundColor = [UIColor clearColor];
        
        [self insertSubview:_colorView atIndex:1];
    }
    return _colorView;
}

- (void)setBarBackgroundColor:(UIColor *)color animationDuration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options usingSpring:(BOOL)usingSpring
{
    if (color == nil) return;
    
    UIColor *nColor = color;
    CGFloat alpha   = 1;
    
    if (![nColor isEqual:[UIColor clearColor]] && self.visualEffectView != nil) {
        CGFloat red,green,blue,alpha;
        [color getRed:&red green:&green blue:&blue alpha:&alpha];
        nColor = [UIColor colorWithRed:red green:green blue:blue alpha:0.65];
    } else if (self.visualEffectView != nil) {
        alpha = 0;
    }
    
    void (^animationBlock)(void) = ^{
        if (self.visualEffectView != nil) self.visualEffectView.backgroundColor = nColor;
        else self.colorView.backgroundColor = nColor;
        self.colorView.alpha = 1;
    };
 
    if (duration > 0) {
        if (usingSpring) {
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:options animations:animationBlock
                             completion:^(BOOL finished) {
                
                             }];
        } else {
            [UIView animateWithDuration:duration delay:0 options:options animations:animationBlock
                             completion:^(BOOL finished) {
                
                             }];
        }
    } else {
        animationBlock();
    }
    self.currentColor = nColor;
}


- (void)layoutSubviews
{
    [super layoutSubviews];    
    self.colorView.frame = [self colorLayerFrame];
    if (self.visualEffectView != nil) self.visualEffectView.frame = self.colorView.bounds;
    [self insertSubview:self.colorView atIndex:1];
}

- (CGRect)colorLayerFrame
{
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    return CGRectMake(0, 0 - statusBarHeight, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + statusBarHeight);
}

@end