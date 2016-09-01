//
//  YANShop.h
//  CollectionView
//
//  Created by yan on 16/8/30.
//  Copyright © 2016年 yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YANShop : NSObject

@property(nonatomic,assign) CGFloat h;
@property(nonatomic,assign) CGFloat w;
@property(nonatomic,copy) NSString *img;
@property(nonatomic,copy) NSString *price;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
