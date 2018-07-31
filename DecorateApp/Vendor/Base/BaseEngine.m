//
//  BaseEngine.m
//  DecorateApp
//
//  Created by zjl on 2018/3/1.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import "BaseEngine.h"
static id _Instance;
@implementation BaseEngine
+ (instancetype)sharedInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_Instance = [[BaseEngine alloc] init];
	});
	return _Instance;
}
- (void)createSqlite {
	//1、创建模型对象
	//获取模型路径
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DecorateApp" withExtension:@"momd"];
	//根据模型文件创建模型对象
	NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	
	//2、创建持久化存储助理：数据库
	//利用模型对象创建助理对象
	NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
	
	//数据库的名称和路径
	NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSString *sqlPath = [docStr stringByAppendingPathComponent:@"coreData.sqlite"];
	NSLog(@"数据库 path = %@", sqlPath);
	NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
	
	NSError *error = nil;
	//设置数据库相关信息 添加一个持久化存储库并设置类型和路径，NSSQLiteStoreType：SQLite作为存储库
	[store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:nil error:&error];
	
	if (error) {
		NSLog(@"添加数据库失败:%@",error);
	} else {
		NSLog(@"添加数据库成功");
	}
	
	//3、创建上下文 保存信息 操作数据库
	
	NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	
	//关联持久化助理
	context.persistentStoreCoordinator = store;
	
	_context = context;
}
@end
