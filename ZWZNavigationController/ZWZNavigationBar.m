//
//  ZWZNavigationBar.m
//  ZWZNavigationControllerDemo
//
//  Created by wenZheng Zhang on 15/11/30.
//  Copyright © 2015年 ZWZ. All rights reserved.
//

#import "ZWZNavigationBar.h"

@interface ZWZNavigationBar ()
@property (nonatomic) UIView *colorView;
@property (nonatomic) UIColor *currentColor;
@end

@implementation ZWZNavigationBar

- (UIView *)colorView
{
    if (_colorView == nil) {
        _colorView = [[UIView alloc] init];
        _colorView.backgroundColor = [UIColor clearColor];
        _colorView.frame = [self colorLayerFrame];
        _colorView.userInteractionEnabled = NO;
        
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
    if (duration > 0) {
        if (usingSpring) {
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:options animations:^{
                self.colorView.backgroundColor = color;
            } completion:^(BOOL finished) {
                
            }];
        } else {
            [UIView animateWithDuration:duration delay:0 options:options animations:^{
                self.colorView.backgroundColor = color;
            } completion:^(BOOL finished) {
                
            }];
        }
    } else self.colorView.backgroundColor = color;

    self.currentColor = color;
}

- (void)layoutSubviews
{
    [super layoutSubviews];    
    self.colorView.frame = [self colorLayerFrame];
    [self insertSubview:self.colorView atIndex:1];
}

- (CGRect)colorLayerFrame
{
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    return CGRectMake(0, 0 - statusBarHeight, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + statusBarHeight);
}

@end
