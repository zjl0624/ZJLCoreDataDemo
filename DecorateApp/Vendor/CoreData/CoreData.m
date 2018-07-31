//
//  CoreData.m
//  DecorateApp
//
//  Created by zjl on 2018/3/2.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import "CoreData.h"

@implementation CoreData

+ (int)GetNum {
	__block int num = 1;
	[self readDataWithEntityName:@"IncrementID" predicate:nil success:^(NSArray *resultArr) {

		if ([resultArr count] > 0) {
			IncrementID *increment = resultArr[0];
			num = increment.num;
		}
	} failure:nil];
	return num;
}

+ (void)insertWithData:(id)entity num:(int)num success:(void(^)(void))success  failure:(void(^)(NSString * msg))failure{
	__block int currentNum = [self GetNum];
	[self readDataWithEntityName:@"IncrementID" predicate:nil success:^(NSArray *resultArr) {
		
		if ([resultArr count] > 0) {
			IncrementID *increment = resultArr[0];
			currentNum = increment.num + 1;
		}else {
			IncrementID *inen = [NSEntityDescription insertNewObjectForEntityForName:IncrementIDEntityName inManagedObjectContext:[BaseEngine sharedInstance].context];
			inen.id = 1;
			inen.num = 2;
			currentNum = 2;
		}
	} failure:nil];
	if (currentNum > 2) {
		NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:IncrementIDEntityName];
		NSArray *resArray = [[BaseEngine sharedInstance].context executeFetchRequest:request error:nil];
		
		//修改
		[resArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			IncrementID *increment = (IncrementID *)obj;
			increment.num = currentNum;
		}];
	}

	NSError *error;
	if ([[BaseEngine sharedInstance].context save:&error]) {
		[ZJLHud showCustomHud:YES type:alertType title:@"添加成功"];
		success();
	}else {
		[ZJLHud showCustomHud:YES type:alertType title:@"添加失败"];
		if (failure) {
			failure(error.description);
		}

	}
}

+ (void)updateWithData:(id)entity EntityName:(NSString *)name ID:(int)ID success:(void(^)(void))success  failure:(void(^)(NSString * msg))failure{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:name];
	
	NSPredicate *pre = [NSPredicate predicateWithFormat:@"id = %d", ID];
	request.predicate = pre;
	
	//发送请求
	NSArray *resArray = [[BaseEngine sharedInstance].context executeFetchRequest:request error:nil];
	
	//修改
	[resArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		obj = entity;
	}];
	
	
	//保存
	NSError *error = nil;
	if ([[BaseEngine sharedInstance].context save:&error]) {
		[ZJLHud showCustomHud:YES type:alertType title:@"修改成功"];
		success();
	}else{
		[ZJLHud showCustomHud:YES type:alertType title:@"修改失败"];
		if (failure) {
			failure(error.description);
		}
	}
}

+ (void)readDataWithEntityName:(NSString *)name predicate:(NSPredicate *)predicate success:(void(^)(NSArray * resultArr))success  failure:(void(^)(NSString * msg))failure {
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:name];
	request.predicate = predicate;
	NSError *error;
	NSArray *arr = [[BaseEngine sharedInstance].context executeFetchRequest:request error:&error];
	if (!error) {
		success(arr);
	}else {
		[ZJLHud showCustomHud:YES type:alertType title:@"查询失败"];
		if (failure) {
			failure(error.description);
		}

	}
}
@end
