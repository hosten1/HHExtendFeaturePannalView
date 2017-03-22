//
//  HHPannalModel.m
//  HHExtendFeaturePannalView
//
//  Created by VRV2 on 2017/3/22.
//  Copyright © 2017年 Hosten_lym. All rights reserved.
//

#import "HHPannalModel.h"

@implementation HHPannalModel

- (instancetype)initWithImg:(NSString *)imgName title:(NSString *)title{
    self = [super init];
    if (self) {
        _imgName = imgName;
        _title   = title;
    }
    return self;
}
@end
