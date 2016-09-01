//
//  ViewController.m
//  CollectionView
//
//  Created by yan on 16/8/16.
//  Copyright © 2016年 yan. All rights reserved.
//

#import "ViewController.h"
#import "YANCollectionViewLayout.h"
#import "YANShop.h"
#import "YANCollectionCell.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,YANCollectionViewLayoutDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSMutableArray *shopInfo;
@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation ViewController
- (NSMutableArray *)shopInfo{

    if (!_shopInfo) {
        _shopInfo = [NSMutableArray array];
        
    }
    return _shopInfo;
}
static NSString *ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    YANCollectionViewLayout *layout = [[YANCollectionViewLayout alloc] init];
    layout.delegate_ = self;
    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.minimumLineSpacing = 10; // 行间距
//    flowLayout.minimumInteritemSpacing = 30; // 列间距
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;// 水平布局
//    flowLayout.itemSize = CGSizeMake(100, 100);
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collection.dataSource = self;
    collection.delegate = self;
    collection.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    collection.backgroundColor = [UIColor grayColor];
    [self.view addSubview:collection];
    self.collectionView = collection;
 
    
//    // 长按移动
//    UILongPressGestureRecognizer *longGestureRecog = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGestureRecog:)];
//    [collection addGestureRecognizer:longGestureRecog];
    
    [collection registerClass:[YANCollectionCell class] forCellWithReuseIdentifier:ID];
//    [collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
//    [collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"footer"];
    
    [self addShopShow];
}
//- (void)longGestureRecog:(UILongPressGestureRecognizer *)longGesture{
//
//    switch (longGesture.state) {
//        case UIGestureRecognizerStateBegan:{
//            
//            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
//            if (indexPath == nil) {
//                break;
//            }
//            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
//        }
//            break;
//        case UIGestureRecognizerStateChanged:{
//            
//            [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
//        
//        }
//            break;
//
//        case UIGestureRecognizerStateEnded:
//            [self.collectionView endInteractiveMovement];
//            break;
//            
//        default:
//            [self.collectionView cancelInteractiveMovement];
//            break;
//    }
//}
- (void)addShopShow{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *shops = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shop.plist" ofType:nil]];
        for (NSDictionary *dict in shops) {
            YANShop *shopInfo = [[YANShop alloc] initWithDict:dict];
            [self.shopInfo addObject:shopInfo];
        }
        [self.collectionView reloadData];
    });
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.shopInfo.count;
}
#pragma mark - UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YANCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    cell.shop = self.shopInfo[indexPath.item];
    return cell;
    
}

//- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    return YES;
//}

//- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
//    
//    [self.shopInfo exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
//    
//}

//- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    return YES;
//}
//- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
//
//    return YES;
//}
//- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
//
//    NSLog(@"%@",NSStringFromSelector(action));
//}
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    return YES;
//}
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.item == 2) {
//        
//        collectionView.backgroundColor = [UIColor blueColor];
//    }
//    
//}
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    return YES;
//}
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.item == 2) {
//        
//        collectionView.backgroundColor = [UIColor orangeColor];
//    }
//    
//}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//
//    UICollectionReusableView *view = [ collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
//    view.backgroundColor = [UIColor redColor];
//    
//    return view;
//}
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    if(indexPath.item == 2){
//    
//        return YES;
//    }
//    return NO;
//}
//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    if (indexPath.item == 2) {
//        collectionView.backgroundColor = [UIColor yellowColor];
//    }
//}
//- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    if (indexPath.item == 2) {
//        collectionView.backgroundColor = [UIColor grayColor];
//    }
//}
#pragma mark - YANCollectionViewLayoutDelegate
- (CGFloat)collectionViewLayout:(YANCollectionViewLayout *)layout heightForItemAtIndext:(NSInteger)index itemWidth:(CGFloat)itemWidth{
    
    YANShop *shop = self.shopInfo[index];
    return itemWidth * shop.h / shop.w;
}
- (CGFloat)rowMarginInCollectionFlowLayout:(YANCollectionViewLayout *)layout{

    return 15;
}
- (CGFloat)columnCountInCollectionFlowLayout:(YANCollectionViewLayout *)layout{

    return 4;
}
- (CGFloat)columnMarginInCollectionFlowLayout:(YANCollectionViewLayout *)layout{

    return 15;
}
- (UIEdgeInsets)edgeInsetsInCollectionFlowLayout:(YANCollectionViewLayout *)layout{

    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//#pragma mark - UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    return CGSizeMake(80, 90);
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//
//    return UIEdgeInsetsMake(20, 10, 40, 50);
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//
//    return 100;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//
//    return 50;
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//
//    return CGSizeMake(30, 80);
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//
//    return CGSizeMake(50, 100);
//}
@end
