//
//  ViewController.m
//  HHExtendFeaturePannalView
//
//  Created by VRV2 on 2017/3/16.
//  Copyright © 2017年 Hosten_lym. All rights reserved.
//

#import "ViewController.h"
#import "HHExtendFeaturePannalViews.h"
#import "HHChatBarView.h"
#import "HHPannalModel.h"
#define kChatBatHeight 45

@interface ViewController ()<HHChatBarDelegate,HHExtendFeaturePannalViewsDelegate>
@property(nonatomic, strong) HHExtendFeaturePannalViews *pannalViews;
@property(nonatomic,strong)HHChatBarView *chatBar;
@property(nonatomic, strong) NSArray *oneTitleArray;
@property(nonatomic, strong) NSArray *secondTitleArray;
@property(nonatomic,strong)NSMutableArray*items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _items = [NSMutableArray array];
    HHPannalModel *model;
    for (NSInteger i = 0; i < 8; i++) {
        model = [[HHPannalModel alloc]initWithImg:@"portrait@2x" title:[NSString stringWithFormat:@"测试%ld",i]];
        [self.items addObject:model];
    }
    // Do any additional setup after loading the view, typically from a nib.
    _oneTitleArray = @[@"haha",@"测试",@"测试"];
    _secondTitleArray = @[@"二级菜单",@"二级测试",@"二级测试"];
    HHExtendFeaturePannalViews *exView = [[HHExtendFeaturePannalViews alloc]init];
    exView.bounds = CGRectMake(0, 0, self.view.bounds.size.width,250);
    exView.center = self.view.center;
    exView.delegate = self;
    [exView  setupScrwollView];
    self.pannalViews = exView;
    [self.view addSubview:exView];
    
    [self setupChatBar];
    self.chatBar.hidden = NO;
    [self.chatBar setupSubviewItems];
}

-(void)setupChatBar{
    if (self.chatBar) {
        [self.chatBar removeFromSuperview];
        self.chatBar = nil;
    }
    HHChatBarView *chat = [[HHChatBarView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-kChatBatHeight, [UIScreen mainScreen].bounds.size.width, kChatBatHeight)];
    chat.leftBtn.alpha = 1.0f;
    chat.chatDelegate = self;
    chat.backgroundColor = [UIColor whiteColor];
    _chatBar = chat;
    [self.view addSubview:chat];
}
#pragma mark  --HHChatBardelegate
-(NSInteger)numberOfSectionWithchatBar:(HHChatBarView *)charBar{
    
    //    NSLog(@"%@ numberOfSectionWithchatBar: %@  \n",KLDRobotChatVCLog,arr);
    return self.oneTitleArray.count;
}
-(NSString*)chatBar:(HHChatBarView *)charBar sectionTitleWithIndexPath:(NSIndexPath *)indexPath{

    return self.oneTitleArray[indexPath.section];
}
-(NSArray*)chatBar:(HHChatBarView *)charBar subPopViewTitleOfRowWithIndexPath:(NSIndexPath *)indexPath{
       return self.secondTitleArray;
}
-(void)chatBar:(HHChatBarView *)charBar didSelectIndex:(NSIndexPath *)indexPath{
    NSLog(@"\n HHChatBarView   section: %ld======row:%ld",indexPath.section,indexPath.row);
   
}
-(void)chatBar:(HHChatBarView *)charBar didClickLeftButton:(UIButton *)sender
{
    NSLog(@":");

}
#pragma mark ---HHExtendFeaturePannalViewsDelegate
-(NSInteger)numberOfSectionWithextendPannalView:(HHExtendFeaturePannalViews *)extendPannalView{
    return 3;
}
-(NSArray *)extendPannalView:(HHExtendFeaturePannalViews *)extendPannalView itemsOfRowWithIndexPath:(NSIndexPath *)indexPath{
    return self.items;
}

-(void)extendPannalView:(HHExtendFeaturePannalViews *)extendPannalView didSelectIndex:(NSIndexPath *)indexPath{
    NSLog(@"\n HHExtendFeaturePannalViews did select  section:%ld===========>row:%ld",indexPath.section,indexPath.row);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
