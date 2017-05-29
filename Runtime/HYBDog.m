//
//  HYBDog.m
//  Runtime
//
//  Created by duomai on 16/4/8.
//  Copyright © 2016年 duomai. All rights reserved.
//

#import "HYBDog.h"
#import <objc/runtime.h>

@implementation HYBDog
// 第一步：实现此方法，在调用对象的某方法找不到时，会先调用此方法
// 指定是否动态添加方法。若返回NO，则进入下一步，若返回YES，则通过class_addMethod函数动态地添加方法，消息得到处理，此流程完毕。
// 我们动态添加方法实现
+ (BOOL)resolveInstanceMethod:(SEL)sel { //sel为不能解析的选择器, 返回值为Boolean, 表示这个类能否新增一个实例方法用于处理此选择器
    // 我们这里没有给dog声明有eat方法，因此，我们可以动态添加eat方法
    //将选择器转化成字符串
    NSString *selectorString = NSStringFromSelector(sel);
    //判断选择器的名称
    if ([selectorString isEqualToString:@"eat"]) {
        class_addMethod(self, sel, (IMP)eat, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
/**
//尚未实现的方法是一个类方法则使用,此方法
+ (BOOL)resolveClassMethod:(SEL)sel {
    return YES;
}
 */
// 这个方法是我们动态添加的哦
void eat(id self, SEL cmd) {
    NSLog(@"%@ is eating", self);
}
@end
