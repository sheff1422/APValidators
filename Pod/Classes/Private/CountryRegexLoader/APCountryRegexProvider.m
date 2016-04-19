//
// Created by Nickolay Sheika on 4/13/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APCountryRegexProvider.h"



@implementation APCountryRegexProvider


+ (NSString *)regexForCountryWithCode:(NSString *)countryCode
{
    if (! countryCode) {
        [NSException raise:NSInvalidArgumentException format:@"Country code cannot be nil!"];
    }

    if ([countryCode length] != 2) {
        [NSException raise:NSInvalidArgumentException format:@"Country code must be from two letters!"];
    }

    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"ZipRegex" ofType:@"plist"];
    NSDictionary *regexTable = [[NSDictionary alloc] initWithContentsOfFile:path];
    return regexTable[countryCode];
}


@end