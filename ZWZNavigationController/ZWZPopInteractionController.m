//
//  ZWZPopInteractionController.m
//  ZWZNavigationControllerDemo
//
//  Created by wenZheng Zhang on 15/11/30.
//  Copyright © 2015年 ZWZ. All rights reserved.
//

#import "ZWZPopInteractionController.h"

#pragma mark - GestureRecognizerItem
@interface ZWZGestureRecognizerItem : NSObject
@property (nonatomic, weak) UIGestureRecognizer *gestureRecognizer;
@end

@implementation ZWZGestureRecognizerItem
@end

#pragma mark - ZWZPopInteractionController
@interface ZWZPopInteractionController () <UIGestureRecognizerDelegate>
@property (nonatomic) UINavigationController *navigationController;
@property (nonatomic) BOOL shouldCompleteTransition;
@property (nonatomic) NSMutableArray *gestureRecognizerItems;
@end

@implementation ZWZPopInteractionController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.completionCurve = UIViewAnimationOptionCurveEaseOut;
        _gestureRecognizerItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)writeToViewController:(UIViewController *)viewController
{
    _navigationController = viewController.navigationController;
    [self prepareGestureRecognizerInView:viewController.view];
}

- (void)prepareGestureRecognizerInView:(UIView *)view
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:pan];
    pan.delegate = self;
    
    ZWZGestureRecognizerItem *item = [[ZWZGestureRecognizerItem alloc] init];
    item.gestureRecognizer = pan;
    [self.gestureRecognizerItems addObject:item];
}


- (CGFloat)completionSpeed
{
    return 2;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGPoint location = [gestureRecognizer
                        locationInView:gestureRecognizer.view.superview];
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            self.interactionInProgress = YES;
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            
            CGPoint velocity = [gestureRecognizer velocityInView:gestureRecognizer.view];
            CGFloat fraction = (location.x / screenWidth);
            fraction = fminf(fmax(fraction, 0), 1.0);
            _shouldCompleteTransition = fraction > 0.5 || velocity.x > 30;
            
            [self updateInteractiveTransition:fraction];
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            self.interactionInProgress = NO;
            
            if (!self.shouldCompleteTransition || UIGestureRecognizerStateCancelled == gestureRecognizer.state) {
                [self cancelInteractiveTransition];
            } else [self finishInteractiveTransition];
            
            break;
        }
            
        default:
            break;
    }
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint location = [gestureRecognizer
                           locationInView:gestureRecognizer.view];
    
    CGPoint velocity = [gestureRecognizer velocityInView:gestureRecognizer.view];
    if (location.x <= 30 && velocity.x > 0 && fabs(velocity.x) > fabs(velocity.y)) {
        return YES;
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([self containsGestureRecognizer:gestureRecognizer]) return NO;
    else return YES;

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([self containsGestureRecognizer:gestureRecognizer]) return YES;
    else return NO;
}

#pragma mark - private method
- (BOOL)containsGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    for (NSInteger i = 0; i < self.gestureRecognizerItems.count;) {
        ZWZGestureRecognizerItem *item = self.gestureRecognizerItems[i];
        if (item.gestureRecognizer == nil) [self.gestureRecognizerItems removeObjectAtIndex:i];
        else if (gestureRecognizer == item.gestureRecognizer) {
            return YES;
        } else i++;
    }
    return NO;
}


@end
