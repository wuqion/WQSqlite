//
//  WQSqliteTools.h
//  WQSqlite_Example
//
//  Created by wuqiong on 2020/4/23.
//  Copyright © 2020 wuqiongaia@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WQSqliteTools : NSObject

//用户机制
//uid: nil common.db
//uid: xiaoming xiaoming.db
//执行sql语句
+ (BOOL)deal:(NSString *)sql uid:(NSString *)uid;

//查找
+ (NSMutableArray<NSMutableDictionary *>*)querySql:(NSString *)sql uid:(NSString *)uid;

+ (BOOL)dealSqls:(NSArray <NSString *>*)sqls uid:(NSString *)uid;
@end

NS_ASSUME_NONNULL_END
