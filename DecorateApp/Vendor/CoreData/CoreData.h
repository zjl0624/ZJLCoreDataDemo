//
//  CoreData.h
//  DecorateApp
//
//  Created by zjl on 2018/3/2.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreData : NSObject

+ (int)GetNum;

+ (void)insertWithData:(id)entity num:(int)num success:(void(^)(void))success  failure:(void(^)(NSString * msg))failure;

+ (void)updateWithData:(id)entity EntityName:(NSString *)name ID:(int)ID success:(void(^)(void))success  failure:(void(^)(NSString * msg))failure;

+ (void)readDataWithEntityName:(NSString *)name predicate:(NSPredicate *)predicate success:(void(^)(NSArray * resultArr))success  failure:(void(^)(NSString * msg))failure;
@end
