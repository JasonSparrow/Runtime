//
//  ViewController.m
//  Runtime
//
//  Created by duomai on 16/4/7.
//  Copyright © 2016年 duomai. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
//#import <objc/objc.h>
#import "AssociatedObjectKey.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getMemberVariable];
    //[self getProperties];
    //[self getMethods];
    //[self archive];
    //[self changeMethod];
    [self addProperty];

}
- (void)allMethods {
    
}
/**
 * 获取一个类的全部成员变量名
 */
- (void)getMemberVariable {
    unsigned int count;
    //获取成员变量的结构体
    Ivar *ivars = class_copyIvarList([Person class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        // 查看成员变量
        const char *name = ivar_getName(ivar);
        //c的字符串转OC的字符串
        NSString *key = [NSString stringWithUTF8String:name];
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"%d = %@, encodeType = %s", i, key, type);
    }
    //释放
    free(ivars);
}
/**
 * 获取一个类的全部属性名
 */
- (void)getProperties {
    unsigned int count;
        
    objc_property_t *properties = class_copyPropertyList([Person class], &count);
    for (int i = 0; i < count; i++) {
        //获取该类的一个属性指针
        objc_property_t property = properties[i];
        //获取属性的名称
        const char *name = property_getName(property);
        //c的字符串转OC的字符串
        NSString *key = [NSString stringWithUTF8String:name];
        NSLog(@"%d = %@", i, key);
        
        /**
        //若有获取属性的详细描述，可通过runtime提供的property_getAttributes函数来获取。
        const char *detailProperty = property_getAttributes(property);
        NSLog(@"-------%@", [NSString stringWithUTF8String:detailProperty]);
        */
        
        /**
        unsigned int count = 0;
        //若有获取属性中的objc_property_attribute_t列表，可以通过property_copyAttributeList函数来获取.
        objc_property_attribute_t *attrbutes = property_copyAttributeList(property, &count);
        for (unsigned int j = 0; j < count; ++j) {
            objc_property_attribute_t attribute = attrbutes[j];
            //若有获取单独的objc_property_attribute_t的name或者value，直接使用点语法即可，它是一个结构体。
            const char *name = attribute.name;
            const char *value = attribute.value;
            NSLog(@"name: %s   value: %s", name, value);
        }
        free(attrbutes);
         */
    }
    free(properties);
}
/**
 * 获取一个类的全部方法
 */
- (void)getMethods {
    unsigned int count;
    //获取指向该类所有方法的指针
    Method *methods = class_copyMethodList([Person class], &count);
    for (int i = 0; i < count; i++) {
        //获取该类的一个方法的指针
        Method method = methods[i];
        //获取方法
        SEL methodSEL = method_getName(method);
        
        /**
         //把方法名转成字符串
        NSString *methodName = NSStringFromSelector(methodSEL);
        NSLog(@"%@", methodName);
         */
        
        
        //讲方法转换为C字符串
        const char *name = sel_getName(methodSEL);
        //将C字符串转为OC字符串
        NSString *methodName = [NSString stringWithUTF8String:name];
        
        
        //获取方法参数个数
        int arguments = method_getNumberOfArguments(method);
        
        NSLog(@"%d = %@ %d", i, methodName, arguments);
        //如果没有参数, arguments值为2
    }
    free(methods);
}
/**
 * 归档/解档
 */
- (void)archive {
    Person *person = [[Person alloc] init];
    person.name = @"张三";
    person.age = 18;
    
    //归档
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:person];
    //存储
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:data forKey:@"Person"];
    
    //获取归档的data数据
    NSData *archivedata = [user valueForKey:@"Person"];
    //解档
    Person *p = [NSKeyedUnarchiver unarchiveObjectWithData:archivedata];
    
    NSLog(@"%@", p.name);
}

- (void)changeMethod {
    NSMutableArray *ary = [NSMutableArray arrayWithObjects:@"1", nil];
    NSString *name = nil;
    [ary addObject:name];
    //[ary objectAtIndex:2];
}
/**
 * 动态为类添加一个属性
 */
- (void)addProperty {
    AssociatedObjectKey *view = [[AssociatedObjectKey alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:view];
    
    [view addAssociatedObject:[[UIColor redColor] colorWithAlphaComponent:0.5]];
    
    NSLog(@"%@", [view getAssociatedObject]);
    view.backgroundColor = [view getAssociatedObject];
}
@end
