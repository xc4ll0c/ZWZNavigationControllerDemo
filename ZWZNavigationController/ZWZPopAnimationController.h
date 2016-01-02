//
//  ZWZPopAnimationController.h
//  ZWZNavigationControllerDemo
//
//  Created by wenZheng Zhang on 15/11/30.
//  Copyright © 2015年 ZWZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZWZNavigationControllerProtocol.h"
@import UIKit;

@interface ZWZPopAnimationController : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic) id <ZWZNavigationControllerProtocol> navigationController;
@property (nonatomic, getter=isReverse) BOOL reverse;
@end
