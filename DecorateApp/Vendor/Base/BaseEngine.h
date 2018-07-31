//
//  BaseEngine.h
//  DecorateApp
//
//  Created by zjl on 2018/3/1.
//  Copyright © 2018年 zjl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseEngine : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic,strong) NSManagedObjectContext *context;

- (void)createSqlite;
@end
