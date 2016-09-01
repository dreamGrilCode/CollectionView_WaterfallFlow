//
//  YANCollectionViewLayout.m
//  CollectionView
//
//  Created by yan on 16/8/30.
//  Copyright © 2016年 yan. All rights reserved.
//

#import "YANCollectionViewLayout.h"

/**
 *  默认的列数
 */
static const NSInteger defaultColumnCount = 3;
/**
 *  默认的列间距
 */
static const CGFloat defaultColumnMargin = 10;
/**
 *  默认的行间距
 */
static const CGFloat defaultRowMargin = 10;
/**
 *  默认的边缘间距
 */
static const UIEdgeInsets defaultEdgeInsets = {10,10,10,10};

@interface YANCollectionViewLayout ()

/**
 *  存放cell的布局属性
 */
@property(nonatomic, strong)NSMutableArray *cellArray;
/**
 *  存放列的高度
 */
@property(nonatomic, strong)NSMutableArray *columnHeights;
/**
 *  cell内容的高度
 */
@property(nonatomic, assign)CGFloat contentHeight;

- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (CGFloat)columnCount;
- (UIEdgeInsets)edgeInsets;
@end

@implementation YANCollectionViewLayout

- (CGFloat)rowMargin{ // 没有设置就使用默认值

    if ([self.delegate_ respondsToSelector:@selector(rowMarginInCollectionFlowLayout:)]) {
        return [self.delegate_ rowMarginInCollectionFlowLayout:self];
    }else{
    
        return  defaultRowMargin;
    }
}
- (CGFloat)columnMargin{

    if ([self.delegate_ respondsToSelector:@selector(columnMarginInCollectionFlowLayout:)]) {
        return [self.delegate_ columnMarginInCollectionFlowLayout:self];
    }else{
    
        return defaultColumnMargin;
    }
}
- (CGFloat)columnCount{

    if ([self.delegate_ respondsToSelector:@selector(columnCountInCollectionFlowLayout:)]) {
        
        return [self.delegate_ columnCountInCollectionFlowLayout:self];
    }else{
    
        return defaultColumnCount;
    }
}
- (UIEdgeInsets)edgeInsets{

    if ([self.delegate_ respondsToSelector:@selector(edgeInsetsInCollectionFlowLayout:)]) {
        
        return [self.delegate_ edgeInsetsInCollectionFlowLayout:self];
        
    }else{
    
        return defaultEdgeInsets;
    }
}
- (NSMutableArray *)cellArray{

    if (!_cellArray) {
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
}

- (NSMutableArray *)columnHeights{

    if (!_columnHeights) {
        
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (void)prepareLayout{

    [super prepareLayout];
    
    self.contentHeight = 0;
    
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i ++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    [self.cellArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0]; // 第一组有多少个cell
    for (NSInteger i = 0; i < count; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *atts = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.cellArray addObject:atts];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{

    return self.cellArray;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1)* self.columnMargin)/self.columnCount;
    
    CGFloat h = [self.delegate_ collectionViewLayout:self heightForItemAtIndext:indexPath.item itemWidth:w];
    
    NSInteger destColumn = 0;
    CGFloat minColumnHight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i ++) {
        
        CGFloat columnHeigt = [self.columnHeights[i] doubleValue];
        
        if (minColumnHight > columnHeigt) {
            
            minColumnHight = columnHeigt;
            destColumn = i;
        }
    }
    
    CGFloat x = self.edgeInsets.left + destColumn *(w + self.columnMargin);
    CGFloat y = minColumnHight;
    if (y != self.edgeInsets.top) {
        
        y += self.rowMargin;
    }
    attrs.frame = CGRectMake(x, y, w, h);
    // 记录每一列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    return attrs;
}
- (CGSize)collectionViewContentSize{

    //collectionView的滚动大小
    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}


@end
