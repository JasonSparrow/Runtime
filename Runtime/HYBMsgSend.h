//
//  HYBMsgSend.h
//  Runtime
//
//  Created by duomai on 16/4/8.
//  Copyright © 2016年 duomai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYBMsgSend : NSObject

//发送无参数无返回值消息
- (void)noArgumentsAndNoReturnValue;
//带参数不带返回值消息
- (void)hasArguments:(NSString *)arg;
//带返回值不带参数消息
- (NSString *)noArgumentsButReturnValue;
//带参数带返回值的消息
- (int)hasArguments:(NSString *)arg andReturnValue:(int)arg1;
@end
