//
//  LDChatPopupView.m
//  Linkdood
//
//  Created by VRV2 on 2016/11/5.
//  Copyright © 2016年 xiong qing. All rights reserved.
//

#import "LDChatPopupView.h"

#define KcellMargin 2

@interface LDChatPopupView ()
@property (assign,nonatomic) CGFloat cellHeight;
@property (assign,nonatomic) CGFloat viewHeight;
@property (assign,nonatomic) CGFloat viewPositionY;
@end

@implementation LDChatPopupView

-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray*)titleArray{
    if (self == [super initWithFrame:frame]) {
        NSAssert(titleArray==nil||titleArray.count!=0, @"子标题数组为空");
        _titleArray = titleArray;
        _cellHeight = frame.size.height;
        _viewHeight = KcellMargin*0.5+(self.cellHeight+KcellMargin)*titleArray.count;
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width,self.viewHeight);
        [self initPopupView];
    }
    return self;
}
-(void)initPopupView{
    UIButton *cellView = nil;
    CGFloat cellWidth;
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        cellView = [UIButton buttonWithType:UIButtonTypeCustom];
        [cellView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:cellView];
        [cellView setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [cellView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cellView.titleLabel.font = [UIFont systemFontOfSize:14];
        cellView.tag = 20161100 + i;
        [cellView addTarget:self action:@selector(popSelectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat cellY = KcellMargin+(self.cellHeight+KcellMargin)*i;
        cellWidth = self.frame.size.width-KcellMargin*2;
        cellView.frame = CGRectMake(KcellMargin, cellY, cellWidth,self.cellHeight);
    }
   
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self updateSubViewFrame];
    NSLog(@"hhhhhhhhh          layoutSubviews");
}
-(void)updateSubViewFrame{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width,self.viewHeight);
    _viewPositionY = self.frame.origin.y;
    NSInteger i = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            CGFloat cellY = KcellMargin+(self.cellHeight+KcellMargin)*i;
            CGFloat cellWidth = self.frame.size.width-KcellMargin*2;
            view.frame = CGRectMake(KcellMargin, cellY, cellWidth,self.cellHeight);
            i++;
        }
    }
}
-(void)popSelectButtonClick:(UIButton*)sender{
    NSInteger indexValue = sender.tag%10;
    if (_tableViewCallBack) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:indexValue inSection:self.indexValue];
        _tableViewCallBack(index);
    }
}
-(Boolean)hideView{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(self.frame.origin.x,[UIScreen mainScreen].bounds.size.height - self.chatBarHeight, self.frame.size.width, self.viewHeight);
    } completion:^(BOOL finished) {
        if (!self.isHidden) {
            self.hidden = YES;
        }

    }];

        return true;
}
-(Boolean)showView{
    if (self.isHidden) {
        self.hidden = NO;
//        [self.tableView reloadData];
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(self.frame.origin.x,self.viewPositionY, self.frame.size.width, self.viewHeight);
    } completion:^(BOOL finished) {
                
    }];

    return YES;
}
@end
