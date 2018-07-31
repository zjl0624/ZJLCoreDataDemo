//
//  GoodsCacheModel.h
//  DecorateApp
//
//  Created by zjl on 2018/3/2.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsCacheModel : NSObject
@property (nonatomic,strong) NSString *brand;
@property (nonatomic,strong) NSString *remark;
@property (nonatomic,assign) BOOL isCheck;
@property (nonatomic,assign) int id;
@property (nonatomic,assign) int categoryID;
@property (nonatomic,assign) int price;
@property (nonatomic,assign) float length;
@property (nonatomic,assign) float width;
@property (nonatomic,assign) float height;
@end
