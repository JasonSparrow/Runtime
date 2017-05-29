//
//  MDObject.h
//  Runtime
//
//  Created by duomai on 16/4/7.
//  Copyright © 2016年 duomai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDObject : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *) getDictionaryFromArray:(NSArray *) aArray;
@end
