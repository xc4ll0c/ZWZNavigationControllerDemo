//
//  RootViewController.m
//  ZWZNavigationControllerDemo
//
//  Created by wenZheng Zhang on 16/1/2.
//  Copyright © 2016年 ZWZ. All rights reserved.
//

#import "RootViewController.h"
#import "ZWZNavigationController.h"

@interface RootViewController ()
@property (nonatomic) UIButton *showCodeVersionButton;
@property (nonatomic) UIButton *showStoryboardVersionButton;
@end

@implementation RootViewController

- (void)loadView
{
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    self.view = [[UIView alloc] initWithFrame:screenBounds];
    
    [self.view addSubview:self.showCodeVersionButton];
    [self.view addSubview:self.showStoryboardVersionButton];
    
    
    NSArray *buttons = @[self.showCodeVersionButton, self.showStoryboardVersionButton];
    CGFloat flag = -1;
    for (UIButton *button in buttons) {
        
        [self.view addConstraints:@[
                                    [NSLayoutConstraint constraintWithItem:button
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1
                                                                  constant:0],
                                    
                                    [NSLayoutConstraint constraintWithItem:button
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1
                                                                  constant:0],
                                    
                                    [NSLayoutConstraint constraintWithItem:button
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1
                                                                  constant:flag * 26]
                                    ]];
        [button addConstraint: [NSLayoutConstraint constraintWithItem:button
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1
                                                             constant:44]];
        flag *= -1;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - event handling
- (void)didTapButton:(id)sender
{
    if (sender == self.showStoryboardVersionButton) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *nvc = [storyBoard instantiateViewControllerWithIdentifier:@"ZWZNavigationController"];
        [self presentViewController:nvc animated:YES completion:nil];
    } else {
        ZWZNavigationController *nvc = [[ZWZNavigationController alloc] initWithNavigationBarClass:nil toolbarClass:nil];
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc  = [storyBoard instantiateViewControllerWithIdentifier:@"TableViewController"];
        [nvc setViewControllers:@[vc]];
        [self presentViewController:nvc animated:YES completion:nil];
    }
}

#pragma mark - getter
- (UIButton *)showCodeVersionButton
{
    if (_showCodeVersionButton == nil) {
        _showCodeVersionButton = [[UIButton alloc] init];
        [_showCodeVersionButton setTitle:@"codeVersion" forState:UIControlStateNormal];
        [_showCodeVersionButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _showCodeVersionButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_showCodeVersionButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showCodeVersionButton;
}

- (UIButton *)showStoryboardVersionButton
{
    if (_showStoryboardVersionButton == nil) {
        _showStoryboardVersionButton = [[UIButton alloc] init];
        [_showStoryboardVersionButton setTitle:@"storyBoardVersion" forState:UIControlStateNormal];
        [_showStoryboardVersionButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _showStoryboardVersionButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_showStoryboardVersionButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showStoryboardVersionButton;
}
@end
