//
//  LDChatPopupView.h
//  Linkdood
//
//  Created by VRV2 on 2016/11/5.
//  Copyright © 2016年 xiong qing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^indexCallBack)(NSIndexPath *index);

@interface LDChatPopupView : UIView

-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray*)titleArray;
-(Boolean)hideView;
-(Boolean)showView;

@property (assign,nonatomic) CGFloat cellHeight;
@property (copy,nonatomic) NSArray *titleArray;
@property (assign,nonatomic) NSInteger indexValue;
@property (strong,nonatomic) UIColor *cellColor;
@property (copy,nonatomic) indexCallBack tableViewCallBack;

@end
