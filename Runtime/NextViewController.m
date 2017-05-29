//
//  NextViewController.m
//  Runtime
//
//  Created by duomai on 16/4/8.
//  Copyright © 2016年 duomai. All rights reserved.
//

#import "NextViewController.h"
#import "HYBDog.h"
#import "HYBPig.h"
#import "HYBCat.h"
#import "HYBMsgSend.h"
#import <objc/message.h>

@implementation NextViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    HYBDog *dog = [[HYBDog alloc] init];
    [dog eat];
    
    HYBPig *pig = [[HYBPig alloc] init];
    [pig performSelector:@selector(eat) withObject:nil afterDelay:1];
    
    HYBCat *cat = [[HYBCat alloc] init];
    [cat performSelector:@selector(eat) withObject:nil afterDelay:2];
    
    // 1.创建对象
    HYBMsgSend *msg = ((HYBMsgSend * (*)(id, SEL))objc_msgSend)((id)[HYBMsgSend class], @selector(alloc));
    
    // 2.初始化对象
    msg = ((HYBMsgSend * (*)(id, SEL))objc_msgSend)((id)msg, @selector(init));
    
    
    // 3.调用无参数无返回值方法
    ((void (*)(id, SEL))objc_msgSend)((id)msg,
                                      @selector(noArgumentsAndNoReturnValue));
    
    // 4.调用带一个参数但无返回值的方法
    ((void (*)(id, SEL, NSString *))objc_msgSend)((id)msg,
                                                  @selector(hasArguments:),
                                                  @"带一个参数，但无返回值");
    
    // 5.调用带返回值，但是不带参数
    NSString *retValue = ((NSString * (*)(id, SEL))objc_msgSend)((id)msg,
                                                                 @selector(noArgumentsButReturnValue));
    NSLog(@"返回值为：%@", retValue);
    
    // 6.带参数带返回值
    /**
     * int returnValue, (int 为返回值类型)
     * ((int (*)(id, SEL, NSString *, int))  -> int 为返回值类型, (*)函数指针, id, 向哪个类发送消息, SEL 为发送消息的签名, NSString *, 第一个参数, int, 第二个参数
     */
    int returnValue = ((int (*)(id, SEL, NSString *, int))
                       objc_msgSend)((id)msg,
                                     @selector(hasArguments:andReturnValue:),
                                     @"参数1",
                                     2016);
    NSLog(@"return value is %d", returnValue);
    
}

@end
