//
//  WQSqliteTools.m
//  WQSqlite_Example
//
//  Created by wuqiong on 2020/4/23.
//  Copyright © 2020 wuqiongaia@163.com. All rights reserved.
//

#import "WQSqliteTools.h"
#import <sqlite3.h>

//#define kCachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
#define kCachePath @"/Users/woshisha/Desktop/"


@implementation WQSqliteTools

static  sqlite3 * ppDb = nil;

+ (BOOL)deal:(NSString *)sql uid:(NSString *)uid
{
    if (![self openDB:uid]) {
        NSLog(@"打开失败");
        return NO;
    }
    //2.执行语句
    BOOL result = sqlite3_exec(ppDb, sql.UTF8String, nil, nil, nil) == SQLITE_OK;
    [self CloseDB];
    //3.关闭数据库
    return result;
}
//查找
+ (NSMutableArray<NSMutableDictionary *>*)querySql:(NSString *)sql uid:(NSString *)uid{
    [self openDB:uid];
    
//    NSString * sql = @"insert into t_stu(name, age) values(?,?)";
    //准备语句（预处理语句）
    //1.创建准备语句
    //参数1：一个已经打开的数据库
    //参数2：sql语句
    //参数3:参数2取出多少字节的长度 -1自动计算 已\0结束
    //参数4:准备语句
    //参数5:通过参数3取出参数2的长度字节之后，剩下的字符
    
    sqlite3_stmt *ppStmt = nil;

    if (sqlite3_prepare_v2(ppDb, sql.UTF8String, -1, &ppStmt, nil) == SQLITE_OK) {
        NSLog(@"准备j语句失败");
        return nil;
    };
    
    //2.绑定数据（省略），在用问号占位的时候用
    
    //3.执行
    NSMutableArray * rowDicArray = [NSMutableArray array];
    while (sqlite3_step(ppStmt) == SQLITE_ROW) { //取出一行数据
        //1.获取所有列的个数
        int columnCount = sqlite3_column_count(ppStmt);
        NSMutableDictionary * rowDic =[ NSMutableDictionary dictionary];
        //2.遍历所有的列
        for (int i = 0; i<columnCount; i++) {
            //2.1获取列名
            const char * columnNameC = sqlite3_column_name(ppStmt, i);
            NSString * columnName = [NSString stringWithUTF8String:columnNameC];
            //2.2获取列值
             //2.2.1获取列的类型
            int type = sqlite3_column_type(ppStmt, i);
            //2.2.1根据列的类型用不通的获取列值方法
            id value = nil;
            switch (type) {
                case SQLITE_INTEGER:
                    value = @(sqlite3_column_int(ppStmt, i));
                    break;
                case SQLITE_FLOAT:
                 value = @(sqlite3_column_double(ppStmt, i));
                    break;
                case SQLITE_BLOB:
                    value = CFBridgingRelease(sqlite3_column_blob(ppStmt, i));
                    break;
                case SQLITE_NULL:
                 value = @"";
                    break;
                case SQLITE_TEXT:
                     value =[NSString stringWithUTF8String: (const char *)sqlite3_column_text(ppStmt, i)];
                    break;
                default:
                    break;
            }
            [rowDic setValue:value forKey:columnName];
            
        }
        [rowDicArray addObject:rowDic];
        
    } ;
    //4.重置（省略）
    
    //5.释放资源
    sqlite3_free(ppStmt);
    [self CloseDB];
    return rowDicArray;
    
}

#pragma mark - 私有方法
+ (BOOL )openDB:(NSString *)uid{
    NSString * dbName = @"common.sqlite";
    if (uid.length != 0) {
        dbName = [NSString stringWithFormat:@"%@.sqlite",uid];
    }
    NSString * path = [kCachePath stringByAppendingPathComponent:dbName];
   
    //1.打开s/创建数据库
    return sqlite3_open(path.UTF8String, &ppDb) != SQLITE_OK;
}
+ (void)CloseDB{
    sqlite3_close(ppDb);
}
@end
