//
//  ViewController.m
//  ZWZNavigationControllerDemo
//
//  Created by wenZheng Zhang on 16/1/2.
//  Copyright © 2016年 ZWZ. All rights reserved.
//

#import "ViewController.h"
#import "ZWZNavigationController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ViewController";
    
    if (arc4random_uniform(2) == 0) {
        [(ZWZNavigationController *)self.navigationController setNavigationBarBackgroudColor:[UIColor clearColor]
                                                                           forViewController:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)showTableViewController:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc  = [storyBoard instantiateViewControllerWithIdentifier:@"TableViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)toRootViewController:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
