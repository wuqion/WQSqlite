//
//  WQSqliteModelTools.h
//  WQSqlite_Example
//
//  Created by wuqiong on 2020/4/25.
//  Copyright © 2020 wuqiongaia@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WQModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface WQSqliteModelTools : NSObject

//创建一个表
+ (BOOL)createTable:(Class)cls uid:(NSString *)uid;
//是否需要更新数据表
+(BOOL)isTabelRequiredUpdate:(Class)cls uid:(NSString *)uid;
//更新数据表
+ (BOOL)updateTable:(Class)cls uid:(NSString *)uid;
@end

NS_ASSUME_NONNULL_END
