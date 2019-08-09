//
//  NSObject+Property.m
//  test
//
//  Created by lushouxiang on 15/11/19.
//  Copyright © 2015年 paime. All rights reserved.
//

#import "NSObject+Property.h"

@implementation NSObject (Property)

- (NSDictionary *)properties_aps
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    NSMutableArray * arr = [NSMutableArray array];
   
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) {
            [props setObject:propertyValue forKey:propertyName];
        }else{
            [arr addObject:propertyName];
        }
        
    }
    
    free(properties);
    [props setObject:@(outCount) forKey:@"properties_aps_outCount"];
    [props setObject:arr forKey:@"no_value"];
    return props;
}


- (NSDictionary *)ivar_aps
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    Ivar * ivars = class_copyIvarList([self class], &outCount);
    
    NSMutableArray * arr = [NSMutableArray array];
    
    for (i = 0; i<outCount; i++)
    {
        Ivar ivar = ivars[i];
        const char* char_f = ivar_getName(ivar);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) {
            [props setObject:propertyValue forKey:propertyName];
        }else{
            [arr addObject:propertyName];
        }
    }
    free(properties);
    [props setObject:@(outCount) forKey:@"ivar_aps_outCount"];
    [props setObject:arr forKey:@"no_value"];
    
    return props;
}




@end
