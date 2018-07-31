//
//  AddCollectionViewCell.m
//  DecorateApp
//
//  Created by zjl on 2018/3/1.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import "AddCollectionViewCell.h"
@interface AddCollectionViewCell()
- (IBAction)AddBtnClick:(id)sender;

@end
@implementation AddCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)AddBtnClick:(id)sender {
	[self.delegate clickAddCollectionViewCell:self sender:sender];
}
@end
