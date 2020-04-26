//
//  WQSqliteModel.h
//  WQSqlite
//
//  Created by wuqiong on 2020/4/25.
//  Copyright © 2020 wuqiongaia@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WQModelTools : NSObject

+ (NSString *)tableName:(Class)cls;
+ (NSString *)tmpTableName:(Class)cls;
//所有的成员变量。以及成员变量对应的类型
+(NSDictionary *)classIvarNameTypeDic:(Class)cls;
//所有的成员变量，以及成员变量映射到数据库对应的类型
+(NSDictionary *)classIvarNameSqliteTypeDic:(Class)cls;
//根据所有的成员变量，生成对应的sqlkey
+(NSString *)columnNamesAndTypesStr:(Class)cls;
+ (NSArray *)allTableSortedIvarNames:(Class)cls;

@end

NS_ASSUME_NONNULL_END
