//
//  HHExtendFeaturePannalViews.m
//  HHExtendFeaturePannalView
//
//  Created by VRV2 on 2017/3/16.
//  Copyright © 2017年 Hosten_lym. All rights reserved.
//

#import "HHExtendFeaturePannalViews.h"
#import "HHPannalConllectionView.h"

@interface HHExtendFeaturePannalViews ()<UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView *scrowllView;
@property(nonatomic, strong) UIPageControl *pageConteol;
@property(nonatomic, assign) NSInteger viewCount;
@end
@implementation HHExtendFeaturePannalViews

- (void)setupScrwollView{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    //    scrollView.backgroundColor = [UIColor redColor];
  
    self.viewCount = 2;
    scrollView.contentSize = CGSizeMake(self.bounds.size.width * self.viewCount , self.bounds.size.height);
    
    scrollView.tag = 101;
    
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    
   HHPannalConllectionView *subView = [[HHPannalConllectionView alloc]initWithFrame:CGRectMake(0,0,self.bounds.size.width * self.viewCount , self.bounds.size.height)];
    for (NSInteger i = 0 ; i < self.viewCount ; i ++) {
        //        NSLog(@"sub:%ld",i);
        CGFloat subX = self.bounds.size.width*i;
        [subView setupCollectionVeiwWithFram:CGRectMake(subX, 0, self.bounds.size.width, self.bounds.size.height) collectionKey:[NSString stringWithFormat:@"%ld",i]];
    }
    [scrollView addSubview:subView];
    CGFloat pageCW= 60;
    CGFloat pageCH= 30;
    CGFloat pageCX= self.center.x - pageCW*0.5;
    CGFloat pageCY= self.bounds.size.height - pageCH - 10;
    
    UIPageControl *pageConteol = [[UIPageControl alloc] initWithFrame:CGRectMake(pageCX, pageCY, pageCW, pageCH)];
    pageConteol.numberOfPages = self.viewCount ;
    pageConteol.tag = 201;
    pageConteol.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    [pageConteol setPageIndicatorTintColor:[UIColor grayColor]];
    [self  addSubview:scrollView];
    [self  addSubview: pageConteol];
    self.scrowllView = scrollView;
    self.pageConteol = pageConteol;
    self.scrowllView.backgroundColor = [UIColor redColor];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int current = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    
    self.pageConteol.currentPage = current;
    
    if (self.pageConteol.currentPage == self.viewCount-1) {
        
        //调用方法，使滑动图消失
        //        [self scrollViewDisappear];
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

@end
