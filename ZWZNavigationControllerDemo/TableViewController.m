//
//  TableViewController.m
//  ZWZNavigationControllerDemo
//
//  Created by wenZheng Zhang on 16/1/2.
//  Copyright © 2016年 ZWZ. All rights reserved.
//

#import "TableViewController.h"
#import "CollectionViewController.h"
#import "ZWZNavigationController.h"
#import "TableViewCell.h"

@interface TableViewController ()
@property (nonatomic) NSArray *images;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 200;
    
    self.navigationItem.title = @"TableViewController";
    
    if ([self.navigationController.viewControllers firstObject] == self) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"dismiss" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
    }
    
    [(ZWZNavigationController *)self.navigationController setNavigationBarBackgroudColor:[UIColor colorWithRed:arc4random_uniform(255)/255.0
                                                                                                         green:arc4random_uniform(255)/255.0
                                                                                                          blue:arc4random_uniform(255)/255.0
                                                                                                         alpha:1]
                                                                       forViewController:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma makr - event handling
- (void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.images.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.pitureImageView.image = self.images[indexPath.row];
    return cell;
}

#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CollectionViewController *cvc  = [storyBoard instantiateViewControllerWithIdentifier:@"CollectionViewController"];

    [self.navigationController pushViewController:cvc animated:YES];
}

#pragma mark - getter and setter
- (NSArray *)images
{
    if (_images == nil) {
        NSMutableArray *images = [[NSMutableArray alloc] init];
        NSString *baseName = @"FICDDemoImage";
        for (NSInteger i = 0; i < 11 * 4; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%@%03ld", baseName, (long)(i % 11)];
            UIImage *image = [UIImage imageNamed:imageName];
            if (image == nil) break;
            else [images addObject:image];
        }
        _images = [images copy];
    }
    return _images;
}
@end
