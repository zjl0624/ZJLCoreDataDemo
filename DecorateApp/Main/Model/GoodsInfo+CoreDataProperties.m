//
//  GoodsInfo+CoreDataProperties.m
//  DecorateApp
//
//  Created by zjl on 2018/3/2.
//  Copyright © 2018年 zjl. All rights reserved.
//
//

#import "GoodsInfo+CoreDataProperties.h"

@implementation GoodsInfo (CoreDataProperties)

+ (NSFetchRequest<GoodsInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GoodsInfo"];
}

@dynamic id;
@dynamic brand;
@dynamic categoryID;
@dynamic image;
@dynamic price;
@dynamic length;
@dynamic width;
@dynamic height;
@dynamic isCheck;
@dynamic remark;
@end
