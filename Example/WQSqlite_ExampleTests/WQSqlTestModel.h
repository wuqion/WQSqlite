//
//  WQSqlTestModel.h
//  WQSqlite_ExampleTests
//
//  Created by wuqiong on 2020/4/25.
//  Copyright © 2020 wuqiongaia@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WQModelProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface WQSqlTestModel : NSObject<WQModelProtocol>

@property(nonatomic, strong)NSString * name;
@property(nonatomic, strong)NSString * names;
@property(nonatomic, assign)float height;
@property(nonatomic, assign)int bian;
@property(nonatomic, assign)double age;
@property(nonatomic, strong)NSArray * friends;
@property(nonatomic, strong)NSArray * results;

@end

NS_ASSUME_NONNULL_END
