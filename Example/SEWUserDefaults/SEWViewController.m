//
//  SEWViewController.m
//  SEWUserDefaults
//
//  Created by YanWei on 06/02/2018.
//  Copyright (c) 2018 YanWei. All rights reserved.
//

#import "SEWViewController.h"

#import <SEWUserDefaults/SEWUserDefaults.h>

@interface SEWViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startTest;

@end

@implementation SEWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testAction:(UIButton *)sender {
    
    SEWUserDefaults *userDefaults = [SEWUserDefaults standardUserDefaults];
    
    {
        NSString *string = @"string", *stringKey = @"stringKey";
        BOOL result = [userDefaults setObject:string forKey:stringKey];
        if (result) {
            NSLog(@"Object:%@ Key:%@ save success.", string, stringKey);
        } else {
            NSLog(@"Object:%@ Key:%@ save fail.", string, stringKey);
        }
        
        NSString *string2 = [userDefaults stringForKey:stringKey];
        NSLog(@"string:%@ for key:%@", string2, stringKey);
    }
    
    {
        NSInteger integer = 1234;
        NSString *integerKey = @"integerKey";
        BOOL result = [userDefaults setInteger:integer forKey:integerKey];
        if (result) {
            NSLog(@"Integer:%@ Key:%@ save success.", @(integer), integerKey);
        } else {
            NSLog(@"Integer:%@ Key:%@ save fail.", @(integer), integerKey);
        }
        
        NSInteger integer2 = [userDefaults integerForKey:integerKey];
        NSLog(@"integer:%@ for key:%@", @(integer2), integerKey);
    }
    
    {
        float floatNum = 1234.1234;
        NSString *floatKey = @"floatKey";
        BOOL result = [userDefaults setFloat:floatNum forKey:floatKey];
        if (result) {
            NSLog(@"Float:%@ Key:%@ save success.", @(floatNum), floatKey);
        } else {
            NSLog(@"Float:%@ Key:%@ save fail.", @(floatNum), floatKey);
        }
        
        float floatNum2 = [userDefaults floatForKey:floatKey];
        NSLog(@"float:%@ for key:%@", @(floatNum2), floatKey);
    }
    
    {
        double doubleNum = 1234567.1234567;
        NSString *doubleKey = @"doubleKey";
        BOOL result = [userDefaults setDouble:doubleNum forKey:doubleKey];
        if (result) {
            NSLog(@"Double:%@ Key:%@ save success.", @(doubleNum), doubleKey);
        } else {
            NSLog(@"Double:%@ Key:%@ save fail.", @(doubleNum), doubleKey);
        }
        
        double doubleNum2 = [userDefaults doubleForKey:doubleKey];
        NSLog(@"double:%@ for key:%@", @(doubleNum2), doubleKey);
    }
    
    {
        BOOL boolVar = YES;
        NSString *boolKey = @"boolKey";
        BOOL result = [userDefaults setBool:boolVar forKey:boolKey];
        if (result) {
            NSLog(@"BOOL:%@ Key:%@ save success.", @(boolVar), boolKey);
        } else {
            NSLog(@"BOOL:%@ Key:%@ save fail.", @(boolVar), boolKey);
        }
        
        BOOL boolVar2 = [userDefaults boolForKey:boolKey];
        NSLog(@"bool:%@ for key:%@", @(boolVar2), boolKey);
    }
}
@end
