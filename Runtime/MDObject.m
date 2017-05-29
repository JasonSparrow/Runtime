//
//  MDObject.m
//  Runtime
//
//  Created by duomai on 16/4/7.
//  Copyright © 2016年 duomai. All rights reserved.
//

#import "MDObject.h"
#import <objc/runtime.h>

@implementation MDObject
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        unsigned int count;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        for (int i = 0; i < count; i++) {
            //获取该类的一个属性指针
            objc_property_t property = properties[i];
            //获取属性的名称
            const char *name = property_getName(property);
            //c的字符串转OC的字符串
            NSString *key = [NSString stringWithUTF8String:name];
            id value;
            if ([dictionary isKindOfClass:[NSDictionary class]]) {
                value = [dictionary objectForKey:key];
            }
            if (value == [NSNull null]) {
                continue;
            }
            if (value) { //KVC赋值
                [self setValue:value forKey:key];
            }
        }
        free(properties);
    }
    return self;
}
+ (NSMutableArray *) getDictionaryFromArray:(NSArray *) aArray
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for(NSDictionary *dic in aArray)
    {
        [dataArray addObject:[[self alloc] initWithDictionary:dic]];
    }
    return dataArray;
}
@end
