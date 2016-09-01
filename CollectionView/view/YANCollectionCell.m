//
//  YANCollectionCell.m
//  CollectionView
//
//  Created by yan on 16/8/30.
//  Copyright © 2016年 yan. All rights reserved.
//

#import "YANCollectionCell.h"
#import "YANShop.h"
#import "UIImageView+WebCache.h"


@interface YANCollectionCell()

@property(nonatomic ,weak)UIImageView *imageView;
@property(nonatomic, weak)UILabel *lable;

@end

@implementation YANCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:imageView];
        imageView.layer.masksToBounds = YES;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 10;
        self.imageView = imageView;
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 20)];
        lable.font = [UIFont systemFontOfSize:15];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor redColor];
        [self addSubview:lable];
        self.lable = lable;
        
    }
    return self;
}
- (void)layoutSubviews{

    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    self.lable.frame = CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 20);
}
- (void)setShop:(YANShop *)shop{

    _shop = shop;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] completed:nil];
    self.lable.text = shop.price;
}

@end
