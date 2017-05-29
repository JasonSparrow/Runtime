//
//  AssociatedObjectKey.m
//  Runtime
//
//  Created by duomai on 16/4/7.
//  Copyright © 2016年 duomai. All rights reserved.
//

#import "AssociatedObjectKey.h"
#import <objc/runtime.h>

@implementation AssociatedObjectKey
//添加关联对象
- (void)addAssociatedObject:(id)object {
    objc_setAssociatedObject(self, @selector(getAssociatedObject), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//获取关联对象
- (id)getAssociatedObject {
    //_cmd代表的就是当前的方法的签名
    return objc_getAssociatedObject(self, _cmd);
}
@end
