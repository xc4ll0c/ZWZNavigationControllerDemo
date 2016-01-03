//
//  CollectionViewController.m
//  ZWZNavigationControllerDemo
//
//  Created by wenZheng Zhang on 16/1/2.
//  Copyright © 2016年 ZWZ. All rights reserved.
//

#import "CollectionViewController.h"
#import "ZWZNavigationController.h"
#import "CollectionViewCell.h"

@interface CollectionViewController () <UICollectionViewDelegateFlowLayout>
@property (nonatomic) NSArray *images;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.navigationItem.title = @"CollectionViewController";
    
    [(ZWZNavigationController *)self.navigationController setNavigationBarBackgroudColor:[UIColor colorWithRed:arc4random_uniform(255)/255.0
                                                                                                         green:arc4random_uniform(255)/255.0
                                                                                                          blue:arc4random_uniform(255)/255.0
                                                                                                         alpha:1]
                                                                       forViewController:self];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.pitureImageVIew.image = self.images[indexPath.item];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), CGRectGetHeight(collectionView.bounds));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc  = [storyBoard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter
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
