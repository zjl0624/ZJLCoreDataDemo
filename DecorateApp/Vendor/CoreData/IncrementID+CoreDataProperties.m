//
//  IncrementID+CoreDataProperties.m
//  DecorateApp
//
//  Created by zjl on 2018/3/7.
//  Copyright © 2018年 zjl. All rights reserved.
//
//

#import "IncrementID+CoreDataProperties.h"

@implementation IncrementID (CoreDataProperties)

+ (NSFetchRequest<IncrementID *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"IncrementID"];
}

@dynamic id;
@dynamic num;

@end
