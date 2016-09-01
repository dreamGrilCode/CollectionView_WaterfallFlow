//
//  YANCollectionViewLayout.h
//  CollectionView
//
//  Created by yan on 16/8/30.
//  Copyright © 2016年 yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YANCollectionViewLayout;

@protocol YANCollectionViewLayoutDelegate <NSObject>

@required
- (CGFloat)collectionViewLayout:(YANCollectionViewLayout *)layout heightForItemAtIndext:(NSInteger)index itemWidth:(CGFloat)itemWidth;
@optional
/**
 *  设置列数
 *
 */
- (CGFloat)columnCountInCollectionFlowLayout:(YANCollectionViewLayout *)layout;
/**
 *  设置列间距
 *
 */
- (CGFloat)columnMarginInCollectionFlowLayout:(YANCollectionViewLayout *)layout;
/**
 *  设置行间距
 *
 */
- (CGFloat)rowMarginInCollectionFlowLayout:(YANCollectionViewLayout *)layout;
/**
 *  设置边缘间距
 */
- (UIEdgeInsets)edgeInsetsInCollectionFlowLayout:(YANCollectionViewLayout *)layout;

@end

@interface YANCollectionViewLayout : UICollectionViewLayout

@property(nonatomic,weak)id<YANCollectionViewLayoutDelegate> delegate_;

@end
