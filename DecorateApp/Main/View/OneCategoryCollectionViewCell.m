//
//  OneCategoryCollectionViewCell.m
//  DecorateApp
//
//  Created by zjl on 2018/3/2.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import "OneCategoryCollectionViewCell.h"
#import "GoodsInfo+CoreDataClass.h"

@interface OneCategoryCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *nameTxtLabel;

@end
@implementation OneCategoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark - ConfigureCellDelegate
- (void)configureCellWithModel:(id)model {
	GoodsInfo *en = (GoodsInfo *)model;
	_nameTxtLabel.text = en.brand;
}
@end
