//
//  ZWZNavigationController.m
//  ZWZNavigationControllerDemo
//
//  Created by wenZheng Zhang on 15/11/30.
//  Copyright © 2015年 ZWZ. All rights reserved.
//

#import "ZWZNavigationController.h"

@interface ZWZNavigationController ()
@property (nonatomic) NSMapTable *mapTable;
@property (nonatomic) id <UINavigationControllerDelegate> otherDelegate;
@end

@implementation ZWZNavigationController
#pragma mark - life cycle
- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass
{
    self = [super initWithNavigationBarClass:[ZWZNavigationBar class] toolbarClass:toolbarClass];
    if (self) {
        
    }
    return self;
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

#pragma mark - ZWZNavigationControllerProtocol
- (void)setNavigationBarBackgroudColor:(UIColor *)color forViewController:(UIViewController *)viewController
{
    if (color == nil || viewController == nil) return;
    [self.mapTable setObject:color forKey:viewController];
    [self.zwzNavigationBar setBarBackgroundColor:color animationDuration:0 options:0 usingSpring:NO];
}

- (UIColor *)navigationBarBackgroudColorForViewController:(UIViewController *)viewController
{
    return [self.mapTable objectForKey:viewController];
}

#pragma makr - override methods
- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    NSArray<UIViewController *> *vcs = [super popToRootViewControllerAnimated:animated];
    [self animateAlongsideTransitionAnimation];
    return vcs;
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray<UIViewController *> *vcs = [super popToViewController:viewController animated:animated];
    [self animateAlongsideTransitionAnimation];
    return vcs;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *vc = [super popViewControllerAnimated:animated];
    [self animateAlongsideTransitionAnimation];
    return vc;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    [self animateAlongsideTransitionAnimation];
}

#pragma mark - private method
- (void)animateAlongsideTransitionAnimation
{
    [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        UIViewController *toVc = [context viewControllerForKey:UITransitionContextToViewControllerKey];
        UIColor *color = [self navigationBarBackgroudColorForViewController:toVc];
        if (color == nil) {
            color = [[UINavigationBar appearance] backgroundColor];
            if (color == nil) color = self.zwzNavigationBar.defaultNavigationBarBackgroundColor;
            [self setNavigationBarBackgroudColor:color forViewController:toVc];
        }
        if (color != nil)
            [self.zwzNavigationBar setBarBackgroundColor:color
                                       animationDuration:[context transitionDuration]
                                                 options:UIViewAnimationOptionCurveEaseInOut
                                             usingSpring:NO];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}


#pragma mark - getter and setter
- (ZWZNavigationBar *)zwzNavigationBar
{
    return (ZWZNavigationBar *)self.navigationBar;
}

- (NSMapTable *)mapTable
{
    if (_mapTable == nil) {
        _mapTable = [NSMapTable weakToStrongObjectsMapTable];
    }
    return _mapTable;
}
@end
