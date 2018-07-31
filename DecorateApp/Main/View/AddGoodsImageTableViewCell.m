//
//  AddGoodsImageTableViewCell.m
//  DecorateApp
//
//  Created by zjl on 2018/3/2.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import "AddGoodsImageTableViewCell.h"
@interface AddGoodsImageTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end
@implementation AddGoodsImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - ConfigureCellDelegate
- (void)configureCellWithModel:(id)model {
	UIImage *image = (UIImage *)model;
	[self.imageview setImage:image];
}
@end
