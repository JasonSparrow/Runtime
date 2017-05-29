//
//  AssociatedObjectKey.h
//  Runtime
//
//  Created by duomai on 16/4/7.
//  Copyright © 2016年 duomai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssociatedObjectKey : UIView
- (void)addAssociatedObject:(id)object;
- (id)getAssociatedObject;
@end
