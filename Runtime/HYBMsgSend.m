//
//  HYBMsgSend.m
//  Runtime
//
//  Created by duomai on 16/4/8.
//  Copyright © 2016年 duomai. All rights reserved.
//

#import "HYBMsgSend.h"

@implementation HYBMsgSend
//发送无参数无返回值消息
- (void)noArgumentsAndNoReturnValue {
    NSLog(@"%s was called, and it has no arguments and return value", __FUNCTION__);
}
//带参数不带返回值消息
- (void)hasArguments:(NSString *)arg {
    NSLog(@"%s was called, and argument is %@", __FUNCTION__, arg);
}
//带返回值不带参数消息
- (NSString *)noArgumentsButReturnValue {
    NSLog(@"%s was called, and return value is %@", __FUNCTION__, @"不带参数，但是带有返回值");
    return @"不带参数，但是带有返回值";
}
//带参数带返回值的消息
- (int)hasArguments:(NSString *)arg andReturnValue:(int)arg1 {
    NSLog(@"%s was called, and argument is %@, return value is %d", __FUNCTION__, arg, arg1);
    return arg1;
}
@end
