//
//  HHPannalConllectionView.h
//  HHExtendFeaturePannalView
//
//  Created by VRV2 on 2017/3/16.
//  Copyright © 2017年 Hosten_lym. All rights reserved.
//

#import <UIKit/UIKit.h>

static 
typedef void(^indexCallBack)(NSIndexPath *index);
@interface HHPannalConllectionView : UIView

@property (assign,nonatomic) NSInteger indexValue;
@property (copy,nonatomic) indexCallBack tableViewCallBack;
@property (copy,nonatomic) NSDictionary *items;
- (void)setupCollectionVeiwWithFram:(CGRect)subFrame collectionKey:(NSString*)key;
@end
