//
//  HHPannalModel.h
//  HHExtendFeaturePannalView
//
//  Created by VRV2 on 2017/3/22.
//  Copyright © 2017年 Hosten_lym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHPannalModel : NSObject
@property(nonatomic, copy) NSString *imgName;
@property(nonatomic,copy)  NSString *title;

-(instancetype)initWithImg:(NSString*)imgName title:(NSString*)title;
@end
