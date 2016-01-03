//
//  ZWZNavigationControllerProtocol.h
//  ZWZNavigationControllerDemo
//
//  Created by wenZheng Zhang on 16/1/2.
//  Copyright © 2016年 ZWZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWZNavigationBar.h"

@protocol ZWZNavigationControllerProtocol <NSObject>
@required
@property (nonatomic, readonly) ZWZNavigationBar *zwzNavigationBar;

/*!
 *  Set navigation bar backgroud color for a viewController
 *  The object that implement ZWZNavigationControllerProtocol should hold a weak referrence to the viewController
 *  The best place to call this method is the viewDidLoad method
 *
 *  @param color          The navigation bar backgroudColor for a viewController
 *  @param viewController The viewController which the navigation bar backgroudColor to be set
 */
- (void)setNavigationBarBackgroudColor:(UIColor *)color forViewController:(UIViewController *)viewController;

/*!
 *  Get navigation bar backgroudColor for a specific viewController
 *
 *  @param viewController a viewController
 *
 *  @return return the navigation bar backgroudColor for the viewController if it exits, return nil if not
 */
- (UIColor *)navigationBarBackgroudColorForViewController:(UIViewController *)viewController;
@end
