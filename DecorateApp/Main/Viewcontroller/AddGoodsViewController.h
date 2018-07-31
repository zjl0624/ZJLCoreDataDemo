//
//  AddGoodsViewController.h
//  DecorateApp
//
//  Created by zjl on 2018/3/2.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsInfo;
@protocol CurrentViewControllerDismissDelegate
- (void)currentViewControllerDismiss;
@end
@interface AddGoodsViewController : UIViewController
@property (nonatomic,strong) GoodsInfo *goods;
@property (nonatomic,assign) int ID;
@property (nonatomic,assign) BOOL isAdd;
@property (nonatomic,weak) id<CurrentViewControllerDismissDelegate> delegate;

@end
