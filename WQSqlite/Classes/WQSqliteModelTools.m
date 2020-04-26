//
//  WQSqliteModelTools.m
//  WQSqlite_Example
//
//  Created by wuqiong on 2020/4/25.
//  Copyright © 2020 wuqiongaia@163.com. All rights reserved.
//

#import "WQSqliteModelTools.h"
#import "WQModelTools.h"
#import "WQSqliteTools.h"
#import "WQTableTool.h"


@implementation WQSqliteModelTools

+ (BOOL)createTable:(Class)cls uid:(NSString *)uid
{
    //1.获取表名
    NSString * tableName = [WQModelTools tableName:cls];
    if (![cls  respondsToSelector:@selector(primaryKey)]) {
        NSLog(@"如果想要操作这个模型，必须好实现\n+ (NSString *)primaryKey;\n来确定主键信息");
        return NO;
    }
    //获取主键
    NSString * primaryKey = [cls primaryKey];
    //2.获取一个模型里的所有字段，以及类型
    NSString * createTableSql = [NSString stringWithFormat:@"create table if not exists %@(%@, primary key(%@))",tableName,[WQModelTools columnNamesAndTypesStr:cls],primaryKey];
    //执行
    return [WQSqliteTools deal:createTableSql uid:uid];
}
+(BOOL)isTabelRequiredUpdate:(Class)cls uid:(NSString *)uid
{
    NSArray * modelNames = [WQModelTools allTableSortedIvarNames:cls];
    NSArray * tableNames = [WQTableTool tableSortedColumnNames:cls uid:uid];
    if ([cls respondsToSelector:@selector(newNameFromOldName)]) {
        return [cls newNameFromOldName].allKeys > 0;
    }
    return ![modelNames isEqualToArray:tableNames];
}
+ (BOOL)updateTable:(Class)cls uid:(NSString *)uid
{
    //c创建临时表
    //1.获取表名
    NSString * tmpTableName = [WQModelTools tmpTableName:cls];
    NSString * tableName = [WQModelTools tableName:cls];
    if (![cls  respondsToSelector:@selector(primaryKey)]) {
        NSLog(@"如果想要操作这个模型，必须好实现\n+ (NSString *)primaryKey;\n来确定主键信息");
        return NO;
    }
    NSMutableArray * execSqls = [NSMutableArray array];
    //获取主键
    NSString * primaryKey = [cls primaryKey];
    //2.获取一个模型里的所有字段，以及类型
    NSString * createTableSql = [NSString stringWithFormat:@"create table if not exists %@(%@, primary key(%@))",tmpTableName,[WQModelTools columnNamesAndTypesStr:cls],primaryKey];
    [execSqls addObject:createTableSql];
    //根据主键插入数据
    NSString * insertPrimaryKeyData = [NSString stringWithFormat:@"insert into %@(%@) select %@ from %@;",tmpTableName,primaryKey,primaryKey,tableName];
    [execSqls addObject:insertPrimaryKeyData];

    //根据主键，把所有数据 更新到新表里面
    NSArray * oldNames = [WQTableTool tableSortedColumnNames:cls uid:uid];
    NSArray * newNames =[WQModelTools allTableSortedIvarNames:cls];
    //获取变更字段
    NSDictionary * changeField = @{};
    if ([cls respondsToSelector:@selector(newNameFromOldName)]) {
        changeField = [cls newNameFromOldName];
    }
    for (NSString * columnName in newNames) {
        NSString * oldName = columnName;
        if ([changeField.allKeys containsObject:columnName] && [changeField[columnName] length]>0) {
            oldName = changeField[columnName];
        }
        if (oldName.length>0 && ![oldNames containsObject:oldName]) {
            NSLog(@"变更字段有误");
            continue;
        }
        if ((![oldNames containsObject:columnName] && oldName.length == 0) || primaryKey == nil) {
            continue;
        }
        NSString * updateSql = [NSString stringWithFormat:@"update %@ set %@ = (select %@ from %@ where %@.%@=%@.%@)",tmpTableName,columnName,oldName,tableName,tmpTableName,primaryKey,tableName,primaryKey];
        
        [execSqls addObject:updateSql];
    }
    NSString * deleteOldTable = [NSString stringWithFormat:@"drop table if exists %@",tableName];
    [execSqls addObject:deleteOldTable];
    NSString * renameTabel = [NSString stringWithFormat:@"alter table %@ rename to %@",tmpTableName,tableName];
    [execSqls addObject:renameTabel];
    
    //执行
    return [WQSqliteTools dealSqls:execSqls uid:uid];

}


@end
