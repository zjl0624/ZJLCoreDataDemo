//
//  CategoryCollectionViewCell.m
//  DecorateApp
//
//  Created by zjl on 2018/3/1.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import "CategoryCollectionViewCell.h"
#import "CategoryEntity+CoreDataClass.h"
@interface CategoryCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation CategoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark - ConfigureCellDelegate

- (void)configureCellWithModel:(id)model {
	CategoryEntity *en = (CategoryEntity *)model;
	_nameLabel.text = en.name;
}
@end
