//
//  SEWUserDefaults.m
//  SEWUserDefaults
//
//  Created by YanWei on 16/10/11.
//  Copyright © 2016年 YanWei. All rights reserved.
//

#import "SEWUserDefaults.h"

#import "SEWUserDefaults+Database.h"

extern BOOL kLogSwich;

@implementation SEWUserDefaults

+ (void)openLog
{
    kLogSwich = YES;
}

+ (void)closeLog
{
    kLogSwich = NO;
}

+ (instancetype)standardUserDefaults
{
    static SEWUserDefaults *_standardUserDefaults = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _standardUserDefaults = [[SEWUserDefaults alloc] init];
    });
    return _standardUserDefaults;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createTableIfNotExist];
    }
    return self;
}

- (nullable id)objectForKey:(NSString *)defaultName
{
    return [self valueObjectForKey:defaultName];
}

- (BOOL)setObject:(nullable id)value forKey:(NSString *)defaultName
{
    BOOL result = NO;
    if (value && ![value isKindOfClass:[NSNull class]]) {
        result = [self replaceIntoValueObject:value forKey:defaultName];
    } else {
        result = [self removeObjectForKey:defaultName];
    }
    return result;
}

- (BOOL)removeObjectForKey:(NSString *)defaultName
{
    BOOL result = [self deleteValueObjectForKey:defaultName];
    return result;
}

- (nullable NSString *)stringForKey:(NSString *)defaultName
{
    id object = [self objectForKey:defaultName];
    
    if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
        NSString *targetString = [NSString stringWithFormat:@"%@", object];
        return targetString;
    }
    return nil;
}

- (NSInteger)integerForKey:(NSString *)defaultName
{
    id object = [self objectForKey:defaultName];
    NSInteger integer = [object integerValue];
    return integer;
}

- (float)floatForKey:(NSString *)defaultName
{
    id object = [self objectForKey:defaultName];
    float floatValue = [object floatValue];
    return floatValue;
}

- (double)doubleForKey:(NSString *)defaultName
{
    id object = [self objectForKey:defaultName];
    double doubleValue = [object doubleValue];
    return doubleValue;
}

- (BOOL)boolForKey:(NSString *)defaultName
{
    id object = [self objectForKey:defaultName];
    BOOL boolValue = [object boolValue];
    return boolValue;
}

- (BOOL)setInteger:(NSInteger)value forKey:(NSString *)defaultName
{
    return [self setObject:@(value) forKey:defaultName];
}

- (BOOL)setFloat:(float)value forKey:(NSString *)defaultName
{
    return [self setObject:@(value) forKey:defaultName];
}

- (BOOL)setDouble:(double)value forKey:(NSString *)defaultName
{
    return [self setObject:@(value) forKey:defaultName];
}

- (BOOL)setBool:(BOOL)value forKey:(NSString *)defaultName
{
    return [self setObject:@(value) forKey:defaultName];
}

@end
