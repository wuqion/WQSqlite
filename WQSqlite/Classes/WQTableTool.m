//
//  WQTableTool.m
//  WQSqlite
//
//  Created by wuqiong on 2020/4/25.
//  Copyright © 2020 wuqiongaia@163.com. All rights reserved.
//

#import "WQTableTool.h"
#import "WQModelTools.h"
#import "WQSqliteTools.h"

@implementation WQTableTool

+ (NSArray *)tableSortedColumnNames:(Class)cls uid:(NSString *)uid
{
    //获取表名
    NSString * tableName = [WQModelTools tableName:cls];
    //获取表名对应的创建语句
    NSString * createSqlStr = [NSString stringWithFormat:@"select sql from sqlite_master where type = 'table' and name ='%@'",tableName];
    NSDictionary * dic = [WQSqliteTools querySql:createSqlStr uid:uid].firstObject;
    NSString * createTableSqlStr = dic[@"sql"];
    NSString * nameTypeStr = [createTableSqlStr componentsSeparatedByString:@"("][1];
    NSArray * nameTypeArray = [nameTypeStr componentsSeparatedByString:@","];
    NSMutableArray * names = [NSMutableArray array];
    
    for (NSString * nameType in nameTypeArray) {
        if ([nameType containsString:@"primary"]) {
            continue;
        }
        NSString * name = [nameType componentsSeparatedByString:@" "].firstObject;
        [names addObject:name];
    }
    //排序
    [names sortUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
        return [obj1 compare:obj2];
    }];
    return names;
}
@end
