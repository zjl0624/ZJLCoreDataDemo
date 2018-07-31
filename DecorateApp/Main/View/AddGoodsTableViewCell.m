//
//  AddGoodsTableViewCell.m
//  DecorateApp
//
//  Created by zjl on 2018/3/2.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import "AddGoodsTableViewCell.h"
@interface AddGoodsTableViewCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentTxtField;

@end
@implementation AddGoodsTableViewCell

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
	NSDictionary *dic = (NSDictionary *)model;
	_titleLabel.text = dic[@"title"];
	if ([dic[@"isEditing"] boolValue] == YES) {
		_contentTxtField.enabled = YES;
	}else {
		_contentTxtField.enabled = NO;
	}
	_contentTxtField.text = [NSString stringWithFormat:@"%@",dic[@"content"]];

	[_contentTxtField addTarget:self action:@selector(txtChanged:) forControlEvents:UIControlEventEditingChanged];
	[_contentTxtField setDelegate:self];
}
- (void)txtChanged:(UITextField *)textField {
	[self.delegate finishEditeWithTitle:self.titleLabel.text content:textField.text];

}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[self.delegate didBeginEditing:textField cell:self];
}
@end
