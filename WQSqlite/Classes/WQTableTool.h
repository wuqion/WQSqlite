//
//  WQTableTool.h
//  WQSqlite
//
//  Created by wuqiong on 2020/4/25.
//  Copyright © 2020 wuqiongaia@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WQTableTool : NSObject

+ (NSArray *)tableSortedColumnNames:(Class)cls uid:(NSString *)uid;

@end

NS_ASSUME_NONNULL_END
