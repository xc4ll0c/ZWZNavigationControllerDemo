//
//  ZWZNavigationBar.h
//  ZWZNavigationControllerDemo
//
//  Created by wenZheng Zhang on 15/11/30.
//  Copyright © 2015年 ZWZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ZWZNavigationBarProtocol <NSObject>
@required
- (void)setBarBackgroundColor:(UIColor *)color animationDuration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options usingSpring:(BOOL)usingSpring;
@end
