//
// Created by Nickolay Sheika on 4/12/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APZipValidator.h"
#import "APRegexValidator.h"
#import "APCountryRegexProvider.h"



@interface APZipValidator ()


@property(nonatomic, strong) APRegexValidator *regexValidator;
@end



@implementation APZipValidator


- (void)setCountryCode:(NSString *)countryCode
{
    if ([_countryCode isEqualToString:countryCode]) {
        return;
    }

    _countryCode = [countryCode copy];

    NSString *regex = [APCountryRegexProvider regexForCountryWithCode:countryCode];

    if (regex) {
        self.regexValidator = [APRegexValidator new];
        self.regexValidator.regex = regex;
    }
    else {
        self.regexValidator = nil;
    }
}

- (void)validate
{
    if (! self.regexValidator) {
        NSLog(@"WARNING : APZipValidator has unsupported country code. Will have invalid state.");
        self.valid = NO;
    }
    else {
        self.regexValidator.validationObject = self.validationObject;
        [self.regexValidator validate];
        self.valid = self.regexValidator.isValid;
    }
}


@end