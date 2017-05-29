//
//  NSMutableArray+ArrayBeyond.m
//  Runtime
//
//  Created by duomai on 16/4/7.
//  Copyright © 2016年 duomai. All rights reserved.
//

#import "NSMutableArray+ArrayBeyond.h"
#import <objc/runtime.h>

@implementation NSMutableArray (ArrayBeyond)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method orginaMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndex:));
        Method newMethod    = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(beyond_objectAtIndex:));
        method_exchangeImplementations(orginaMethod, newMethod);
    });
}
- (void) beyond_objectAtIndex:(NSUInteger)index {
    if (index > self.count - 1) {
        NSLog(@"数组越界 array = %@, count = %ld, currentIndex = %ld", self, self.count, index);
    }else {
        [self beyond_objectAtIndex:index];
    }
}
@end
