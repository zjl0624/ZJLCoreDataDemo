//
//  GoodsInfo+CoreDataProperties.h
//  DecorateApp
//
//  Created by zjl on 2018/3/2.
//  Copyright © 2018年 zjl. All rights reserved.
//
//

#import "GoodsInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GoodsInfo (CoreDataProperties)

+ (NSFetchRequest<GoodsInfo *> *)fetchRequest;

@property (nonatomic) int32_t id;
@property (nullable, nonatomic, copy) NSString *brand;
@property (nonatomic) int32_t categoryID;
@property (nullable, nonatomic, copy) NSString *image;
@property (nonatomic) int32_t price;
@property (nonatomic) float length;
@property (nonatomic) float width;
@property (nonatomic) float height;
@property (nonatomic) BOOL isCheck;
@property (nullable, nonatomic, copy) NSString *remark;
@end

NS_ASSUME_NONNULL_END
