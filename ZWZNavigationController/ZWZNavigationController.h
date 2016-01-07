//
//  ZWZNavigationController.h
//  ZWZNavigationControllerDemo
//
//  Created by wenZheng Zhang on 15/11/30.
//  Copyright © 2015年 ZWZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWZNavigationBar.h"
#import "ZWZNavigationControllerProtocol.h"


@class ZWZNavigationController;

@interface ZWZNavigationController : UINavigationController <ZWZNavigationControllerProtocol>
@property (nonatomic, readonly) ZWZNavigationBar *zwzNavigationBar;
@property (nonatomic) BOOL shouldReuseCurrrentColor;
@end
