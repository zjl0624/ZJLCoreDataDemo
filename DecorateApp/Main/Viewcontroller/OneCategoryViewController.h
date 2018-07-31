//
//  OneCategoryViewController.h
//  DecorateApp
//
//  Created by zjl on 2018/3/1.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import "BaseViewController.h"
#import "AddGoodsViewController.h"

@interface OneCategoryViewController : BaseViewController<AddCollectionViewCellClickDelegate,CurrentViewControllerDismissDelegate>

@property (nonatomic,assign) NSInteger currentCategoryID;
@end
