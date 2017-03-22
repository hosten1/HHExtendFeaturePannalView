//
//  HHChatBarView.m
//  HHChatBar
//
//  Created by VRV2 on 16/8/19.
//  Copyright © 2016年 Hosten. All rights reserved.
//

#import "HHChatBarView.h"
#import "LDChatPopupView.h"
static NSString *const KHHChatBarViewLog = @"hosten_robotChat HHChatBarView";

#define kScreenSize [UIScreen mainScreen].bounds.size
#define KViewHeight  self.frame.size.height
#define KCellHeight 30.0f
#define WEAKSELF __weak __typeof(&*self)weakSelf = self;
#define Kmargin 2//所有控件之间的距离
#define KHHChatBarViewScreenScale SCREEN_WIDTH/375
@interface HHChatBarView ()

/**
 存储上一个点击的button
 */
@property(nonatomic,assign)NSInteger oldBtnTargt;
//@property(nonatomic, strong) LDChatPopupView *oldPopView;
@property(nonatomic,copy)NSArray *sourcesArray;
@property (assign,nonatomic) bool Hiddent;
@property (assign,nonatomic) NSInteger count;

@property (copy,nonatomic) NSArray *subMenuTitleArrary;
@property(nonatomic, copy) NSArray *titileArray;
@end

@implementation HHChatBarView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLeftBarButton];
        _oldBtnTargt = 0;
    }
    return self;
}

-(void)setResourseDictionary:(NSDictionary *)resourseDictionary{
    _resourseDictionary = resourseDictionary;
    self.sourcesArray = resourseDictionary[@"menu"];
}

/**
 初始化 功能菜单与输入框切换按钮
 */
-(void)initLeftBarButton{
    if (self.leftContaintsView) {
        [self.leftContaintsView removeFromSuperview];
    }
    UIView *leftContaintsView = [[UIView alloc]init];
    [self addSubview:leftContaintsView];
    self.leftContaintsView = leftContaintsView;
    UIButton *leftButton = [[UIButton alloc]init];
    self.leftBtn = leftButton;
    [leftContaintsView addSubview:leftButton];
//    leftButton.backgroundColor = [UIColor greenColor];
    [self.self.leftBtn addTarget:self action:@selector(leftBtnClickWithChatItemView:) forControlEvents:UIControlEventTouchUpInside];
    self.leftContaintsView.frame = CGRectMake(Kmargin, Kmargin, 45, self.frame.size.height-Kmargin);
    CGFloat leftWH = self.leftContaintsView.frame.size.width*0.5;
    self.leftBtn.bounds = CGRectMake(0,0, leftWH, leftWH);
    self.leftBtn.center = self.leftContaintsView.center;
    [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"bubble_left_Menu"] forState:UIControlStateNormal];

}
-(void)setupSubviewItems{
    if (self.rightSubButtonView) {
        [self.rightSubButtonView removeFromSuperview];
    }
//完成右侧菜单按钮父view的初始化和布局
    UIView *rightBtnView = [[UIView alloc]init];
    CGFloat contentViewX = CGRectGetMaxX(self.leftContaintsView.frame);
    CGFloat contetViewWid = kScreenSize.width - contentViewX;
    rightBtnView.frame = CGRectMake(contentViewX,0, contetViewWid, self.frame.size.height);
    self.rightSubButtonView = rightBtnView;
    [self addSubview:rightBtnView];
    self.rightSubButtonView.backgroundColor = [UIColor redColor];
//通过代理方法 拿到需要添加的子控件数
    NSInteger count = 1;
    if (self.chatDelegate && [self.chatDelegate respondsToSelector:@selector(numberOfSectionWithchatBar:)]) {
        count = [self.chatDelegate  numberOfSectionWithchatBar:self];
//        NSLog(@"%@ numberOfSectionWithchatBar 获取到字view的个数:%ld  \n",KHHChatBarViewLog,count);
    }
    self.count = count;
    CGFloat itemWidth = (contetViewWid-(count+1)*Kmargin)/count;
    CGFloat itemY = Kmargin;

    UIButton * item;
    for (NSInteger i = 0; i < count; i++) {
        item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.titleLabel.font =  [UIFont systemFontOfSize:15];
        [item setTitle:@"ce shi " forState:UIControlStateNormal];
        [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightBtnView addSubview:item];
        NSString *title;
        if (self.chatDelegate && [self.chatDelegate respondsToSelector:@selector(chatBar:sectionTitleWithIndexPath:)]) {
            title = [self.chatDelegate  chatBar:self sectionTitleWithIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
            NSLog(@"%@ sectionTitleWithIndexPath:%@ \n",KHHChatBarViewLog,title);
            if (!title) {
                title = @"帮助";
            }
            if (title.length > 4) {
                item.titleLabel.font =  [UIFont systemFontOfSize:13];
            }
            [item setTitle:title forState:UIControlStateNormal];
        }
               NSArray *titileArray = nil;
        if (self.chatDelegate && [self.chatDelegate respondsToSelector:@selector(chatBar:subPopViewTitleOfRowWithIndexPath:)]) {
            titileArray = [self.chatDelegate  chatBar:self subPopViewTitleOfRowWithIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
            if (titileArray.count > 0) {//如果有子菜单 则显示菜单图标
                [item setImage:[UIImage imageNamed:@"bubble_menu"] forState:UIControlStateNormal];
                
            }
        }
       
        [item addTarget:self action:@selector(buttonClickWithChatItemView:) forControlEvents:UIControlEventTouchUpInside];
        item.tag = 2016819+i+1;//+1是为了便于区分是不是第一次弹出二级菜单

        CGFloat itemX = i * (itemWidth + Kmargin)+Kmargin;
        item.frame = CGRectMake(itemX, itemY, itemWidth, self.rightSubButtonView.frame.size.height-2*Kmargin);
        item.backgroundColor = [UIColor whiteColor];
    }
    [self bringSubviewToFront:self.leftContaintsView];
}

/**
 点击某个 一级菜单
 @param sender 事件按钮
 */
-(void)buttonClickWithChatItemView:(UIButton*)sender{
    
    NSInteger section = sender.tag - 2016819;
    //如果没有获取过(或者获取的数组为空)，或者获取为空,重新调用代理方法获取一次数据
        NSArray *titileArray;
        if (self.chatDelegate && [self.chatDelegate respondsToSelector:@selector(chatBar:subPopViewTitleOfRowWithIndexPath:)]) {
            titileArray = [self.chatDelegate  chatBar:self subPopViewTitleOfRowWithIndexPath:[NSIndexPath indexPathForRow:0 inSection:section-1]];
        }
        _titileArray = titileArray;
   //再次获取后，如果为空则回调index为0，结束该方法
    if (!self.titileArray || self.titileArray.count == 0) {
        if (self.chatDelegate && [self.chatDelegate respondsToSelector:@selector(chatBar:didSelectIndex:)]) {
            [self.chatDelegate chatBar:self didSelectIndex:[NSIndexPath indexPathForRow:0 inSection:section-1]];
            if (self.popView) {
                [self.popView hideView];
            }
        }
        return;
    }else{
//      控制二级菜单frame
        NSInteger subCount = self.titileArray.count;
        CGFloat height = (KCellHeight+2)*subCount;
        
        CGFloat width;
        if (self.count > 3 || self.count == 1) {
            width = 100;
        }else{
            width = sender.frame.size.width;
        }
        CGFloat x;
        if (self.count == 4||self.count == 5||self.count == 6) {
            x = sender.frame.origin.x+2-10;
        }else{
            x = sender.center.x - width*0.5+self.leftContaintsView.bounds.size.width;
        }
        CGFloat y  = self.superview.bounds.size.height - (height+self.bounds.size.height+4);
        //添加二级菜单
        [self addPopViewOnSuperView:self.superview frame:CGRectMake(x,y,width,KCellHeight) withSection:section];
    }
//    self.popView.cellColor = sender.backgroundColor;
//    self.popView.cellColor = [UIColor redColor];
//    self.popView.backgroundColor = self.backgroundColor;
    self.popView.backgroundColor = [UIColor redColor];
}

/**
  处理二级菜单弹出逻辑

 @param supView 二级菜单弹出的父view
 @param popFrame 二级菜单的frame
 @param section 点击的父view
 */
- (void)addPopViewOnSuperView:(UIView*)supView frame:(CGRect)popFrame withSection:(NSInteger)section{
    LDChatPopupView *popView;
    WEAKSELF
        if (self.oldBtnTargt != section) {//第一次为零默认走该方法（按钮标记是从1开始）
            if (self.popView) {//如果view已经存在且点击的一级菜单和上次不同则重新初始化一个
                [self.popView hideView];
                [self.popView removeFromSuperview];
                self.popView = nil;
            }
            popView = [[LDChatPopupView alloc] initWithFrame:popFrame titleArray:self.titileArray];
            self.popView = popView;
            popView.indexValue = section-1;
            self.oldBtnTargt = section;
            [supView addSubview:popView];
            
        }else{//如果点击的按钮和前一次相同
            if (!self.popView.isHidden) {
                [self.popView hideView];
            }else{
                [self.popView showView];
                self.popView.indexValue = section-1;
            }
        }
    if (popView) {
        popView.tableViewCallBack = ^(NSIndexPath *index){
            if (weakSelf.chatDelegate && [weakSelf.chatDelegate respondsToSelector:@selector(chatBar:didSelectIndex:)]) {
                [weakSelf.popView hideView];
                [weakSelf.chatDelegate chatBar:weakSelf didSelectIndex:index];
            }
        };
    }
    
}

/**
 左侧按钮点击事件

 @param sender button
 */
-(void)leftBtnClickWithChatItemView:(UIButton*)sender{
    if (self.popView) {
        [self.popView hideView];
    }
    if (self.chatDelegate && [self.chatDelegate respondsToSelector:@selector(chatBar:didClickLeftButton:)]) {
        [self.chatDelegate chatBar:self didClickLeftButton:sender];
    }
}

-(void)hiddentPopView{
    if (self.popView) {
        [self.popView hideView];
    }
}
/**
 重新布局 右侧功能按钮(未使用)
 */
/*
 -(void)layoutRightSubButton{
 
 CGFloat margin = Kmargin;
 
 NSArray *subArray = self.rightSubButtonView.subviews;
 CGFloat contentViewX = CGRectGetMaxX(self.leftContaintsView.frame)+margin;
 CGFloat contetViewWid = kScreenSize.width - contentViewX-2;
 self.rightSubButtonView.frame = CGRectMake(contentViewX, margin-1, contetViewWid, self.frame.size.height-10);
 NSInteger count = self.count;
 
 CGFloat itemWidth = (contetViewWid-margin)/count;
 CGFloat itemY = 1;
 UIButton *item ;
 for (NSInteger i = 0; i <subArray.count; i++) {
 UIView *subViewBtn = subArray[i];
 if ([subViewBtn isKindOfClass:[UIButton class]]) {
 item = (UIButton*)subViewBtn;
 CGFloat itemX = i * (itemWidth + margin);
 item.frame = CGRectMake(itemX, itemY, itemWidth, KViewHeight-1);
 }
 }
 
 }
 */

@end
