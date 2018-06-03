//
//  SEWUserDefaults.h
//  SEWUserDefaults
//
//  Created by YanWei on 16/10/11.
//  Copyright © 2016年 YanWei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface SEWUserDefaults : NSObject

+ (void)openLog;
+ (void)closeLog;

+ (instancetype)standardUserDefaults;

- (nullable id)objectForKey:(NSString *)defaultName;

- (BOOL)setObject:(nullable id)value forKey:(NSString *)defaultName;

- (BOOL)removeObjectForKey:(NSString *)defaultName;

- (nullable NSString *)stringForKey:(NSString *)defaultName;

- (NSInteger)integerForKey:(NSString *)defaultName;

- (float)floatForKey:(NSString *)defaultName;

- (double)doubleForKey:(NSString *)defaultName;

- (BOOL)boolForKey:(NSString *)defaultName;

- (BOOL)setInteger:(NSInteger)value forKey:(NSString *)defaultName;

- (BOOL)setFloat:(float)value forKey:(NSString *)defaultName;

- (BOOL)setDouble:(double)value forKey:(NSString *)defaultName;

- (BOOL)setBool:(BOOL)value forKey:(NSString *)defaultName;

@end
NS_ASSUME_NONNULL_END
