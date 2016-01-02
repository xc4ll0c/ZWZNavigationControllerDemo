//
//  ZWZPopAnimationController.m
//  ZWZNavigationControllerDemo
//
//  Created by wenZheng Zhang on 15/11/30.
//  Copyright © 2015年 ZWZ. All rights reserved.
//

#import "ZWZPopAnimationController.h"

@interface ZWZPopAnimationController ()
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) UIView *shadowView;
@end

@implementation ZWZPopAnimationController

- (NSTimeInterval)duration
{
    if (_duration != 0.50) {
        _duration = 0.50;
    }
    return _duration;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController =[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGFloat offset = -120;
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    UIView *containerView = [transitionContext containerView];
    
    CGRect finalFrame1 = [transitionContext finalFrameForViewController:toViewController];
    CGRect finalFrame2 = finalFrame1;
    if (self.isReverse) {
        finalFrame1 = CGRectOffset(finalFrame1, CGRectGetWidth(screenBounds), 0);
        toViewController.view.frame = CGRectOffset(finalFrame2, offset, 0);
        [containerView addSubview:toViewController.view];
        [containerView addSubview:fromViewController.view];
    } else {
        finalFrame2 = CGRectOffset(fromViewController.view.frame, offset, 0);
        toViewController.view.frame = CGRectOffset(finalFrame1, CGRectGetWidth(screenBounds), 0);
        [containerView addSubview:fromViewController.view];
        [containerView addSubview:toViewController.view];
    }

    NSTimeInterval duration = self.duration;
    UIViewAnimationOptions options = [transitionContext isInteractive] ? UIViewAnimationOptionCurveLinear : UIViewAnimationOptionCurveEaseOut;
    if ([self.navigationController conformsToProtocol:@protocol(ZWZNavigationControllerProtocol)]) {
        UIColor *color = [self.navigationController navigationBarBackgroudColorForViewController:toViewController];
        if (color != nil) [self.navigationController.zwzNavigationBar setBarBackgroundColor:color animationDuration:duration options:options usingSpring:[transitionContext isInteractive]];
    }
    
    void (^animations)(void) = ^{
        if (self.isReverse) {
            fromViewController.view.frame = finalFrame1;
            toViewController.view.frame = finalFrame2;
        } else {
            toViewController.view.frame = finalFrame1;
            fromViewController.view.frame = finalFrame2;
        }
    };
    
    void (^completion)(BOOL finished) = ^(BOOL finished) {
        
        if (!self.isReverse) {
            CGRect frame = CGRectMake(0, 0, CGRectGetWidth(finalFrame2), CGRectGetHeight(finalFrame2));
            fromViewController.view.frame = frame;
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    };
    
    if ([transitionContext isInteractive]) {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:animations completion:completion];
    } else {
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:options animations:animations completion:completion];
    }
}
@end
