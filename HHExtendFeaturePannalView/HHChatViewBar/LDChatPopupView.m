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

@end

@implementation LDChatPopupView

-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray*)titleArray{
    if (self == [super initWithFrame:frame]) {
        NSAssert(titleArray==nil||titleArray.count!=0, @"子标题数组为空");
        _titleArray = titleArray;
        self.cellHeight = frame.size.height;
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, KcellMargin+(self.cellHeight+KcellMargin)*titleArray.count);
        [self initPopupView];
    }
    return self;
}
-(void)initPopupView{
    UIButton *cellView = nil;
    
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
        cellView.frame = CGRectMake(KcellMargin, cellY, self.bounds.size.width-KcellMargin*2,self.cellHeight );
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
    if (!self.isHidden) {
        self.hidden = YES;
    }
    return true;
}
-(Boolean)showView{
    if (self.isHidden) {
        self.hidden = NO;
//        [self.tableView reloadData];
    }
    return YES;
}
@end
