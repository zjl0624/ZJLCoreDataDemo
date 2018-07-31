//
//  AddGoodsTableViewCell.h
//  DecorateApp
//
//  Created by zjl on 2018/3/2.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddGoodsTableViewCell;
@protocol TxtFieldDelegate
- (void)finishEditeWithTitle:(NSString *)title content:(NSString *)content;

- (void)didBeginEditing:(UITextField *)textField cell:(AddGoodsTableViewCell *)cell;
@end
@interface AddGoodsTableViewCell : UITableViewCell<ConfigureCellDelegate>
@property (nonatomic,weak) id<TxtFieldDelegate> delegate;
@property (nonatomic,assign) BOOL isEditing;
@end
