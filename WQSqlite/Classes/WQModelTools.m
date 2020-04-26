//
//  WQModelTools.m
//  WQSqlite
//
//  Created by wuqiong on 2020/4/25.
//  Copyright © 2020 wuqiongaia@163.com. All rights reserved.
//

#import "WQModelTools.h"
#import <objc/runtime.h>
#import "WQModelProtocol.h"


@implementation WQModelTools

+ (NSString *)tableName:(Class)cls
{
    return  NSStringFromClass(cls);
}
+ (NSString *)tmpTableName:(Class)cls
{
    return  [NSStringFromClass(cls) stringByAppendingString:@"_tmp"];
}
//有效的成员变量
+(NSDictionary *)classIvarNameTypeDic:(Class)cls
{
    unsigned int count;
    Ivar * ivars = class_copyIvarList(cls, &count);
    NSMutableDictionary * dic =[NSMutableDictionary new];
    NSArray * ignoreNames = nil;
    if ([cls respondsToSelector:@selector(ignoreColumnNames)]) {
        ignoreNames = [cls ignoreColumnNames];
    }
    for (int i = 0 ; i<count; i++) {
       Ivar var = ivars[i];
       NSString * name = [NSString stringWithUTF8String:ivar_getName(var)];
       if ([name hasPrefix:@"_"]) {
          name = [name substringFromIndex:1];
       }
        if ([ignoreNames containsObject:name]) {
            continue;
        }
       NSString * typeEncode = [NSString stringWithUTF8String:ivar_getTypeEncoding(var)];
       typeEncode = [typeEncode stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"@\""]];
        [dic setValue:typeEncode forKey:name];
    }
    return dic;
}

+(NSDictionary *)classIvarNameSqliteTypeDic:(Class)cls
{
    NSMutableDictionary * dic = [self classIvarNameTypeDic:cls].mutableCopy;
    NSDictionary * ocType = [self ocTypeToSqliteTypeDic];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString * key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        dic[key] = ocType[obj];
    }];
    return dic;
}
+(NSString *)columnNamesAndTypesStr:(Class)cls
{
    NSDictionary * nameTypeDic = [self classIvarNameSqliteTypeDic:cls];
    NSMutableArray * result = [NSMutableArray array];
    
    [nameTypeDic enumerateKeysAndObjectsUsingBlock:^(NSString * key, NSString *  obj, BOOL * _Nonnull stop) {
        [result addObject:[NSString stringWithFormat:@"%@ %@",key,obj]];
    }];
    return [result componentsJoinedByString:@","];
}
+ (NSArray *)allTableSortedIvarNames:(Class)cls
{
    NSDictionary * dic = [self classIvarNameTypeDic:cls];
    NSArray * keys = dic.allKeys;
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
        return [obj1 compare:obj2];
    }];
    return keys;
}
#pragma mark --私有
+(NSDictionary *)ocTypeToSqliteTypeDic
{
    return @{
        @"d":@"real",//double
        @"f":@"real",//float
        
        @"i":@"integer", //int
        @"q":@"integer", //long
        @"Q":@"integer", //long long
        @"B":@"integer", //bool
        
        @"NSDate":@"blol",
        @"NSDictionary":@"text",
        @"NSMutableDictionary":@"text",
        @"NSArray":@"text",
        @"NSMutableArray":@"text",
        @"NSString":@"text",
    };
}

@end
