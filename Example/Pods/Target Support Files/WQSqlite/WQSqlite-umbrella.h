#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "WQModelProtocol.h"
#import "WQModelTools.h"
#import "WQSqliteModelTools.h"
#import "WQSqliteTools.h"
#import "WQTableTool.h"

FOUNDATION_EXPORT double WQSqliteVersionNumber;
FOUNDATION_EXPORT const unsigned char WQSqliteVersionString[];

