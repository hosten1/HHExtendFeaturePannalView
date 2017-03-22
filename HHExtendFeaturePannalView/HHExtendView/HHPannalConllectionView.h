//
//  HHPannalConllectionView.h
//  HHExtendFeaturePannalView
//
//  Created by VRV2 on 2017/3/16.
//  Copyright © 2017年 Hosten_lym. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^indexCallBack)(NSIndexPath *index);

@interface HHPannalConllectionView : UIView

@property (copy,nonatomic) indexCallBack pannalCellCallBack;
@property (copy,nonatomic) NSArray *items;
- (void)setupCollectionVeiwWithFram:(CGRect)subFrame collectionKey:(NSString*)key;
@end
