//
// Created by Nickolay Sheika on 05.12.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "APEmailValidator.h"

static NSString *const APEmailValidatorRegex = @"^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,4})$";


@implementation APEmailValidator


- (void)validate
{
    [super validate];

    APRegexValidator *regexValidator = [APRegexValidator new];
    regexValidator.regex = APEmailValidatorRegex;
    regexValidator.validationObject = self.validationObject;
    [regexValidator validate];

    self.valid = regexValidator.isValid;
}

@end