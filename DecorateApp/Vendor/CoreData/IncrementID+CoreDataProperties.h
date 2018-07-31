//
//  IncrementID+CoreDataProperties.h
//  DecorateApp
//
//  Created by zjl on 2018/3/7.
//  Copyright © 2018年 zjl. All rights reserved.
//
//

#import "IncrementID+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface IncrementID (CoreDataProperties)

+ (NSFetchRequest<IncrementID *> *)fetchRequest;

@property (nonatomic) int32_t id;
@property (nonatomic) int32_t num;

@end

NS_ASSUME_NONNULL_END
