//
// Created by Nickolay Sheika on 4/12/16.
// Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APZipValidator.h"
#import "APRegexValidator.h"
#import "APCountryRegexProvider.h"
#import "APValidator+SubclassesOnly.h"



@interface APZipValidator ()


@property(nonatomic, strong) APRegexValidator *regexValidator;
@end



@implementation APZipValidator


- (APRegexValidator *)regexValidator
{
    if (! _regexValidator) {
        _regexValidator = [APRegexValidator new];
    }
    return _regexValidator;
}

- (void)setCountryCode:(NSString *)countryCode
{
    if ([_countryCode isEqualToString:countryCode]) {
        return;
    }

    _countryCode = [countryCode copy];

    NSString *regex = [APCountryRegexProvider regexForCountryWithCode:countryCode];
    self.regexValidator.regex = regex ?: nil;
}

- (void)validate
{
    [super validate];

    if (! self.regexValidator.regex) {
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