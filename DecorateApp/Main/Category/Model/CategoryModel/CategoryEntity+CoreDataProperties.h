//
//  CategoryEntity+CoreDataProperties.h
//  DecorateApp
//
//  Created by zjl on 2018/3/13.
//  Copyright © 2018年 zjl. All rights reserved.
//
//

#import "CategoryEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CategoryEntity (CoreDataProperties)

+ (NSFetchRequest<CategoryEntity *> *)fetchRequest;

@property (nonatomic) int32_t id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *images;

@end

NS_ASSUME_NONNULL_END
