//
//  CollectionViewCell.m
//  ZWZNavigationControllerDemo
//
//  Created by wenZheng Zhang on 16/1/3.
//  Copyright © 2016年 ZWZ. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (UIImageView *)pitureImageVIew
{
    if (_pitureImageVIew == nil) {
        _pitureImageVIew = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _pitureImageVIew.contentMode = UIViewContentModeScaleAspectFill;
        _pitureImageVIew.clipsToBounds = YES;
        [self.contentView addSubview:_pitureImageVIew];
    }
    return _pitureImageVIew;
}

@end
