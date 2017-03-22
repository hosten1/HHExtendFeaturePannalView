//
//  HHExtendFeaturePannalViews.h
//  HHExtendFeaturePannalView
//
//  Created by VRV2 on 2017/3/16.
//  Copyright © 2017年 Hosten_lym. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHExtendFeaturePannalViews;
@protocol HHExtendFeaturePannalViewsDelegate <NSObject>

/**
 下面的代理方法是用来设置一级菜单的标题相关(个数和标题),二级菜单相关
 */
@required
/**
 *  设置一级菜单有多少个条目
 *
 *  @param extendPannalView  当前
 *
 *  @return 返回条目个数
 */
-(NSInteger)numberOfSectionWithextendPannalView:(HHExtendFeaturePannalViews*)extendPannalView;
/**
 *  返回所有二级标题（有就返回）
 *
 *  @param extendPannalView 当前
 *  @param indexPath 二级标题索引 在indexPath.section
 *
 *  @return 放回所有二级标题的数组
 */
-(NSArray*)extendPannalView:(HHExtendFeaturePannalViews*)extendPannalView itemsOfRowWithIndexPath:(NSIndexPath*)indexPath;

/**
 下面的方法都是在用户点击某个菜单或者按钮后的回调方法
 */
@optional
/**
 *  返回选中的项目
 *
 *  @param extendPannalView 当前
 *  @param indexPath 索引  indexPath.row  在视图中自上而下0，1，2...
 */
-(void)extendPannalView:(HHExtendFeaturePannalViews*)extendPannalView didSelectIndex:(NSIndexPath*)indexPath;


@end

@interface HHExtendFeaturePannalViews : UIView
@property(nonatomic, weak)id< HHExtendFeaturePannalViewsDelegate> delegate;
- (void)setupScrwollView;
@end
