//
//  AddCollectionViewCell.h
//  DecorateApp
//
//  Created by zjl on 2018/3/1.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddCollectionViewCell;
@protocol AddCollectionViewCellClickDelegate
- (void)clickAddCollectionViewCell:(AddCollectionViewCell *)cell sender:(UIButton *)sender;
@end
@interface AddCollectionViewCell : UICollectionViewCell
@property (nonatomic,weak) id<AddCollectionViewCellClickDelegate> delegate;
@end
