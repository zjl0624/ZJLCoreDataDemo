//
//  CategoryEntity+CoreDataProperties.m
//  DecorateApp
//
//  Created by zjl on 2018/3/13.
//  Copyright © 2018年 zjl. All rights reserved.
//
//

#import "CategoryEntity+CoreDataProperties.h"

@implementation CategoryEntity (CoreDataProperties)

+ (NSFetchRequest<CategoryEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CategoryEntity"];
}

@dynamic id;
@dynamic name;
@dynamic images;

@end
