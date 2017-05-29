//
//  NSMutableArray+ArrayInsertNil.m
//  Runtime
//
//  Created by duomai on 16/4/7.
//  Copyright © 2016年 duomai. All rights reserved.
//

#import "NSMutableArray+ArrayInsertNil.h"
#import <objc/runtime.h>

@implementation NSMutableArray (ArrayInsertNil)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method orginaMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:));
        Method newMethod    = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(gp_addObject:));
        method_exchangeImplementations(orginaMethod, newMethod);
    });
}
- (void)gp_addObject:(id)obj {
//    NSLog(@"%@", obj);
    if (obj != nil) {
        [self gp_addObject:obj];
    }else {
        NSLog(@"数组不能插入nil array = %@, insert = %@", self, obj);
    }
}
@end
