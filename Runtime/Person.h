//
//  Person.h
//  Runtime
//
//  Created by duomai on 16/4/7.
//  Copyright © 2016年 duomai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArchiveObject.h"

@interface Person : ArchiveObject
@property (nonatomic, assign) int age;
@property (nonatomic, strong) NSString *name;
@end
