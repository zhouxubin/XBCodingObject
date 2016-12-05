//
//  XBCodingObject.m
//  coding协议
//
//  Created by 周旭斌 on 2016/12/5.
//  Copyright © 2016年 周旭斌. All rights reserved.
//

#import "XBCodingObject.h"
#import <objc/runtime.h>

@implementation XBCodingObject

- (NSArray *)properties {
    NSMutableArray *properties = [NSMutableArray array];
    unsigned int count = 0;
    
    Ivar *propertyArr = class_copyIvarList([self class], &count);
    objc_property_t *propertyArray = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar property = propertyArr[i];
        const char *propertyNameC = ivar_getName(property);
        NSString *propertyNameOC = [[NSString alloc] initWithCString:propertyNameC encoding:NSUTF8StringEncoding];
        [properties addObject:propertyNameOC];
    }
    free(propertyArray);
    
    
    return properties;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSArray *propertyArray = [self properties];
    for (NSString *property in propertyArray) {
        [aCoder encodeObject:[self valueForKey:property] forKey:property];
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super init]) {
        for (NSString *property in [self properties]) {
            [self setValue:[aDecoder decodeObjectForKey:property] forKey:property];
        }
    }
    return self;
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%@=%p  ", self.class, &self]];
    for (NSString *property in [self properties]) {
        NSString *propertyValue = [NSString stringWithFormat:@"%@=%@  ", property, [self valueForKey:property]];
        [string appendString:propertyValue];
    }
    return string.copy;
}

@end
