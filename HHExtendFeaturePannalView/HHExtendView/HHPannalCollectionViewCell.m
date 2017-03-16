//
//  HHPannalCollectionViewCell.m
//  HHExtendFeaturePannalView
//
//  Created by VRV2 on 2017/3/16.
//  Copyright © 2017年 Hosten_lym. All rights reserved.
//

#import "HHPannalCollectionViewCell.h"

@interface HHPannalCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titlelAB;

@end
@implementation HHPannalCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setImage:(UIImage*)img title:(NSString*)title{
    if (img&&title) {
        self.iconImageView.image = img;
        self.titlelAB.text = title;
    }
}
@end
