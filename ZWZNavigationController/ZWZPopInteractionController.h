//
//  ZWZPopInteractionController.h
//  ZWZNavigationControllerDemo
//
//  Created by wenZheng Zhang on 15/11/30.
//  Copyright © 2015年 ZWZ. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface ZWZPopInteractionController : UIPercentDrivenInteractiveTransition
@property (nonatomic, assign) BOOL interactionInProgress;

- (void)writeToViewController:(UIViewController *)viewController;
@end
