//
//  YANShop.m
//  CollectionView
//
//  Created by yan on 16/8/30.
//  Copyright © 2016年 yan. All rights reserved.
//

#import "YANShop.h"

@implementation YANShop

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        
        self.h = [dict[@"h"] doubleValue];
        self.w = [dict[@"w"] doubleValue];
        self.img = dict[@"img"];
        self.price = dict[@"price"];
    }
    return self;
}

@end
