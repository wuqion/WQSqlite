//
//  WQSqlite_ExampleTests.m
//  WQSqlite_ExampleTests
//
//  Created by wuqiong on 2020/4/25.
//  Copyright © 2020 wuqiongaia@163.com. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "WQSqlTestModel.h"
#import "WQTableTool.h"
#import "WQSqliteModelTools.h"

@interface WQSqlite_ExampleTests : XCTestCase

@end

@implementation WQSqlite_ExampleTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    BOOL result = [WQSqliteModelTools createTable:[WQSqlTestModel class] uid:nil];
    XCTAssertEqual(YES, result);
  NSDictionary * dic =  [WQTableTool tableSortedColumnNames:[WQSqlTestModel class] uid:nil ];
    NSLog(@"%@",dic);
}
- (void)testTable{
    BOOL isUpdata = [WQSqliteModelTools isTabelRequiredUpdate:[WQSqlTestModel class] uid:nil];
    XCTAssertEqual(YES, isUpdata);
}
- (void)testTableUpdate{
    BOOL isUpdata = [WQSqliteModelTools updateTable:[WQSqlTestModel class] uid:nil];
    XCTAssertEqual(YES, isUpdata);
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
