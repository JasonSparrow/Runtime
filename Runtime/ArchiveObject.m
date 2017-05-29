//
//  ArchiveObject.m
//  Runtime
//
//  Created by duomai on 16/4/7.
//  Copyright © 2016年 duomai. All rights reserved.
//

#import "ArchiveObject.h"
#import <objc/runtime.h>

@implementation ArchiveObject
- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        NSString *propertyValue = [self valueForKey:propertyName];
        [aCoder encodeObject:propertyValue forKey:propertyName];
    }
    free(properties);
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        NSString *propertyValue = [aDecoder decodeObjectForKey:propertyName];
        [self setValue:propertyValue forKey:propertyName];
    }
    free(properties);
    return self;
}
@end
