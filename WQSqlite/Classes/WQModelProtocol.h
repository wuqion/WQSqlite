//
//  WQModelProtocol.h
//  WQSqlite_Example
//
//  Created by wuqiong on 2020/4/25.
//  Copyright © 2020 wuqiongaia@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WQModelProtocol <NSObject>

//必须实现
@required
//返回主键
+ (NSString *)primaryKey;

//可选实现
@optional
//忽略的字段
+ (NSArray *)ignoreColumnNames;
//变更的字段(配合model到属性写)
+ (NSDictionary *)newNameFromOldName;

@end

NS_ASSUME_NONNULL_END
