//
//  WQSqlTestModel.m
//  WQSqlite_ExampleTests
//
//  Created by wuqiong on 2020/4/25.
//  Copyright © 2020 wuqiongaia@163.com. All rights reserved.
//

#import "WQSqlTestModel.h"

@implementation WQSqlTestModel
+ (NSString *)primaryKey
{
    return @"name";
}
//+ (NSArray *)ignoreColumnNames
//{
//    return @[@"friends"];
//}
+ (NSDictionary *)newNameFromOldName
{
    return @{@"bian":@"age",@"age":@"bian"};
}
@end
