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
-(void)setPannalModel:(HHPannalModel *)pannalModel{
    _pannalModel = pannalModel;
    self.iconImageView.image = [UIImage imageNamed:pannalModel.imgName];
    if ([pannalModel.title isEqualToString:@""]||!pannalModel.title) {
        self.titlelAB.hidden = YES;
    }else{
         self.titlelAB.hidden = NO;
         self.titlelAB.text = pannalModel.title;
    }
}
//- (void)setImage:(UIImage*)img title:(NSString*)title{
//    if (img&&title) {
//        self.iconImageView.image = img;
//        self.titlelAB.text = title;
//    }
//}
@end
