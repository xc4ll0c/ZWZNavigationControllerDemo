//
//  ZWZNavigationController.m
//  ZWZNavigationControllerDemo
//
//  Created by wenZheng Zhang on 15/11/30.
//  Copyright © 2015年 ZWZ. All rights reserved.
//

#import "ZWZNavigationController.h"
#import "ZWZPopAnimationController.h"
#import "ZWZPopInteractionController.h"

@interface ZWZNavigationController () <UINavigationControllerDelegate>
@property (nonatomic) CALayer *colorLayer;
@property (nonatomic) ZWZPopAnimationController *popAnimationController;
@property (nonatomic) ZWZPopInteractionController *popInteractionController;
@property (nonatomic) BOOL hasShowRootViewController;
@property (nonatomic) NSMapTable *mapTable;
@property (nonatomic, weak) id <UINavigationControllerDelegate> otherDelegate;
@end

@implementation ZWZNavigationController

- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass
{
    self = [super initWithNavigationBarClass:[ZWZNavigationBar class] toolbarClass:toolbarClass];
    if (self) {
        
    }
    return self;
}

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

- (void)dealloc
{
    NSLog(@"bye bye %@", NSStringFromClass([self class]));
}

- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    if (delegate != self) {
        self.otherDelegate = delegate;
    }
    [super setDelegate:self];
}

#pragma mark - ZWZNavigationControllerProtocol
- (void)setNavigationBarBackgroudColor:(UIColor *)color forViewController:(UIViewController *)viewController
{
    if (color == nil || viewController == nil) return;
    [self.mapTable setObject:color forKey:viewController];
}

- (UIColor *)navigationBarBackgroudColorForViewController:(UIViewController *)viewController
{
    return [self.mapTable objectForKey:viewController];
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    self.popAnimationController.reverse = operation == UINavigationControllerOperationPop;
    if (operation == UINavigationControllerOperationPush) {
        [self.popInteractionController writeToViewController:toVC];
    }
    
    return self.popAnimationController;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.popInteractionController.interactionInProgress ? self.popInteractionController : nil;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.otherDelegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
        [self.otherDelegate navigationController:self willShowViewController:viewController animated:animated];
    }
    
    if (!self.hasShowRootViewController && [viewController isEqual:[self.viewControllers firstObject]]) {
        self.hasShowRootViewController = YES;
        
        UIColor *color = [self navigationBarBackgroudColorForViewController:viewController];
        if (color == nil) {
            color = [[UINavigationBar appearance] backgroundColor];
            if (color == nil) color = [UIColor whiteColor];
            [self setNavigationBarBackgroudColor:color forViewController:viewController];
        }
        if (color != nil) [self.zwzNavigationBar setBarBackgroundColor:color animationDuration:0 options:0 usingSpring:NO];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.otherDelegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
        [self.otherDelegate navigationController:self didShowViewController:viewController animated:animated];
    }
}

- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController
{
    if ([self.otherDelegate respondsToSelector:@selector(navigationControllerSupportedInterfaceOrientations:)]) {
        return [self.otherDelegate navigationControllerSupportedInterfaceOrientations:navigationController];
    } else {
        UIInterfaceOrientationMask mask = self.visibleViewController.supportedInterfaceOrientations;
        return mask;
    }
}

- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController
{
    if ([self.otherDelegate respondsToSelector:@selector(navigationControllerPreferredInterfaceOrientationForPresentation:)]) {
        return [self.otherDelegate navigationControllerPreferredInterfaceOrientationForPresentation:navigationController];
    } else {
        return self.visibleViewController.preferredInterfaceOrientationForPresentation;
    }
}

#pragma mark - getter and setter
- (ZWZPopAnimationController *)popAnimationController
{
    if (_popAnimationController == nil) {
        _popAnimationController = [[ZWZPopAnimationController alloc] init];
        _popAnimationController.navigationController = self;
    }
    return _popAnimationController;
}

- (ZWZPopInteractionController *)popInteractionController
{
    if (_popInteractionController == nil) {
        _popInteractionController = [[ZWZPopInteractionController alloc] init];
    }
    return _popInteractionController;
}

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
