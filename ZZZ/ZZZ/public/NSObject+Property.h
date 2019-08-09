//
//  NSObject+Property.h
//  test
//
//  Created by lushouxiang on 15/11/19.
//  Copyright © 2015年 paime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Property)

- (NSDictionary *)properties_aps;

- (NSDictionary *)ivar_aps;

@end
