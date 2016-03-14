//
// Created by Nickolay Sheika on 12.12.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "APCompoundCreditCardValidator.h"
#import "APCreditCardValidator.h"


@implementation APCompoundCreditCardValidator


- (void)setRequired:(BOOL)required
{
    [super setRequired:required];

    for (APValidator *validator in self.validators) {
        validator.required = self.required;
    }
}


- (void)checkAllValidatorsAndUpdateState
{
    NSMutableString *compoundCreditCardNumber = [NSMutableString string];

    APValidatorState state = APValidatorState_Undefined;
    for (APValidator *validator in self.validators) {
        if ((validator.validationState == APValidatorState_NotValid) ||
            (validator.validationState == APValidatorState_Undefined && validator.isRequired)) {
            state = APValidatorState_NotValid;
            break;
        }

        if (validator.validationState == APValidatorState_Valid) {
            state = APValidatorState_Valid;
            [compoundCreditCardNumber appendString:validator.validationObject];
        }
    }

    if (state == APValidatorState_Undefined && self.isRequired) {
        state = APValidatorState_NotValid;
    }

    if (state == APValidatorState_Valid) {
        APCreditCardValidator *creditCardValidator = [APCreditCardValidator new];
        creditCardValidator.validationObject = [compoundCreditCardNumber copy];
        [creditCardValidator validate];

        state = creditCardValidator.validationState;
    }

    self.validationState = state;
}


@end