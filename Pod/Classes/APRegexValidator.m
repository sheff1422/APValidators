//
// Created by Nickolay Sheika on 25.11.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "APRegexValidator.h"



@implementation APRegexValidator


- (void)validate
{
    if (! self.regex) {
        [NSException raise:NSInvalidArgumentException format:@"Regex validator should have regex before validation!"];
    }

    if ([self.validationObject isKindOfClass:[NSString class]]) {
        NSString *validationString = self.validationObject;
        if ([validationString isEqualToString:@""]) {
            self.validationState = self.required ? APValidatorState_NotValid : APValidatorState_Undefined;
            return;
        }
    }

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.regex];
    BOOL validation = [predicate evaluateWithObject:self.validationObject];
    self.validationState = validation ? APValidatorState_Valid : APValidatorState_NotValid;
}


@end