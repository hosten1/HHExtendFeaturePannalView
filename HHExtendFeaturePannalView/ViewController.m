//
//  ViewController.m
//  HHExtendFeaturePannalView
//
//  Created by VRV2 on 2017/3/16.
//  Copyright © 2017年 Hosten_lym. All rights reserved.
//

#import "ViewController.h"
#import "HHExtendFeaturePannalViews.h"
@interface ViewController ()
@property(nonatomic, strong) HHExtendFeaturePannalViews *pannalViews;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    HHExtendFeaturePannalViews *exView = [[HHExtendFeaturePannalViews alloc]init];
    exView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 400);
    exView.center = self.view.center;
    [exView  setupScrwollView];
    self.pannalViews = exView;
    [self.view addSubview:exView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
