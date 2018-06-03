//
//  SEWUserDefaults+Database.h
//  SEWUserDefaults
//
//  Created by YanWei on 16/10/11.
//  Copyright © 2016年 YanWei. All rights reserved.
//

#import "SEWUserDefaults.h"

NS_ASSUME_NONNULL_BEGIN
@interface SEWUserDefaults (Database)

- (void)createTableIfNotExist;

- (BOOL)replaceIntoValueObject:(id)object forKey:(NSString *)defaultName;

- (BOOL)deleteValueObjectForKey:(NSString *)defaultName;

- (nullable id)valueObjectForKey:(NSString *)defaultName;

@end
NS_ASSUME_NONNULL_END
