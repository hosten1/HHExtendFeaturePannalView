//
//  HHPannalConllectionView.m
//  HHExtendFeaturePannalView
//
//  Created by VRV2 on 2017/3/16.
//  Copyright © 2017年 Hosten_lym. All rights reserved.
//

#import "HHPannalConllectionView.h"
#import "HHPannalCollectionViewCell.h"
static NSString *const KPannalViewCellID = @"PannalViewCellID";
static NSInteger KHeaderCollectionViewHeight = 150;

@interface HHPannalConllectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, strong) NSMutableDictionary *collectionViews;
@property(nonatomic, assign) CGRect superFrame;

@end

@implementation HHPannalConllectionView
-(NSMutableDictionary *)collectionViews{
    if (!_collectionViews) {
        _collectionViews = [[NSMutableDictionary alloc]init];
    }
    return _collectionViews;
}
-(void)setupCollectionVeiwWithFram:(CGRect)subFrame collectionKey:(NSString *)key{
    self.superFrame = subFrame;
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView * collect = [[UICollectionView alloc]initWithFrame:subFrame collectionViewLayout:layout];
    collect.delegate=self;
    collect.dataSource=self;
    [collect registerNib:[UINib nibWithNibName:@"HHPannalCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:KPannalViewCellID];
    [self addSubview:collect];
    if (self.collectionViews) {
        [self.collectionViews setObject:@[collect] forKey:key];
    }
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HHPannalCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:KPannalViewCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
//    [cell setImage:[UIImage imageNamed:@"portrait@2x"] title:[NSString stringWithFormat:@"%ld__%ld",indexPath.section,indexPath.row]];
    HHPannalModel *model = self.items[indexPath.row];
    if (model) {
        cell.pannalModel = model;
    }
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellW = (self.superFrame.size.width-5*10)/4;
    return CGSizeMake(cellW, cellW+10);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionViews enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (collectionView == [obj firstObject]) {
//            NSLog(@"row=======%ld\n\t section:=======%@",indexPath.row,key);
            if (self.pannalCellCallBack) {
                NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row inSection:[key longLongValue]];
                self.pannalCellCallBack(index);
            }
            *stop = YES;
        }
    }];
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
}
@end
