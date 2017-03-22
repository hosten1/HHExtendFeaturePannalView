//
//  HHChatBarView.h
//  HHChatBar
//
//  Created by VRV2 on 16/8/19.
//  Copyright © 2016年 Hosten. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDChatPopupView;
@class HHChatBarView;
@protocol HHChatBarDelegate <NSObject>

/**
  下面的代理方法是用来设置一级菜单的标题相关(个数和标题),二级菜单相关
 */
@required
/**
 *  设置一级菜单有多少个条目
 *
 *  @param charBar  当前
 *
 *  @return 返回条目个数
 */
-(NSInteger)numberOfSectionWithchatBar:(HHChatBarView*)charBar;
/**
 *  根据index设置一级菜单条目的标题
 *
 *  @param charBar 当前
 *  @param indexPath 索引值 取section
 *
 *  @return 当前item的标题
 */
-(NSString*)chatBar:(HHChatBarView*)charBar sectionTitleWithIndexPath:(NSIndexPath*)indexPath;
/**
 *  返回所有二级标题（有就返回）
 *
 *  @param charBar 当前
 *  @param indexPath 二级标题索引 在indexPath.section
 *
 *  @return 放回所有二级标题的数组
 */
-(NSArray*)chatBar:(HHChatBarView *)charBar subPopViewTitleOfRowWithIndexPath:(NSIndexPath*)indexPath;

/**
   下面的方法都是在用户点击某个菜单或者按钮后的回调方法
 */
@optional
/**
 *  返回选中的项目
 *
 *  @param charBar
 *  @param indexPath 索引  indexPath.row  在视图中自上而下0，1，2...
 */
-(void)chatBar:(HHChatBarView*)charBar didSelectIndex:(NSIndexPath*)indexPath;
/**
 *  左侧按钮点击事件回调
 *
 *  @param charBar
 *  @param sender  点击的按钮
 */
-(void)chatBar:(HHChatBarView*)charBar didClickLeftButton:(UIButton*)sender;


@end

@interface HHChatBarView : UIView
/**
 *  数据字典  （目前不需要传）
 */
@property (copy,nonatomic) NSDictionary *resourseDictionary;

/**
  代理回调
 */
@property (assign,nonatomic) id<HHChatBarDelegate> chatDelegate;
/**
 *  左侧按钮的view
 */
@property(nonatomic,strong)UIView *leftContaintsView;

/**
    popView 弹出的View
 */
@property(nonatomic,strong)LDChatPopupView *popView;
/**
 *  包含所有subview的view
 *  所有功能菜单菜单项的父view
 */
@property (strong,nonatomic) UIView *rightSubButtonView;

/**
 左侧 切换按钮
 */
@property(nonatomic,strong)UIButton *leftBtn;

/**
  类实例化完成后，调用该方法，初始化功能菜单
  该方法应该在view设置好frame后和代理(setChatDelegate)设置完成后调用
 */
-(void)setupSubviewItems;

/**
 隐藏弹出的view（子菜单）
 */
-(void)hiddentPopView;
@end
